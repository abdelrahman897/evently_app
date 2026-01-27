import 'package:flutter/material.dart';

class AppSettingsProvider extends ChangeNotifier {
  String currentLanguage = 'en';
  ThemeMode currentThemeMode = ThemeMode.light;

  void changeCurrentLanguage(String newLanguage) {
    currentLanguage = newLanguage;
    notifyListeners();
  }
  void changeCurrentThemeMode(ThemeMode newThemeMode) {
    currentThemeMode = newThemeMode;
    notifyListeners();
  }
}
