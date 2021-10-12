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
  QudsServer({
    required this.appName,
    required this.configurations,
    required this.routers,
    this.middlewares,
  });

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
    var result = serve(appHandler, configurations.host, configurations.port);

    return result
      ..then((value) => _logMessage(
          '[$appName] started serving at:  http://${configurations.host}:${configurations.port}'));
  }

  Handler _getAppHandler(Router app) {
    Pipeline result = Pipeline();

    // Inject the middlewares
    List<QudsMiddleware> middlewares = [
      CorsMiddleware(),
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
}
