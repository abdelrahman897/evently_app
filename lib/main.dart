import 'package:evently_app/core/routes/app_router.dart';
import 'package:evently_app/core/routes/pages_route_name.dart';
import 'package:evently_app/core/theme/theme_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evently App',
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.themeData,
      initialRoute: PagesRouteName.onboardingScreen,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
