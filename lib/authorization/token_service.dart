part of quds_server;

/// Class represents the tokens service
class TokenService {
  static final Map<TokenServiceConfigurations, TokenService> _createdServices =
      {};

  /// Create an instance of [TokenService] or get the created one.
  factory TokenService(TokenServiceConfigurations configurations) {
    var instance = _createdServices[configurations];
    if (instance != null) return instance;

    var newInstance = TokenService._(configurations);
    _createdServices[configurations] = newInstance;
    return newInstance;
  }

  TokenService._(this.configurations);

  /// The configuration of this service.
  final TokenServiceConfigurations configurations;

  final RedisConnection _dbConnection = RedisConnection();
  static late Command _cache;
  static final String _prefix = 'token';

  /// Start the tokens service.
  Future<void> start() async {
    _cache =
        await _dbConnection.connect(configurations.host, configurations.port);
  }

  /// Create a token with its related refresh token.
  Future<TokenPair> createTokenPair(
      String userId, TokenServiceConfigurations configurations) async {
    var tokenExpiry =
        configurations.tokenExpiryDuration ?? const Duration(days: 365 * 1);

    var refreshExpiry = configurations.refreshTokenExpiryDuration ??
        const Duration(days: 365 * 2);

    final tokenId = Uuid().v4();
    String subject = 'user:$userId';
    var token = generateJwt(subject, configurations.host, configurations,
        jwtId: tokenId, expiryDuration: tokenExpiry);

    final refreshToken = generateJwt(
        subject, configurations.host, configurations,
        jwtId: tokenId, expiryDuration: refreshExpiry);

    await _addRefreshToken(tokenId, refreshToken, refreshExpiry);

    return TokenPair(token, refreshToken);
  }

  Future<void> _addRefreshToken(
      String id, String token, Duration expiry) async {
    await _cache.send_object(['SET', '$_prefix:$id', token]);
    await _cache.send_object(['EXPIRE', '$_prefix:$id', expiry.inSeconds]);
  }

  /// Get the refresh token related to record id.
  Future<dynamic> getRefreshToken(String id) async {
    return await _cache.get('$_prefix:$id');
  }

  /// remove the refresh token related to record id.
  Future<void> removeRefreshToken(String id) async {
    await _cache.send_object(['EXPIRE', '$_prefix:$id', '-1']);
  }
}
