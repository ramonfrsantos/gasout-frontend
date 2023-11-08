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
  late int gasSensorValue;
  late int umiditySensorValue;
  UserRoom? user;
  RoomDetails? details;
  late bool notificationOn;
  late bool alarmOn;
  late bool sprinklersOn;
  List<RecentGasSensorValues>? recentGasSensorValues;

  DataRoom({this.id, required this.gasSensorValue, required this.umiditySensorValue, this.user, this.details, required this.notificationOn, required this.alarmOn, required this.sprinklersOn, this.recentGasSensorValues});

  DataRoom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gasSensorValue = json['gasSensorValue'];
    umiditySensorValue = json['umiditySensorValue'];
    user = (json['user'] != null ? new UserRoom.fromJson(json['user']) : null)!;
    details = (json['details'] != null ? new RoomDetails.fromJson(json['details']) : null)!;
    notificationOn = json['notificationOn'];
    alarmOn = json['alarmOn'];
    sprinklersOn = json['sprinklersOn'];
    if (json['recentGasSensorValues'] != null) {
      recentGasSensorValues = <RecentGasSensorValues>[];
      json['recentGasSensorValues'].forEach((v) {
        recentGasSensorValues!.add(new RecentGasSensorValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gasSensorValue'] = this.gasSensorValue;
    data['umiditySensorValue'] = this.umiditySensorValue;
    data['user'] = this.user?.toJson();
    data['details'] = this.details?.toJson();
    data['notificationOn'] = this.notificationOn;
    data['alarmOn'] = this.alarmOn;
    data['sprinklersOn'] = this.sprinklersOn;
    if (this.recentGasSensorValues != null) {
      data['recentGasSensorValues'] =
          this.recentGasSensorValues!.map((v) => v.toJson()).toList();
    }

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

class RecentGasSensorValues {
  int? sensorValue;
  String? timestamp;

  RecentGasSensorValues({this.sensorValue, this.timestamp});

  RecentGasSensorValues.fromJson(Map<String, dynamic> json) {
    sensorValue = json['sensorValue'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sensorValue'] = this.sensorValue;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
