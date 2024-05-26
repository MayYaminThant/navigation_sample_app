import 'dart:async';

import 'package:dh_mobile/src/presentations/widgets/super_print.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class Noti {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future<NotificationDetails> _notificationDetail() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          //'channel description',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          icon: "@mipmap/ic_launcher"),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future<void> init({bool initSchedule = false}) async {
    final StreamController<ReceivedNotification>
        didReceiveLocalNotificationStream =
        StreamController<ReceivedNotification>.broadcast();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationStream.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      },
    );
    final settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    await _notifications.initialize(settings,
        onDidReceiveNotificationResponse: (payload) async {
      ///TODO
      superPrint('notification initialize');
      superPrint('initial message oppended $payload');
    });
  }

  static Future<void>  showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetail(),
        payload: payload,
      );
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
