part of quds_server;

final _corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
  'Access-Control-Allow-Headers': 'Origin, Content-Type',
};

class CorsMiddleware extends QudsMiddleware {
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
