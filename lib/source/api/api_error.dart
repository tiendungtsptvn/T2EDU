import 'api_response.dart';

class ApiError {
  const ApiError({
    this.message,
    this.errorCode,
  });

  ApiError.fromResponse(ApiResponse response)
      : message = response.message,
        errorCode = response.errorCode;

  final String message;
  final String errorCode;
}
