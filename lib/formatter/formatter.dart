part of quds_server;

String _encodeResponse(
    {int apiStatus = 0,
    int serverStatus = 200,
    String? message,
    Map<String, dynamic>? data,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  return jsonEncode({
    'api_status': apiStatus,
    'server_status': serverStatus,
    'message': message,
    'data': data
  }, toEncodable: jsonEncodingFunction ?? serverDefaultJsonEncoder);
}

Response _formatResponse(int httpStatus,
    {int apiStatus = 0,
    String? message,
    Encoding? encoding,
    Map<String, dynamic>? data,
    Map<String, Object>? context,
    Map<String, Object>? headers,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  var setHeaders = headers ?? {};
  setHeaders[HttpHeaders.contentTypeHeader] = ContentType.json.mimeType;

  return Response(httpStatus,
      body: _encodeResponse(
          apiStatus: apiStatus,
          serverStatus: httpStatus,
          data: data,
          message: message,
          jsonEncodingFunction: jsonEncodingFunction),
      headers: setHeaders,
      encoding: encoding,
      context: context);
}

/// Get an instance of [Response] with forbidden status
Response responseApiForbidden(
    {int apiStatus = HttpStatus.forbidden,
    String? message,
    Encoding? encoding,
    Map<String, dynamic>? data,
    Map<String, Object>? context,
    Map<String, Object>? headers,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  return _formatResponse(HttpStatus.forbidden,
      apiStatus: apiStatus,
      message: message,
      encoding: encoding,
      data: data,
      context: context,
      headers: headers,
      jsonEncodingFunction: jsonEncodingFunction);
}

/// Get an instance of [Response] with bad request status
Response responseApiBadRequest(
    {int apiStatus = HttpStatus.badRequest,
    String? message,
    Encoding? encoding,
    Map<String, dynamic>? data,
    Map<String, Object>? context,
    Map<String, Object>? headers,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  return _formatResponse(HttpStatus.badRequest,
      apiStatus: apiStatus,
      message: message,
      encoding: encoding,
      data: data,
      context: context,
      headers: headers,
      jsonEncodingFunction: jsonEncodingFunction);
}

/// Get an instance of [Response] with ok status
Response responseApiOk(
    {int apiStatus = 0,
    String? message,
    Encoding? encoding,
    Map<String, dynamic>? data,
    Map<String, Object>? context,
    Map<String, Object>? headers,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  return _formatResponse(HttpStatus.ok,
      apiStatus: apiStatus,
      message: message,
      encoding: encoding,
      data: data,
      context: context,
      headers: headers,
      jsonEncodingFunction: jsonEncodingFunction);
}

/// Get an instance of [Response] with not found status
Response responseApiNotFound(
    {int apiStatus = HttpStatus.notFound,
    String? message,
    Encoding? encoding,
    Map<String, dynamic>? data,
    Map<String, Object>? context,
    Map<String, Object>? headers,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  return _formatResponse(HttpStatus.notFound,
      message: message,
      encoding: encoding,
      data: data,
      context: context,
      apiStatus: apiStatus,
      headers: headers,
      jsonEncodingFunction: jsonEncodingFunction);
}

/// Get an instance of [Response] with internal server error status
Response responseApiInternalServerError(
    {int apiStatus = HttpStatus.internalServerError,
    String? message,
    Encoding? encoding,
    Map<String, dynamic>? data,
    Map<String, Object>? context,
    Map<String, Object>? headers,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  return _formatResponse(HttpStatus.internalServerError,
      message: message,
      apiStatus: apiStatus,
      encoding: encoding,
      data: data,
      context: context,
      headers: headers,
      jsonEncodingFunction: jsonEncodingFunction);
}

/// Provide some methods on request for decoding the recieved body into json map.
extension RequestExtension on Request {
  /// Get the recieved body as json map.
  Future<Map<String, dynamic>> get bodyAsJson async {
    try {
      switch (method) {
        case 'POST':
          context['bodyJson'] ??= jsonDecode(await readAsString()) ?? {};
          return context['bodyJson'] as Map<String, dynamic>;
        case 'GET':
          context['bodyJson'] ??= requestedUri.queryParameters;
          return context['bodyJson'] as Map<String, dynamic>;
        default:
          return {};
      }
    } catch (e) {
      print(e);
      return {};
    }
  }
}

Object? Function(Object? obj)? serverDefaultJsonEncoder;
