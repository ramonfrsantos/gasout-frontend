class UserModel {
  String? id;
  String? name;
  String? login;
  String? email;
  String? password;

  UserModel({this.id, this.name, this.login, this.email, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    login = json['login'];
    email = json['email'];
    password = json['password'];
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      login: map['login'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['login'] = this.login;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}