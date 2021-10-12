part of quds_server;

/// A middleware to print the requested routes
class LoggingMiddleware extends QudsMiddleware {
  /// Create an instance of [LoggingMiddleware]
  LoggingMiddleware() : super(middleware: logRequests());
}
