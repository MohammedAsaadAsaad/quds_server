part of quds_server;

class BodyGeneratorMiddleware extends QudsMiddleware {
  BodyGeneratorMiddleware()
      : super(middleware: (Handler innerHandler) {
          return (Request request) async {
            var read = request.read();
            var encoding = request.encoding ?? utf8;
            var bodyJson = await encoding.decodeStream(read);
            final updateRequest = request
                .change(context: {'bodyStream': read, 'bodyJson': bodyJson});
            return await innerHandler(updateRequest);
          };
        });
}
