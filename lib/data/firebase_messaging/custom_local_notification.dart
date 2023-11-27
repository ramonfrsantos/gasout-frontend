import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomLocalNotification {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel channel;

  CustomLocalNotification() {
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High importance Notifications',
      description: 'This channel is used for important notification.',
      importance: Importance.max,
    );

    _configureAndroid().then(
        (value) {
          flutterLocalNotificationsPlugin = value;
          initializeNotifications();
        },
    );
  }

  Future<FlutterLocalNotificationsPlugin> _configureAndroid() async {
    var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    return flutterLocalNotificationsPlugin;
  }

  initializeNotifications() {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    final iOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: (_, __, ___, ____) {},
    );

    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(android: android, iOS: iOS),
    );
  }

  androidNotification(
      RemoteNotification notification,
      AndroidNotification android,
      ) {
    flutterLocalNotificationsPlugin.show(notification.hashCode, notification.title, notification.body, NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        icon: android.smallIcon,
      ),
    ));
  }
}