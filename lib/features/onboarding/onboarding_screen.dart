import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'onboarding_controller.dart';
import '../../common_widgets/page_indicator.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_images.dart';
import '../../constants/app_colors.dart';
import '../location/location_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> _pages = const [
    {
      'image': AppImages.onboarding1,
      'title': AppStrings.onboardingTitle1,
      'description': AppStrings.onboardingDesc1,
    },
    {
      'image': AppImages.onboarding2,
      'title': AppStrings.onboardingTitle2,
      'description': AppStrings.onboardingDesc2,
    },
    {
      'image': AppImages.onboarding3,
      'title': AppStrings.onboardingTitle3,
      'description': AppStrings.onboardingDesc3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingController(),
      child: Consumer<OnboardingController>(
        builder: (context, controller, _) {
          return Scaffold(
            backgroundColor: const Color(0xFF0B1E33),
            body: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: _pages.length,
                    onPageChanged: controller.onPageChanged,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(_pages[index]['image']!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          // Skip button positioned at top-right (inside image area)
                          Positioned(
                            top: 30,
                            right: 24,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LocationScreen(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.skipColor,
                                backgroundColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              child: Text(
                                AppStrings.skip,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFF0B1E33),
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Title
                        Text(
                          _pages[controller.currentPage]['title']!,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        Text(
                          _pages[controller.currentPage]['description']!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                // Page Indicator and Next Button (dark blue background)
                Container(
                  padding: const EdgeInsets.all(24.0),
                  color: const Color(0xFF0B1E33), // Dark blue
                  child: Column(
                    children: [
                      PageIndicator(
                        currentPage: controller.currentPage,
                        pageCount: _pages.length,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.isLastPage) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LocationScreen(),
                                ),
                              );
                            } else {
                              controller.nextPage();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A90E2), // Blue button
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            controller.isLastPage ? AppStrings.getStarted : AppStrings.next,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}