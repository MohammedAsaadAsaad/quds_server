part of quds_server;

class TokenServiceConfigurations {
  final String secretKey;
  final String prefix;
  final String host;
  final int port;
  final Duration? tokenExpiryDuration;
  final Duration? refreshTokenExpiryDuration;

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
