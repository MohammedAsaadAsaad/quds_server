part of quds_server;

/// A class combines token service configurations
class TokenServiceConfigurations {
  /// The secret key of this service.
  final String secretKey;

  /// The prefix of redis db.
  final String prefix;

  /// The host of redis db service.
  final String host;

  /// The port of redis db service.
  final int port;

  /// The default duration of the user token to expire.
  final Duration? tokenExpiryDuration;

  /// The default duration of the user refresh token to expire.
  final Duration? refreshTokenExpiryDuration;

  /// Create an instance of [TokenServiceConfigurations]
  const TokenServiceConfigurations(
      {required this.secretKey,
      required this.prefix,
      required this.host,
      required this.port,
      this.tokenExpiryDuration,
      this.refreshTokenExpiryDuration});

  @override
  bool operator ==(Object other) {
    if (other is! TokenServiceConfigurations) return false;

    return secretKey == other.secretKey &&
        prefix == other.prefix &&
        host == other.host &&
        port == other.port &&
        tokenExpiryDuration == other.tokenExpiryDuration &&
        refreshTokenExpiryDuration == other.refreshTokenExpiryDuration;
  }

  @override
  int get hashCode => '$prefix|$secretKey|$host:$port'.hashCode;
}
