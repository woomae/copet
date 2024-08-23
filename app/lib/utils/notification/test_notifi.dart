import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pet/main.dart';

void testNotifi() async{
  NotificationDetails details = const NotificationDetails(
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
    android: AndroidNotificationDetails(
      "1",
      "test",
      importance: Importance.max,
      priority: Priority.high,
    ),
  );

  await flutterLocalNotificationsPlugin.show(1, "copet", "태양님이 댓글을 남기셨습니다.", details);
}