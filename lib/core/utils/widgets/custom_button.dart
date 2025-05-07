import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/utils/app_colors.dart';
import 'package:fruits_hub_dashboard/core/utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        minimumSize: const Size(double.infinity, 54),
        backgroundColor: AppColors.primaryColor,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyles.bold16.copyWith(color: Colors.white),
      ),
    );
  }
}
