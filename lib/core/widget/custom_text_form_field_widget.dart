import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String text;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Widget? customPrefixWidget;
  final Widget? customSuffixWidget;

  const CustomTextFormFieldWidget({
    super.key,
    required this.text,
    this.controller,
    this.validator,
    this.isPassword = false,
    this.customPrefixWidget,
    this.customSuffixWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      validator: validator,
      style: theme.textTheme.bodyMedium,
      cursorColor: AppColor.darkGreyColor,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        hintStyle: theme.textTheme.bodyMedium,
        hintText: text,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: customPrefixWidget,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: customSuffixWidget,
        ) ,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
