import 'dart:convert';

class NotificationResponseModel {
  final int id;
  final String title;
  final String message;
  final String date;
  NotificationResponseModel({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'date': date,
    };
  }

  factory NotificationResponseModel.fromMap(Map<String, dynamic> map) {
    return NotificationResponseModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationResponseModel.fromJson(String source) =>
      NotificationResponseModel.fromMap(json.decode(source));
}
