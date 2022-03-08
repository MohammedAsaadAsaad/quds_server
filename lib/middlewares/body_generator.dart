part of quds_server;

class BodyGeneratorMiddleware extends QudsMiddleware {
  BodyGeneratorMiddleware()
      : super(middleware: (Handler innerHandler) {
          return (Request request) async {
            final updateRequest =
                request.change(context: {'bodyJson': await request.bodyAsJson});
            return await innerHandler(updateRequest);
          };
        });
}
