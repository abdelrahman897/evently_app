import 'package:evently_app/core/routes/pages_route_name.dart';
import 'package:evently_app/modules/authentication/forget_password/forget_password_screen.dart';
import 'package:evently_app/modules/authentication/sign_in/sign_in_screen.dart';
import 'package:evently_app/modules/authentication/sign_up/sign_up_screen.dart';
import 'package:evently_app/modules/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    switch(settings.name) {
      case PagesRouteName.onboardingScreen:
        return MaterialPageRoute(builder: (context)=> OnboardingScreen());
      case PagesRouteName.signInScreen:
        return MaterialPageRoute(builder: (context)=> SignInScreen());
      case PagesRouteName.signUpScreen:
        return MaterialPageRoute(builder: (context)=> SignUpScreen());
      case PagesRouteName.forgetPasswordScreen:
        return MaterialPageRoute(builder: (context)=> ForgetPasswordScreen());
      default:
        return MaterialPageRoute(builder: (context)=> OnboardingScreen());
    }

}
}