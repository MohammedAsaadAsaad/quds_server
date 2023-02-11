part of quds_server;

class UserWebSocket {
  final dynamic userId;
  final WebSocketChannel ws;

  UserWebSocket({required this.userId, required this.ws});
}
