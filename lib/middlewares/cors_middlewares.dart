part of quds_server;

final _corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
  'Access-Control-Allow-Headers': 'Origin, Content-Type',
};

/// A middleware to provide the response with cors headers if `OPTIONS` method recieved.
class CorsMiddleware extends QudsMiddleware {
  /// Create an instance of [CorsMiddleware]
  CorsMiddleware()
      : super(
            middleware: createMiddleware(requestHandler: (r) {
          if (r.method == 'OPTIONS') {
            return responseApiOk(headers: _corsHeaders);
          }
          return null;
        }, responseHandler: (r) {
          return r.change(headers: _corsHeaders);
        }));
}
