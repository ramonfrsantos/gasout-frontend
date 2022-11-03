import 'dart:convert';

class RoomResponseModel {
  final int id;
  final String name;
  final bool notificationOn;
  final bool alarmOn;
  final bool sprinklersOn;
  final int sensorValue;
  final String userEmail;

  RoomResponseModel(
      {required this.id,
      required this.name,
      required this.notificationOn,
      required this.alarmOn,
      required this.sprinklersOn,
      required this.sensorValue,
      required this.userEmail});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': this.name,
      'notificationOn': notificationOn,
      'alarmOn': alarmOn,
      'sprinklersOn': sprinklersOn,
      'sensorValue': sensorValue,
      'userEmail': userEmail,
    };
  }

  factory RoomResponseModel.fromMap(Map<String, dynamic> map) {
    return RoomResponseModel(
      id: map['id'].toInt() ?? 0,
      name: map['name'] ?? '',
      notificationOn: map['notificationOn'],
      alarmOn: map['alarmOn'],
      sprinklersOn: map['sprinklersOn'],
      sensorValue: map['sensorValue'] ?? 0,
      userEmail: map['userEmail'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomResponseModel.fromJson(String source) =>
      RoomResponseModel.fromMap(json.decode(source));
}
