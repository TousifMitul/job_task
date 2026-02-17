import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'location_controller.dart';
import '../../common_widgets/custom_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../helpers/navigation_helper.dart';
import '../home/home_screen.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocationController(),
      child: Consumer<LocationController>(
        builder: (context, controller, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                AppStrings.locationTitle,
                style: AppTextStyles.appBarTitle,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    AppStrings.welcomeText,
                    style: AppTextStyles.heading1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.welcomeSubtext,
                    style: AppTextStyles.bodyText2,
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () => controller.getLocation(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.my_location,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            controller.isLoading
                                ? AppStrings.gettingLocation
                                : AppStrings.useCurrentLocation,
                            style: AppTextStyles.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (controller.currentLocation != null) ...[
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.selectedLocation,
                            style: AppTextStyles.locationSubtitle,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.currentLocation!,
                            style: AppTextStyles.locationTitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                  const Spacer(),
                  CustomButton(
                    text: AppStrings.home,
                    onPressed: controller.currentLocation != null
                        ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                        HomeScreen(location: controller.currentLocation!),
                      )
                      );
                    }
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}