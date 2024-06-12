import 'package:flutter/material.dart';
import 'package:reminderapp_test/app.dart';
import 'package:reminderapp_test/cores/local_notification/notification_helper.dart';
import 'di/injection.dart' as di;

void main() async {
  // set widget binding
  WidgetsFlutterBinding.ensureInitialized();

  // set firebase when firebase option ready
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // set configuration local notification
  NotificationHelper.notificationHelper.initialize();
  NotificationHelper.notificationHelper.configureLocalTimeZone();

  // request permission
  // NotificationHelper.requestPermission();

  // set injection
  di.init();

  // run application
  runApp(const MyApp());
}
