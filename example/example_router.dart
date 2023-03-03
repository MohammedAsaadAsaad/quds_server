import 'package:quds_server/quds_server.dart';

import 'example_controller.dart';

class ExampleRouter extends QudsRouter<ExampleController> {
  ExampleRouter() : super(controllerBuilder: () => ExampleController());

  // All requests on this router will be like: http://localhost:2028/example/some
  @override
  String get prefix => 'example';

  @override
  List<QudsRouterHandler> get routes => [
        QudsRouterHandler(
            routePath: 'some',
            method: RouteMethod.get,
            handler: (r) => controller!.getSomeInfo(r))
      ];
}
