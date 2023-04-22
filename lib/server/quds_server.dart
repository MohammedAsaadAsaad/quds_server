part of quds_server;

/// Define the server app
class QudsServer {
  /// The app name.
  final String appName;

  /// The server configurations
  final ServerConfigurations configurations;

  /// The server routers
  final List<QudsRouter> routers;

  /// The injected middlewares
  final List<QudsMiddleware>? middlewares;
  final List<CliCommand>? cliCommands;

  TokenService? _tokenService;

  /// To get the token service of this server app
  TokenService? get tokenService => _tokenService;

  /// Create an instance of [QudsServer]
  QudsServer(
      {required this.appName,
      required this.configurations,
      required this.routers,
      this.middlewares,
      this.validateUserWebSocket,
      this.cliCommands});

  final Future<dynamic> Function(
          WebSocketChannel ws, Map<String, String> initialHeaders)?
      validateUserWebSocket;

  /// To start the server app
  Future<HttpServer> start() async {
    assert(configurations.enableAuthorization != null ||
        configurations.enableAuthorization == false ||
        (configurations.enableAuthorization! &&
            configurations.tokenServiceConfigurations != null));

    Map<String, CliCommand>? commandsMap;
    if (cliCommands != null && cliCommands!.isNotEmpty) {
      commandsMap = {};
      cliCommands!.insert(0, _HelpCommand(commandsMap));
      cliCommands!.insert(0, _ExitCommand());
      for (var c in cliCommands!) {
        commandsMap[c.prefix.toLowerCase().trim()] = c;
      }
    }

    if (configurations.enableAuthorization == true) {
      _tokenService ??=
          TokenService(configurations.tokenServiceConfigurations!);
      await _tokenService!.start();
      _logMessage('Tokens Service Started!');
    }

    Router app = Router();
    _mountRouters(app);

    var appHandler = _getAppHandler(app);
    var result = serve(appHandler, configurations.host, configurations.port,
        securityContext: configurations.securityContext);

    await result;
    _logMessage(
        '[$appName] started serving at:  http://${configurations.host}:${configurations.port}');

    await _initializeWebSocket(configurations);

    if (commandsMap != null) handleCliCommands(commandsMap);
    return result;
  }

  Handler _getAppHandler(Router app) {
    Pipeline result = Pipeline();

    // Inject the middlewares
    List<QudsMiddleware> middlewares = [
      CorsMiddleware(),
      if (configurations.automaticDecodeBodyAsJson == true)
        BodyGeneratorMiddleware(),
      //Logging enabled when cli commands are not set
      if (configurations.enableRequestsLogging == true &&
          (cliCommands == null || cliCommands!.isEmpty))
        RequestLoggerMiddleware(),
      if (configurations.enableAuthorization == true)
        InjectAuthorizationDetailsMiddleware(configurations.secretKey),
      if (this.middlewares != null) ...this.middlewares!
    ];
    for (var m in middlewares) {
      result = result.addMiddleware(m.middleware);
    }

    return result.addHandler(app);
  }

  void _mountRouters(Router app) {
    for (var r in routers) {
      r.mountOnRouter(app);
    }
  }

  void _logMessage(String message) {
    if (configurations.enableLogging == true) {
      print(message);
    }
  }

  Future<void> _initializeWebSocket(ServerConfigurations configs) async {
    if (configs.webSocketPort == null) return;

    // var handler = createWebSocketHandler((ws, _) async {
    //   await validateUserWebSocket?.call(ws);
    // });
    try {
      await serve(
        WebSocketHandler(
                (WebSocketChannel ws, Map<String, String> headers) async {
          if (validateUserWebSocket != null) {
            var result = await validateUserWebSocket?.call(ws, headers);
            if (result != null) UserWebSocketsManager.addUserSocket(result, ws);
          }
        }, null, null, configurations.webSockectsPingInterval)
            .handle,
        configs.host,
        configs.webSocketPort!,
      );
      print(
          'Websockets Serving at ws://${configs.host}:${configs.webSocketPort}');
      UserWebSocketsManager._isSocketsServiceRunning = true;
    } catch (e) {
      UserWebSocketsManager._isSocketsServiceRunning = false;
    }
  }

  Future<void> handleCliCommands(Map<String, CliCommand> commands) async {
    var parser = ArgParser.allowAnything();
    stdout.write('$appName> ');
    var entered = stdin.readLineSync();
    if (entered != null && entered.trim().isNotEmpty) {
      var parts = entered.trim().split(' ');
      var prefix = parts[0].trim().toLowerCase();
      var command = commands[prefix];
      if (command == null) {
        AnsiPen pen = AnsiPen()..red(bold: true);
        stdout.writeln(pen("Command [") + prefix + pen('] is not recognized!'));
      } else {
        var args =
            parser.parse([for (int i = 1; i < parts.length; i++) parts[i]]);
        await command.execute(args);
      }
    }

    await handleCliCommands(commands);
  }
}
