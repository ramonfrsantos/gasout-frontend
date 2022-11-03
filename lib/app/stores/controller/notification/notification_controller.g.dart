// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationController on _NotificationControllerBase, Store {
  late final _$notificationListAtom = Atom(
      name: '_NotificationControllerBase.notificationList', context: context);

  @override
  List<NotificationResponseModel>? get notificationList {
    _$notificationListAtom.reportRead();
    return super.notificationList;
  }

  @override
  set notificationList(List<NotificationResponseModel>? value) {
    _$notificationListAtom.reportWrite(value, super.notificationList, () {
      super.notificationList = value;
    });
  }

  late final _$getUserNotificationsAsyncAction = AsyncAction(
      '_NotificationControllerBase.getUserNotifications',
      context: context);

  @override
  Future getUserNotifications(String? login) {
    return _$getUserNotificationsAsyncAction
        .run(() => super.getUserNotifications(login));
  }

  late final _$deleteNotificationAsyncAction = AsyncAction(
      '_NotificationControllerBase.deleteNotification',
      context: context);

  @override
  Future deleteNotification(String id) {
    return _$deleteNotificationAsyncAction
        .run(() => super.deleteNotification(id));
  }

  late final _$createNotificationAsyncAction = AsyncAction(
      '_NotificationControllerBase.createNotification',
      context: context);

  @override
  Future createNotification(
      String title, String body, String? email, String token) {
    return _$createNotificationAsyncAction
        .run(() => super.createNotification(title, body, email, token));
  }

  @override
  String toString() {
    return '''
notificationList: ${notificationList}
    ''';
  }
}
