import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/utils/app_colors.dart';

class FeaturedCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const FeaturedCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: AppColors.primaryColor,
      checkColor: Colors.white,
      value: value,
      onChanged: onChanged,
      title: const Text('Is this a featured product?'),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }
}
