part of quds_server;

// typedef RouterHandler = Future<Response> ();

class QudsRouterHandler {
  final String routePath;
  final RouteMethod method;
  final Function handler;

  QudsRouterHandler(
      {required this.routePath,
      this.method = RouteMethod.get,
      required this.handler});
}
