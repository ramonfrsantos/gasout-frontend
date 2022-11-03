class LoginResponseModel {
  String? userId;
  String? login;
  String? token;
  String? refreshToken;
  String? userName;

  LoginResponseModel(
      {this.userId, this.login, this.token, this.refreshToken, this.userName});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    login = json['login'];
    token = json['token'];
    refreshToken = json['refreshToken'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['login'] = this.login;
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    data['userName'] = this.userName;
    return data;
  }
}