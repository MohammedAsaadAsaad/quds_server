part of quds_server;

class ServerConfigurations {
  final String host;
  final int port;
  final String secretKey;
  final bool? enableLogging;
  final bool? enableRequestsLogging;
  final bool? enableAuthorization;
  final bool isDebugMode;

  TokenServiceConfigurations? tokenServiceConfigurations;

  ServerConfigurations(
      {this.host = 'localhost',
      this.port = 8080,
      required this.secretKey,
      this.tokenServiceConfigurations,
      this.enableLogging = true,
      this.enableRequestsLogging,
      this.enableAuthorization = true,
      this.isDebugMode = true}) {
    if (enableAuthorization == true) {
      tokenServiceConfigurations ??= TokenServiceConfigurations(
          prefix: 'token', host: 'localhost', port: 6379, secretKey: secretKey);
    }
  }

  @override
  bool operator ==(Object? other) {
    if (other is! ServerConfigurations) return false;

    return host == other.host && port == other.port;
  }

  @override
  int get hashCode => '$host:$port'.hashCode;
}
