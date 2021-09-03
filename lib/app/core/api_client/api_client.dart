import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/app/core/api_client/api_constants.dart';
import 'package:youtube_on_steroids/app/core/http_request_handler/http_request_handler.dart';

@immutable
abstract class Repo {
  HttpRequestHandler get httpRequestHandler =>
      locator<ApiClient>().httpRequestHandler;
}

class ApiClient {
  final httpRequestHandler = HttpRequestHandler(host: ENVIRONMENT.API_URL);

  Stream<ApiResponse> get responseStream => httpRequestHandler.responseStream;

  Future<ApiResponse> getWords() => httpRequestHandler.invokeAPI(
      httpMethod: HttpMethod.GET, path: ENVIRONMENT.WORDS_URL);
}
