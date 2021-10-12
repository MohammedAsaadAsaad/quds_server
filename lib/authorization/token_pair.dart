part of quds_server;

/// Combine current token with refresh token.
class TokenPair {
  /// The current token.
  final String idToken;

  /// The refresh token to regenerate the expired token.
  final String refreshToken;

  /// Create an instance of [TokenPair].
  TokenPair(this.idToken, this.refreshToken);

  /// Get a json map of [TokenPair].
  Map<String, dynamic> toJson() =>
      {'token': idToken, 'refresh_token': refreshToken};
}
