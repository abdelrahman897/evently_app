import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/routes/app_router.dart';
import 'package:evently_app/core/routes/pages_route_name.dart';
import 'package:evently_app/core/theme/theme_manager.dart';
import 'package:evently_app/modules/provider/app_provider/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
   final bool hasSeenOnboarding = prefs.getBool('complete-onboarding') ?? false;
  runApp(ChangeNotifierProvider(create: (context) => AppSettingsProvider() ,child: MyApp(hasSeenOnboarding: hasSeenOnboarding,)));
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;
  const MyApp({super.key,  this.hasSeenOnboarding = false});

  @override
  Widget build(BuildContext context) {
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context,listen: true);
    return MaterialApp(
      title: 'Evently App',
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.getLightTheme(),
      darkTheme: ThemeManager.getDarkTheme(),
      themeMode: appSettingsProvider.currentThemeMode,
      initialRoute: hasSeenOnboarding ? PagesRouteName.signInScreen : PagesRouteName.onboardingScreen,
      onGenerateRoute: AppRouter.onGenerateRoute,
      locale:  Locale(appSettingsProvider.currentLanguage),
      localizationsDelegates:AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
