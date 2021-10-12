part of quds_server;

/// Inject the request context with user auth details if authorized
class InjectAuthorizationDetailsMiddleware extends QudsMiddleware {
  /// The secret key to verify the caller user.
  final String secretKey;

  /// Create an instance of [InjectAuthorizationDetailsMiddleware]
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

/// A middleware to prevent unauthorized users to connect the server apis.
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
