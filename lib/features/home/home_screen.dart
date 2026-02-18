import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_controller.dart';
import 'add_alarm_dialog.dart';
import '../../common_widgets/alarm_tile.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';

class HomeScreen extends StatelessWidget {
  final String location;

  const HomeScreen({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(),
      child: Consumer<HomeController>(
        builder: (context, controller, _) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.indigo[900],
              body:
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppStrings.selectedLocation,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                location,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  AppStrings.home,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          AppStrings.alarms,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: controller.alarms.isEmpty
                          ? Center(
                        child: Text(
                          'No alarms set',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      )
                          : ListView.builder(
                        itemCount: controller.alarms.length,
                        itemBuilder: (context, index) {
                          final alarm = controller.alarms[index];
                          return AlarmTile(
                            alarm: alarm,
                            onToggle: (value) =>
                                controller.toggleAlarm(alarm.id, value),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(key: UniqueKey(),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => AddAlarmDialog(
                      onAlarmAdded: (date, time) {
                        controller.addAlarm(date, time);
                      },
                    ),),
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.add),
              ),
            
            ),
          );
        },
      ),
    );
  }
}