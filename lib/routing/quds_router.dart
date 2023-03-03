part of quds_server;

/// A base class of the routers
abstract class QudsRouter<T extends QudsController> {
  /// The related controller of this router
  T Function()? controllerBuilder;
  final bool singletonController;

  /// The prefix of this router (eg: /users/)
  final String prefix;

  /// Create an instance of [QudsRouter]
  QudsRouter(
      {this.prefix = '',
      this.controllerBuilder,
      this.singletonController = false});

  /// The sub routes
  List<QudsRouterHandler> get routes;

  /// Mount rhis router and its sub router on the server app
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

  T? _controller;
  T? _getController() {
    if (singletonController) {
      _controller ??= controllerBuilder?.call();
      return _controller;
    } else {
      return controllerBuilder?.call();
    }
  }

  T? get controller => _getController();
}
