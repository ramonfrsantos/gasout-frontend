
class RoomResponseModel {
  late DataRoom data;

  RoomResponseModel({required this.data});

  RoomResponseModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? new DataRoom.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data.toJson();

    return data;
  }
}

class DataRoom {
  String? id;
  late String name;
  late String userEmail;
  late int sensorValue;
  User? user;

  DataRoom({this.id, required this.name, required this.userEmail, required this.sensorValue, this.user});

  DataRoom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userEmail = json['userEmail'];
    sensorValue = json['sensorValue'];
    user = (json['user'] != null ? new User.fromJson(json['user']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['userEmail'] = this.userEmail;
    data['sensorValue'] = this.sensorValue;
    data['user'] = this.user?.toJson();

    return data;
  }
}

class User {
  String? id;
  String? name;
  String? email;

  User({this.id, this.name, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
