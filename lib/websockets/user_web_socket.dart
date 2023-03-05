part of quds_server;

class UserWebSocket {
  final dynamic userId;
  final WebSocketChannel ws;

  UserWebSocket({required this.userId, required this.ws}) {
    subscription = ws.stream.listen((event) {}, onDone: onClose);
  }

  void onClose() {
    // workaround for https://github.com/dart-lang/sdk/issues/27414
    if (subscription != null) {
      subscription!.cancel();
      subscription = null;
      print('released web socket stream');
    }
  }

  StreamSubscription? subscription;
}
