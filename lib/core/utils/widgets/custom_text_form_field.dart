import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.textInputType,
    required this.hintText,
    this.suffixIcon,
    this.onSaved,
    this.controller,
    this.obscureText = false,
    this.maxlines = 1,
  });

  final TextInputType textInputType;
  final String hintText;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final bool obscureText;
  final int? maxlines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxlines,
      obscureText: obscureText,
      controller: controller,
      onSaved: (value) {
        if (onSaved != null && value != null) {
          onSaved!(value.trim());
        }
      },
      validator: (value) {
        final trimmedValue = value?.trim();
        if (trimmedValue == null || trimmedValue.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
        filled: true,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xff949D9E)),
        border: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: AppColors.grayColor, width: 1),
    );
  }
}
