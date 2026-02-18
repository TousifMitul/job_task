import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'alarm_model.dart';
import '../../helpers/date_time_helper.dart';

class HomeController extends ChangeNotifier {
  final List<AlarmModel> _alarms = [];
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  List<AlarmModel> get alarms => List.unmodifiable(_alarms);

  HomeController() {
    _initTimeZone();
    _initNotifications();
  }

  void _initTimeZone() {
    tz.initializeTimeZones();
  }

  Future<void> _initNotifications() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings =
    DarwinInitializationSettings();
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(settings: settings);
  }

  void addAlarm(DateTime date, TimeOfDay time) {
    final dateTime = DateTimeHelper.combineDateAndTime(date, time);

    final alarm = AlarmModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      time: DateTimeHelper.formatTime(time.hour, time.minute),
      date: DateTimeHelper.formatDate(date),
      dateTime: dateTime,
    );

    _alarms.add(alarm);
    _scheduleNotification(alarm);
    notifyListeners();
  }

  Future<void> _scheduleNotification(AlarmModel alarm) async {
    // Convert DateTime to TZDateTime
    final tzDateTime = _convertToTZ(alarm.dateTime);

    await _notificationsPlugin.zonedSchedule(
      id: int.parse(alarm.id),
      title: 'Travel Alarm',
      body:
      'Time for your travel alarm!',
      scheduledDate: tzDateTime,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel',
          'Travel Alarms',
          channelDescription: 'Channel for travel alarm notifications',
          importance: Importance.high,
          priority: Priority.high,
          fullScreenIntent: true,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

    );
  }

  tz.TZDateTime _convertToTZ(DateTime dateTime) {
    return tz.TZDateTime.from(dateTime, tz.local);
  }

  void toggleAlarm(String id, bool value) {
    final index = _alarms.indexWhere((alarm) => alarm.id == id);
    if (index != -1) {
      _alarms[index].isActive = value;
      notifyListeners();
    }
  }

  void removeAlarm(String id) {
    _alarms.removeWhere((alarm) => alarm.id == id);
    notifyListeners();
  }

  // Optional: Cancel a specific notification
  Future<void> cancelAlarmNotification(String id) async {
    await _notificationsPlugin.cancel(id: int.parse(id));
  }

  // Optional: Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}