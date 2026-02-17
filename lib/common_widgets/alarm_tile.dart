import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../features/home/alarm_model.dart';

class AlarmTile extends StatelessWidget {
  final AlarmModel alarm;
  final ValueChanged<bool> onToggle;

  const AlarmTile({
    Key? key,
    required this.alarm,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.alarmTileBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                alarm.time,
                style: AppTextStyles.alarmTime,
              ),
              const SizedBox(height: 4),
              Text(
                alarm.date,
                style: AppTextStyles.alarmDate,
              ),
            ],
          ),
          Switch(
            value: alarm.isActive,
            onChanged: onToggle,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}