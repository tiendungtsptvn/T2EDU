class ApiResponse {
  String message;
  String code;
  dynamic data;

  ApiResponse.fromJson(Map<String, dynamic> json)
      :
        code = json['code'] as String,
        message = json['message'] as String,
        data = json['data'];
}

