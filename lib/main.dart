import 'package:flutter/material.dart';
import 'package:job_task/features/home/home_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import 'app.dart';

void main () async{
 WidgetsFlutterBinding.ensureInitialized();
 HomeController.init();
 HomeController.initTimeZone();
 final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
 HomeController.notificationsPlugin
     .resolvePlatformSpecificImplementation<
     AndroidFlutterLocalNotificationsPlugin
 >();

 await androidImplementation?.requestNotificationsPermission();
  runApp( MyApp());
}