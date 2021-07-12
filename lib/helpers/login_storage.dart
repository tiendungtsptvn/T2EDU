class Account {
  String username;
  String password;
  String lastTime;
  String firstLogin;
  String biometric;

  Account(
      {this.username,
        this.password,
        this.lastTime,
        this.firstLogin,
        this.biometric});

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    username: json['username'],
    password: json['password'],
    lastTime: json['lastTime'],
    firstLogin: json['firstLogin'],
    biometric: json['biometric'],
  );

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'lastTime': lastTime,
    'firstLogin': firstLogin,
    'biometric': biometric
  };
}