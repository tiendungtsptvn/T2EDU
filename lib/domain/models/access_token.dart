class Token {
  String refreshToken;
  String accessToken;
  num userId;

  Token({this.refreshToken, this.accessToken,this.userId});

  Token.fromJson(Map<String, dynamic> json) {
    refreshToken = json['refreshToken'];
    accessToken = json['accessToken'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
      data['refreshToken'] = this.refreshToken;
    data['accessToken'] = this.accessToken;
    data['userId'] = this.userId;
    return data;
  }
}

class AccessTokens {
  String accessToken;

  AccessTokens({this.accessToken});

  AccessTokens.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    return data;
  }
}