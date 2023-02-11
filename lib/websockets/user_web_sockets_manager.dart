part of quds_server;

abstract class UserWebSocketsManager {
  static final Map<dynamic, List<UserWebSocket>> _sockets = {};

  static void addUserSocket(dynamic userId, WebSocketChannel ws) {
    if (ws.closeCode != null) return;
    _closeInActiveSockets();
    _sockets[userId] ??= [];
    _sockets[userId]!.add(UserWebSocket(userId: userId, ws: ws));
  }

  static void _closeInActiveSockets() {
    for (var k in _sockets.keys) {
      _closeUserInActiveSockets(k);
      if (_sockets[k]!.isEmpty) _sockets.remove(k);
    }
  }

  static void _closeUserInActiveSockets(dynamic userId) {
    if (!_sockets.containsKey(userId)) return;

    List<UserWebSocket> socketsToClose = [];
    for (var s in _sockets[userId]!) {
      if (s.ws.closeCode != null) {
        socketsToClose.add(s);
      }
    }

    if (socketsToClose.isNotEmpty) {
      for (var s in socketsToClose) {
        _sockets.remove(s);
      }
    }
  }

  static Iterable<UserWebSocket> getUserSockets(dynamic userId) {
    _closeInActiveSockets();
    return _sockets[userId] ?? [];
  }

  static void sendDataToUser(dynamic userId, Map<String, dynamic> data) {
    for (var s in getUserSockets(userId)) {
      if (s.ws.closeCode != null) {
        s.ws.sink.add(json.encode(data, toEncodable: serverDefaultJsonEncoder));
      }
    }

    _closeInActiveSockets();
  }

  static void sendDataToAllUsers(Map<String, dynamic> data) {
    for (var group in _sockets.entries) {
      for (var s in group.value) {
        if (s.ws.closeCode == null) {
          s.ws.sink
              .add(json.encode(data, toEncodable: serverDefaultJsonEncoder));
        }
      }
    }

    _closeInActiveSockets();
  }
}