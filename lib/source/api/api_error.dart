import 'api_response.dart';

class ApiError {
  const ApiError({
    this.message,
    this.code,
  });

  ApiError.fromResponse(ApiResponse response)
      : message = response.message,
        code = response.code;

  final String message;
  final String code;
}
