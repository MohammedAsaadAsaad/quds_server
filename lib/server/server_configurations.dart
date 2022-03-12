part of quds_server;

/// The server configurations
class ServerConfigurations {
  final SecurityContext? securityContext;

  /// The main host address of this server app.
  final String host;

  /// The port of this server app.
  final int port;

  /// The secret key of this server app.
  final String secretKey;

  /// Weather to enable  logging.
  final bool? enableLogging;
  final bool? automaticDecodeBodyAsJson;

  /// Weather to enable http connections logging.
  final bool? enableRequestsLogging;

  /// Weather to initialize the authorization + token service.
  final bool? enableAuthorization;

  /// Weather the app is running in debug mode.
  final bool isDebugMode;

  final Object? Function(Object? obj)? responseJsonEncoder;

  /// The token service configurations.
  TokenServiceConfigurations? tokenServiceConfigurations;

  /// Create an instance of [ServerConfigurations]
  ServerConfigurations(
      {this.host = 'localhost',
      this.securityContext,
      this.port = 8080,
      this.automaticDecodeBodyAsJson = true,
      required this.secretKey,
      this.tokenServiceConfigurations,
      this.enableLogging = true,
      this.enableRequestsLogging,
      this.enableAuthorization = true,
      this.isDebugMode = true,
      this.responseJsonEncoder}) {
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
