part of quds_server;

class InjectAuthorizationDetailsMiddleware extends QudsMiddleware {
  final String secretKey;
  InjectAuthorizationDetailsMiddleware(this.secretKey)
      : super(middleware: (Handler innerHandler) {
          return (Request request) async {
            final authHeader = request.headers['authorization'];
            dynamic token, jwt;
            if (authHeader != null && authHeader.startsWith('Bearer ')) {
              token = authHeader.substring(7);
              jwt = verifyJwt(token, secretKey);
            }

            final updateRequest = request.change(context: {'authDetails': jwt});

            return await innerHandler(updateRequest);
          };
        });
}

class AuthorizationCheckerMiddleware extends QudsMiddleware {
  AuthorizationCheckerMiddleware()
      : super(middleware: createMiddleware(requestHandler: (Request request) {
          if (request.context['authDetails'] == null) {
            return responseApiForbidden(
                message: 'Not authorized to perform this action!');
          }
          return null;
        }));
}
