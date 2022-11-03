// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    required this.multicastId,
    required this.success,
    required this.failure,
    required this.canonicalIds,
    // required this.results,
  });

  final double? multicastId;
  final int? success;
  final int? failure;
  final int? canonicalIds;
  // final List<Result>? results;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    multicastId: json["multicast_id"] == null ? null : json["multicast_id"].toDouble(),
    success: json["success"] == null ? null : json["success"],
    failure: json["failure"] == null ? null : json["failure"],
    canonicalIds: json["canonical_ids"] == null ? null : json["canonical_ids"],
    // results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "multicast_id": multicastId == null ? null : multicastId,
    "success": success == null ? null : success,
    "failure": failure == null ? null : failure,
    "canonical_ids": canonicalIds == null ? null : canonicalIds,
    // "results": results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    required this.messageId,
  });

  final String messageId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    messageId: json["message_id"] == null ? null : json["message_id"],
  );

  Map<String, dynamic> toJson() => {
    "message_id": messageId,
  };
}
