part of quds_server;

class TokenPair {
  final String idToken;
  final String refreshToken;
  TokenPair(this.idToken, this.refreshToken);

  Map<String, dynamic> toJson() =>
      {'token': idToken, 'refresh_token': refreshToken};
}
