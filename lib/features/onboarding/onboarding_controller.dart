import 'package:flutter/material.dart';

class OnboardingController extends ChangeNotifier {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  int get currentPage => _currentPage;
  PageController get pageController => _pageController;

  void onPageChanged(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  bool get isLastPage => _currentPage == 2;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}