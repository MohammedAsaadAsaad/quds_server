part of quds_server;

// typedef RouterHandler = Future<Response> ();

/// Define a route with handler
class QudsRouterHandler {
  /// The route path.
  final String routePath;

  /// The http method [GET, POST, PUT, PATCH, DELETE, OPTIONS]
  final RouteMethod method;

  /// The request handler
  final Function handler;

  /// Create an instance of [QudsRouterHandler]
  QudsRouterHandler(
      {required this.routePath,
      this.method = RouteMethod.get,
      required this.handler});
}
