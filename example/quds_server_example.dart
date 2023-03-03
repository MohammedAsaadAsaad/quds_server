import 'dart:math';

import 'package:quds_server/quds_server.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
// import 'cli_commands/some_command.dart';
import 'example_router.dart';

late QudsServer server;
void main() {
  server = QudsServer(
      // cliCommands: [SomeCommand()],
      appName: 'Example App',
      configurations: ServerConfigurations(
          // securityContext: SecurityContext.defaultContext,
          port: 2028,
          webSocketPort: 2211,
          enableAuthorization: false,
          secretKey: 'asadl-ad3234-1312-1232ed-asd'),
      validateUserWebSocket: validateUserSockets,
      routers: [ExampleRouter()]);

  server.start();

  serverDefaultJsonEncoder = encodeJson;
}

Future<int?> validateUserSockets(
    WebSocketChannel ws, Map<String, String> headers) async {
  //Check user

  // Return some random user
  return Random().nextInt(1000);
}

Object? encodeJson(Object? obj) {
  if (obj is DateTime) return obj.toString();

  return obj;
}
