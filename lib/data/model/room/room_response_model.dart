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
  late int sensorValue;
  UserRoom? user;
  RoomDetails? details;
  late bool notificationOn;
  late bool alarmOn;
  late bool sprinklersOn;

  DataRoom({this.id, required this.sensorValue, this.user, this.details, required this.notificationOn, required this.alarmOn, required this.sprinklersOn});

  DataRoom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sensorValue = json['sensorValue'];
    user = (json['user'] != null ? new UserRoom.fromJson(json['user']) : null)!;
    details = (json['details'] != null ? new RoomDetails.fromJson(json['details']) : null)!;
    notificationOn = json['notificationOn'];
    alarmOn = json['alarmOn'];
    sprinklersOn = json['sprinklersOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sensorValue'] = this.sensorValue;
    data['user'] = this.user?.toJson();
    data['details'] = this.details?.toJson();
    data['notificationOn'] = this.notificationOn;
    data['alarmOn'] = this.alarmOn;
    data['sprinklersOn'] = this.sprinklersOn;

    return data;
  }
}

class UserRoom {
  String? email;

  UserRoom({this.email});

  UserRoom.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}

class RoomDetails {
  late int nameId;
  String? nameDescription;

  RoomDetails({required this.nameId, this.nameDescription});

  RoomDetails.fromJson(Map<String, dynamic> json) {
    nameId = json['nameId'];
    nameDescription = json['nameDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameId'] = this.nameId;
    data['nameDescription'] = this.nameDescription;

    return data;
  }
}
