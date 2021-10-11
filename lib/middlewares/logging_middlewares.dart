part of quds_server;

class LoggingMiddleware extends QudsMiddleware {
  LoggingMiddleware() : super(middleware: logRequests());
}
