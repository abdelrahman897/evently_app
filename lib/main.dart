import 'package:bot_toast/bot_toast.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/routes/app_router.dart';
import 'package:evently_app/core/routes/pages_route_name.dart';
import 'package:evently_app/core/services/easy_loading.dart';
import 'package:evently_app/core/theme/theme_manager.dart';
import 'package:evently_app/core/utils/authentication/firebase_auth/firebase_auth_utils.dart';
import 'package:evently_app/firebase_options.dart';
import 'package:evently_app/modules/provider/app_provider/app_settings_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final bool hasSeenOnboarding = prefs.getBool('complete-onboarding') ?? false;
  var user = FirebaseAuth.instance.currentUser;
  final bool isLoggIn = user != null && user.emailVerified;

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppSettingsProvider(),
      child: MyApp(hasSeenOnboarding: hasSeenOnboarding,isLoggIn:isLoggIn),
    ),
  );
  configLoading();
}

class MyApp extends StatelessWidget {
  final bool isLoggIn;
  final bool hasSeenOnboarding;

  const MyApp({super.key, this.hasSeenOnboarding = false,  this.isLoggIn = false});

  @override
  Widget build(BuildContext context) {

    final appSettingsProvider = Provider.of<AppSettingsProvider>(
      context,
      listen: true,
    );
    String getInitialRoute(){
      if(!hasSeenOnboarding){
        return PagesRouteName.onboardingScreen;
      }
      if (isLoggIn) {
        return PagesRouteName.homeLayoutScreen;
      }
      return PagesRouteName.signInScreen;
    }
    return MaterialApp(
      title: 'Evently App',
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.getLightTheme(),
      darkTheme: ThemeManager.getDarkTheme(),
      themeMode: appSettingsProvider.currentThemeMode,
      initialRoute: getInitialRoute(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      locale: Locale(appSettingsProvider.currentLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: EasyLoading.init(builder: BotToastInit()),
    );
  }
}
