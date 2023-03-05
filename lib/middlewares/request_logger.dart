part of quds_server;

class RequestLoggerMiddleware extends QudsMiddleware {
  RequestLoggerMiddleware({this.minMemoryUsageToColor})
      : super(
            middleware:
                _logRequests(minMemoryUsageToColor: minMemoryUsageToColor));
  final int? minMemoryUsageToColor;
}

Middleware _logRequests(
        {int? minMemoryUsageToColor,
        void Function(String message, bool isError)? logger}) =>
    (innerHandler) {
      final theLogger = logger ?? _defaultLogger;

      return (request) {
        var startTime = DateTime.now();
        var watch = Stopwatch()..start();

        return Future.sync(() => innerHandler(request)).then((response) {
          var msg = _message(startTime, response.statusCode,
              request.requestedUri, request.method, watch.elapsed);

          theLogger(msg, false);

          return response;
        }, onError: (Object error, StackTrace stackTrace) {
          if (error is HijackException) throw error;

          var msg = _errorMessage(startTime, request.requestedUri,
              request.method, watch.elapsed, error, stackTrace);

          theLogger(msg, true);

          throw error;
        });
      };
    };

String _formatQuery(String query) {
  return query == '' ? '' : '?$query';
}

String _message(DateTime requestTime, int statusCode, Uri requestedUri,
    String method, Duration elapsedTime) {
  DateTime rT = requestTime;

  String rTString =
      '${rT.month.toString().padLeft(2, '0')}/${rT.day.toString().padLeft(2, '0')} ${rT.hour.toString().padLeft(2, '0')}:${rT.minute.toString().padLeft(2, '0')}:${rT.second.toString().padLeft(2, '0')}';

  int elapsedInMS = elapsedTime.inMilliseconds;
  String elapsedTimeString = ' [${elapsedInMS.toString().padLeft(4)} ms]';

  AnsiPen methodPen = statusCode == 200
      ? (AnsiPen()
        ..green(bold: true, bg: true)
        ..white(
          bold: true,
        ))
      : (AnsiPen()
        ..red(bold: true, bg: true)
        ..white(
          bold: true,
        ));

  String methodString = '[$statusCode]';

  return '[$rTString] '
      '$elapsedTimeString '
      '${method.padRight(4)} ${methodPen(methodString)} ' // 7 - longest standard HTTP method
      '${requestedUri.path}${_formatQuery(requestedUri.query)}';
}

String _errorMessage(DateTime requestTime, Uri requestedUri, String method,
    Duration elapsedTime, Object error, StackTrace? stack) {
  var chain = Chain.current();
  if (stack != null) {
    chain = Chain.forTrace(stack)
        .foldFrames((frame) => frame.isCore || frame.package == 'shelf')
        .terse;
  }

  var msg = '$requestTime\t$elapsedTime\t$method\t${requestedUri.path}'
      '${_formatQuery(requestedUri.query)}\n$error';

  return '$msg\n$chain';
}

void _defaultLogger(String msg, bool isError) {
  if (isError) {
    print('[ERROR] $msg');
  } else {
    print(msg);
  }
}
