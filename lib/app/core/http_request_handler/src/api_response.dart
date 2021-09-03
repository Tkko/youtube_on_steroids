part of http_request_handler;

abstract class ApiResponse {
  final Response response;
  final exception;

  ApiResponse({
    this.response,
    this.exception,
  });
}

class ApiSuccessResponse extends ApiResponse {
  ApiSuccessResponse(Response response) : super(response: response);
}

class ApiFailureResponse extends ApiResponse {
  String get message => 'Error occurred with code ${response.statusCode}';

  ApiFailureResponse({exception, String url, Response response})
      : super(response: response, exception: exception);
}
