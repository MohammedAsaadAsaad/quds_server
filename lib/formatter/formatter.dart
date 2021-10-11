part of quds_server;

String _encodeResponse(
    {int apiStatus = 0,
    int serverStatus = 200,
    String? message,
    Object? data}) {
  return jsonEncode({
    'api_status': apiStatus,
    'server_status': serverStatus,
    'message': message,
    'data': data
  });
}

Response _formatResponse(int httpStatus,
    {int apiStatus = 0,
    String? message,
    Encoding? encoding,
    Object? data,
    Map<String, Object>? context,
    Map<String, Object>? headers}) {
  var setHeaders = headers ?? {};
  setHeaders[HttpHeaders.contentTypeHeader] = ContentType.json.mimeType;

  return Response(httpStatus,
      body: _encodeResponse(
        apiStatus: apiStatus,
        serverStatus: httpStatus,
        data: data,
        message: message,
      ),
      headers: setHeaders,
      encoding: encoding,
      context: context);
}

Response responseApiForbidden(
    {int apiStatus = HttpStatus.forbidden,
    String? message,
    Encoding? encoding,
    Object? data,
    Map<String, Object>? context,
    Map<String, Object>? headers}) {
  return _formatResponse(HttpStatus.forbidden,
      apiStatus: apiStatus,
      message: message,
      encoding: encoding,
      data: data,
      context: context,
      headers: headers);
}

Response responseApiBadRequest(
    {int apiStatus = HttpStatus.badRequest,
    String? message,
    Encoding? encoding,
    Object? data,
    Map<String, Object>? context,
    Map<String, Object>? headers}) {
  return _formatResponse(HttpStatus.badRequest,
      apiStatus: apiStatus,
      message: message,
      encoding: encoding,
      data: data,
      context: context,
      headers: headers);
}

Response responseApiOk(
    {int apiStatus = 0,
    String? message,
    Encoding? encoding,
    Object? data,
    Map<String, Object>? context,
    Map<String, Object>? headers}) {
  return _formatResponse(HttpStatus.ok,
      apiStatus: apiStatus,
      message: message,
      encoding: encoding,
      data: data,
      context: context,
      headers: headers);
}

Response responseApiNotFound(
    {int apiStatus = HttpStatus.notFound,
    String? message,
    Encoding? encoding,
    Object? data,
    Map<String, Object>? context,
    Map<String, Object>? headers}) {
  return _formatResponse(HttpStatus.notFound,
      message: message,
      encoding: encoding,
      data: data,
      context: context,
      apiStatus: apiStatus,
      headers: headers);
}

Response responseApiInternalServerError(
    {int apiStatus = HttpStatus.internalServerError,
    String? message,
    Encoding? encoding,
    Object? data,
    Map<String, Object>? context,
    Map<String, Object>? headers}) {
  return _formatResponse(HttpStatus.internalServerError,
      message: message,
      apiStatus: apiStatus,
      encoding: encoding,
      data: data,
      context: context,
      headers: headers);
}

extension RequestExtension on Request {
  Future<Map<String, dynamic>> get bodyAsJson async {
    try {
      return jsonDecode(await readAsString()) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }
}
