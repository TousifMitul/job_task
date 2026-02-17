import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_strings.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SkipButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppTextStyles.skipButton.color,
      ),
      child: Text(
        AppStrings.skip,
        style: AppTextStyles.skipButton,
      ),
    );
  }
}