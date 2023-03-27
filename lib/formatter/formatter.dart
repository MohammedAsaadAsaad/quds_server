part of quds_server;

String _encodeResponse(
    {int apiStatus = 0,
    ServerStatusCode serverStatus = ServerStatusCode.ok,
    String? message,
    dynamic data,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  return jsonEncode({
    'api_status': apiStatus,
    'server_status': serverStatus.code,
    'message': message,
    'data': data
  }, toEncodable: jsonEncodingFunction ?? serverDefaultJsonEncoder);
}

Response _formatResponse(ServerStatusCode httpStatus,
    {int apiStatus = 0,
    String? message,
    Encoding? encoding,
    dynamic data,
    Map<String, Object>? context,
    Map<String, Object>? headers,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  var setHeaders = headers ?? {};
  setHeaders[HttpHeaders.contentTypeHeader] = ContentType.json.mimeType;

  return Response(httpStatus.code,
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
Response responseApi(
    {required ServerStatusCode httpStatus,
    int apiStatus = 0,
    String? message,
    Encoding? encoding,
    dynamic data,
    Map<String, Object>? context,
    Map<String, Object>? headers,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  return _formatResponse(httpStatus,
      apiStatus: apiStatus,
      message: message,
      encoding: encoding,
      data: data,
      context: context,
      headers: headers,
      jsonEncodingFunction: jsonEncodingFunction);
}

/// Get an instance of [Response] with forbidden status
Response responseApiForbidden(
    {int apiStatus = HttpStatus.forbidden,
    String? message,
    Encoding? encoding,
    dynamic data,
    Map<String, Object>? context,
    Map<String, Object>? headers,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  return _formatResponse(ServerStatusCode.forbidden,
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
    dynamic data,
    Map<String, Object>? context,
    Map<String, Object>? headers,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  return _formatResponse(ServerStatusCode.badRequest,
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
    dynamic data,
    Map<String, Object>? context,
    Map<String, Object>? headers,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  return _formatResponse(ServerStatusCode.ok,
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
    dynamic data,
    Map<String, Object>? context,
    Map<String, Object>? headers,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  return _formatResponse(ServerStatusCode.notFound,
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
    dynamic data,
    Map<String, Object>? context,
    Map<String, Object>? headers,
    Object? Function(Object? obj)? jsonEncodingFunction}) {
  return _formatResponse(ServerStatusCode.internalServerError,
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
          return (context['bodyJson'] ??
              jsonDecode(await readAsString()) ??
              {});
        case 'GET':
          return (context['bodyJson'] ?? requestedUri.queryParameters)
              as Map<String, dynamic>;
        default:
          return {};
      }
    } catch (e) {
      print(e);
      return {};
    }
  }

  bool get isMultiPartFormData {
    var contentType = headers['content-type'];
    return contentType?.contains('multipart/form-data') ?? true;
  }
}

Object? Function(Object? obj)? serverDefaultJsonEncoder;
