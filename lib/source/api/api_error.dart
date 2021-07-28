import 'api_response.dart';

class ApiError {
  const ApiError({this.message, this.code, this.data});

  ApiError.fromResponse(ApiResponse response)
      : message = response.message,
        code = response.code,
        data = response.data == null ? null : response.data;

  final String message;
  final String code;
  final String data;
}
