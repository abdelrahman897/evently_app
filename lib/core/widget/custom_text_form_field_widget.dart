import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String text;
  final bool isDark;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Widget? customPrefixWidget;
  final int maxLines ;
  final Widget? customSuffixWidget;

  const CustomTextFormFieldWidget({
    super.key,
    required this.text,
    this.controller,
    this.validator,
    this.isPassword = false,
    this.customPrefixWidget,
    this.customSuffixWidget,
    this.maxLines = 1, required this.isDark,
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
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: isDark? AppColor.secondDarkBlueColor : AppColor.whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: isDark ? BorderSide(
            color: AppColor.lightBlueColor,
          ):BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: isDark ? BorderSide(
            color: AppColor.lightBlueColor,
          ):BorderSide.none,
        ),
        hintStyle: theme.textTheme.bodyMedium,
        hintText: text,
        prefixIcon: customPrefixWidget != null ? Padding(
          padding: const EdgeInsets.all(12.0),
          child: customPrefixWidget,
        ): null,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: customSuffixWidget,
        ) ,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: isDark ? BorderSide(
            color: AppColor.lightBlueColor,
          ):BorderSide.none,
        ),
      ),
    );
  }
}
