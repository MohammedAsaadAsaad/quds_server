part of quds_server;

class QudsServer {
  final String appName;
  final ServerConfigurations configurations;
  final List<QudsRouter> routers;
  final List<QudsMiddleware>? middlewares;
  TokenService? _tokenService;

  TokenService? get tokenService => _tokenService;

  QudsServer({
    required this.appName,
    required this.configurations,
    required this.routers,
    this.middlewares,
  });

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
          '[$appName] started serving at:  ${configurations.host}:${configurations.port}'));
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
