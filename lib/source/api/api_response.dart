class ApiResponse {
  String message;
  String errorCode;
  String appVersion;
  dynamic data;

  ApiResponse.fromJson(Map<String, dynamic> json)
      :
        errorCode = json['errorCode'] as String,
        message = json['message'] as String,
        appVersion = json['appVersion'] as String,
        data = json['data'];
}
