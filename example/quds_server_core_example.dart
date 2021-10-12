import 'package:quds_server/quds_server.dart';
import 'example_router.dart';

late QudsServer server;
void main() {
  server = QudsServer(
      appName: 'Example App',
      configurations: ServerConfigurations(
          port: 2028, secretKey: 'asadl-ad3234-1312-1232ed-asd'),
      routers: [ExampleRouter()]);

  server.start();
}
