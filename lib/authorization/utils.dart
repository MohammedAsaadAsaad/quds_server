part of quds_server;

/// Generate random salt for hashing passwords.
String generateSalt([int length = 32]) {
  final rand = Random.secure();
  final saltBytes = List<int>.generate(length, (_) => rand.nextInt(256));
  return base64.encode(saltBytes);
}

/// Hash a password using the passed salt.
String hashPassword(String password, String salt) {
  final codec = Utf8Codec();
  final key = codec.encode(password);
  final saltBytes = codec.encode(salt);
  final hmac = Hmac(sha256, key);
  final digest = hmac.convert(saltBytes);
  return digest.toString();
}

/// Generate a Json Web Token.
String generateJwt(
    String subject, String issuer, TokenServiceConfigurations configurations,
    {String? jwtId, required Duration expiryDuration}) {
  final jwt = JWT({'iat': DateTime.now().millisecondsSinceEpoch},
      subject: subject, issuer: issuer, jwtId: jwtId);

  return jwt.sign(SecretKey(configurations.secretKey),
      expiresIn: expiryDuration);
}

/// Verify if the token is valid and return its related JWT
dynamic verifyJwt(String token, String secret) {
  try {
    final jwt = JWT.verify(token, SecretKey(secret));
    return jwt;
  } on JWTExpiredException catch (err) {
    print(err);
  } on JWTException catch (err) {
    print(err);
  }
}
