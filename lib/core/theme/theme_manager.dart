import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

abstract class ThemeManager {
  static ThemeData getLightTheme() => ThemeData(
    useMaterial3: true,
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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
       backgroundColor: AppColor.whiteColor,
      selectedItemColor: AppColor.primaryColor,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
        color: AppColor.primaryColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      unselectedLabelStyle: TextStyle(
      color: AppColor.hintTextColor,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w400,
      height: 1.4,
    ),
      showSelectedLabels: true,
      unselectedItemColor: AppColor.hintTextColor,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
  );
  static ThemeData getDarkTheme() => ThemeData(
    useMaterial3: true,
    textTheme: TextTheme(
      bodySmall: TextStyle(
        color: AppColor.lightGreyColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      bodyMedium: TextStyle(
        color: AppColor.lightGreyColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      bodyLarge: TextStyle(
        color: AppColor.lightGreyColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      titleMedium: TextStyle(
        color: AppColor.whiteColor,
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
        color: AppColor.whiteColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
    ),
    scaffoldBackgroundColor: AppColor.darkBlueColor,
    appBarTheme: AppBarTheme(
      color: AppColor.darkBlueColor,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.darkBlueColor,
      selectedItemColor: AppColor.primaryColor,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
        color: AppColor.primaryColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      unselectedLabelStyle: TextStyle(
        color: AppColor.hintTextColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      showSelectedLabels: true,
      unselectedItemColor: AppColor.hintTextColor,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
  );
}
