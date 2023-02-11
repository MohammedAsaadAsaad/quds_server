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
  TokenService? _tokenService;

  /// To get the token service of this server app
  TokenService? get tokenService => _tokenService;

  /// Create an instance of [QudsServer]
  QudsServer(
      {required this.appName,
      required this.configurations,
      required this.routers,
      this.middlewares,
      this.validateUserWebSocket});

  final Future<int?> Function(
          WebSocketChannel ws, Map<String, String> initialHeaders)?
      validateUserWebSocket;

  /// To start the server app
  Future<HttpServer> start() async {
    assert(configurations.enableAuthorization != null ||
        configurations.enableAuthorization == false ||
        (configurations.enableAuthorization! &&
            configurations.tokenServiceConfigurations != null));

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

    _initializeWebSocket(configurations);
    return result
      ..then((value) => _logMessage(
          '[$appName] started serving at:  http://${configurations.host}:${configurations.port}'));
  }

  Handler _getAppHandler(Router app) {
    Pipeline result = Pipeline();

    // Inject the middlewares
    List<QudsMiddleware> middlewares = [
      CorsMiddleware(),
      if (configurations.automaticDecodeBodyAsJson == true)
        BodyGeneratorMiddleware(),
      if (configurations.enableRequestsLogging == true) LoggingMiddleware(),
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

  void _initializeWebSocket(ServerConfigurations configs) async {
    if (configs.webSocketPort == null) return;

    // var handler = createWebSocketHandler((ws, _) async {
    //   await validateUserWebSocket?.call(ws);
    // });
    await serve(
        WebSocketHandler(
                (WebSocketChannel ws, Map<String, String> headers) async {
          if (validateUserWebSocket != null) {
            var result = await validateUserWebSocket?.call(ws, headers);
            if (result != null) UserWebSocketsManager.addUserSocket(result, ws);
          }
        }, null, null, null)
            .handle,
        configs.host,
        configs.webSocketPort!);
    print('Serving at ws://${configs.host}:${configs.webSocketPort}');
  }

  FutureOr<Response> createWebSocketHandler(Request request) async {
    return responseApiOk();
  }
}
