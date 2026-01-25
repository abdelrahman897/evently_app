import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

abstract class ThemeManager {
  static ThemeData themeData = ThemeData(
    textTheme: TextTheme(
      bodySmall: TextStyle(
        color: AppColor.primaryColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      bodyMedium: TextStyle(
        color: AppColor.darkGreyColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      bodyLarge: TextStyle(
        color: AppColor.primaryColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      titleMedium: TextStyle(
        color: AppColor.primaryColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      titleLarge: TextStyle(
        color: AppColor.whiteColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      headlineSmall: TextStyle(
        color: AppColor.primaryColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
    ),
    scaffoldBackgroundColor: AppColor.customWhiteColor,
    appBarTheme: AppBarTheme(
      color: AppColor.customWhiteColor,
      centerTitle: true,
    ),
  );
}
