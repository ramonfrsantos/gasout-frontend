import 'dart:convert';

class NotificationResponseModel {
  late DataNotification data;

  NotificationResponseModel({required this.data});

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? new DataNotification.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data.toJson();

    return data;
  }
}

class DataNotification {
  String? id;
  late String title;
  late String message;
  late String date;

  DataNotification({
    this.id,
    required this.title,
    required this.date,
    required this.message,
  });

  DataNotification.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        title = json['title'];
        message = json['message'];
        date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['date'] = this.date;

    return data;
  }
}
