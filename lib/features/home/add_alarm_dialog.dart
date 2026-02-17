import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../common_widgets/custom_button.dart';

class AddAlarmDialog extends StatefulWidget {
  final Function(DateTime, TimeOfDay) onAlarmAdded;

  const AddAlarmDialog({
    Key? key,
    required this.onAlarmAdded,
  }) : super(key: key);

  @override
  State<AddAlarmDialog> createState() => _AddAlarmDialogState();
}

class _AddAlarmDialogState extends State<AddAlarmDialog> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set Alarm',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(_selectedDate == null
                  ? 'Select Date'
                  : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
              onTap: _selectDate,
              tileColor: AppColors.alarmTileBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(_selectedTime == null
                  ? 'Select Time'
                  : 'Time: ${_selectedTime!.format(context)}'),
              onTap: _selectTime,
              tileColor: AppColors.alarmTileBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Add Alarm',
              onPressed: (_selectedDate != null && _selectedTime != null)
                  ? () {
                widget.onAlarmAdded(_selectedDate!, _selectedTime!);
                Navigator.pop(context);
              }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}