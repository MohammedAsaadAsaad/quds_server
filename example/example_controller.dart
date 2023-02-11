import 'package:quds_server/quds_server.dart';
import 'package:shelf/shelf.dart';

class ExampleController extends QudsController {
  Future<Response> getSomeInfo(Request req) async {
    await Future.delayed(const Duration(milliseconds: 250));
    //Test websockets
    UserWebSocketsManager.sendDataToAllUsers(
        {'message': 'hi', 'datetime': DateTime.now()});
    return responseApiOk(data: {'some': 10});
  }
}
