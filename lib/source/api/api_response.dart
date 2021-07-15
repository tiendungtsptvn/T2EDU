class ApiResponse {
  String message;
  String errorCode;
  dynamic data;

  ApiResponse.fromJson(Map<String, dynamic> json)
      :
        errorCode = json['errorCode'] as String,
        message = json['message'] as String,
        data = json['data'];
}
