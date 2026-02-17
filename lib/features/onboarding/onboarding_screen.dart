import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'onboarding_controller.dart';
import 'onboarding_page.dart';
import '../../common_widgets/skip_button.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/page_indicator.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_images.dart';
import '../../helpers/navigation_helper.dart';
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
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0, top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SkipButton(
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                            const LocationScreen(),
                          ),
                        ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      itemCount: _pages.length,
                      onPageChanged: controller.onPageChanged,
                      itemBuilder: (context, index) {
                        return OnboardingPage(
                          title: _pages[index]['title']!,
                          description: _pages[index]['description']!,
                          imagePath: _pages[index]['image']!,
                        );
                      },
                    ),
                  ),
                  PageIndicator(
                    currentPage: controller.currentPage,
                    pageCount: _pages.length,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: CustomButton(
                      text: controller.isLastPage
                          ? AppStrings.getStarted
                          : AppStrings.next,
                      onPressed: () {
                        if (controller.isLastPage) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                            const LocationScreen(),
                          ));
                        } else {
                          controller.nextPage();
                        }
                      },
                    ),
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