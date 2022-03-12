import 'package:quds_server/quds_server.dart';
import 'package:shelf/shelf.dart';

class ExampleMiddleware extends QudsMiddleware {
  ExampleMiddleware()
      : super(middleware: createMiddleware(requestHandler: (req) {
          // Inject some value to the request context
          req.context['some_value'] = {};
          return null;
        }));
}
