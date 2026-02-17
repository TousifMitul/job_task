import 'package:flutter/material.dart';

class DateTimeHelper {
  static String formatTime(int hour, int minute) {
    final period = hour >= 12 ? 'pm' : 'am';
    final hourIn12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '$hourIn12:${minute.toString().padLeft(2, '0')} $period';
  }

  static String formatDate(DateTime date) {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    return '${days[date.weekday % 7]} ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  static DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }
}