import 'dart:developer' as developer;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:injectable/injectable.dart';

@singleton
class NotificationManager {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher_round.png');

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    final succeeded = await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (savedCarStr) async {
        // if (savedCarStr != null && savedCarStr.isNotEmpty) {
        //   final car = CarModel.fromJson(json.decode(savedCarStr));
        //   await sl<LocationManager>().saveCarLocation(car);
        //   showNotification(id: 123, title: 'Location Saved');
        // }
      },
    );
    developer.log(succeeded.toString());
  }

  static Future<void> showNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
