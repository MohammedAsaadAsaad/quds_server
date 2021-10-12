part of quds_server;

/// A base class of [QudsMiddleware]
abstract class QudsMiddleware {
  /// The desired middleware.
  final Middleware middleware;

  /// Create an instance of [QudsMiddleware],
  /// provided with const for constant constructors if desired.
  const QudsMiddleware({required this.middleware});
}
