part of quds_server;

abstract class QudsRouter<T extends QudsController> {
  T? controller;

  final String prefix;
  QudsRouter({this.prefix = '', this.controller});
  List<QudsRouterHandler> get routes;

  void mountOnRouter(Router app) {
    Router router = Router();
    for (var r in routes) {
      dynamic methodFunction;
      switch (r.method) {
        case RouteMethod.post:
          methodFunction = router.post;
          break;
        case RouteMethod.get:
          methodFunction = router.get;
          break;
        case RouteMethod.delete:
          methodFunction = router.delete;
          break;
        case RouteMethod.patch:
          methodFunction = router.patch;
          break;
        case RouteMethod.put:
          methodFunction = router.put;
          break;
        default:
          methodFunction = router.get;
      }
      if (methodFunction != null && methodFunction is Function) {
        methodFunction.call(_fixRouteName(r.routePath), r.handler);
      }
    }

    app.mount(_fixRouteName(prefix, forMounting: true), router);
  }

  String _fixRouteName(String routeName, {bool forMounting = false}) {
    if (!routeName.startsWith('/')) {
      // Insert if not exists first slash
      routeName = '/$routeName';
    }

    if (!forMounting) {
      if (routeName.endsWith('/') && routeName != '/') {
        // Remove last /
        routeName = routeName.substring(0, routeName.length - 1);
      }
    } else {
      if (!routeName.endsWith('/')) routeName = '$routeName/';
    }
    return routeName;
  }
}
