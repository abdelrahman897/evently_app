import 'dart:ffi';

import 'package:evently_app/core/model/event_data_model.dart';
import 'package:evently_app/core/routes/pages_route_name.dart';
import 'package:evently_app/modules/authentication/forget_password/forget_password_screen.dart';
import 'package:evently_app/modules/authentication/sign_in/sign_in_screen.dart';
import 'package:evently_app/modules/authentication/sign_up/sign_up_screen.dart';
import 'package:evently_app/modules/events/add_event/add_event_screen.dart';
import 'package:evently_app/modules/events/edit_event/edit_event_screen.dart';
import 'package:evently_app/modules/events/event_details/event_details_screen.dart';
import 'package:evently_app/modules/home/favourite/favourite_screen.dart';
import 'package:evently_app/modules/home/home_layout_screen.dart';
import 'package:evently_app/modules/home/home_screen/home_screen.dart';
import 'package:evently_app/modules/home/profile/profile_screen.dart';
import 'package:evently_app/modules/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagesRouteName.onboardingScreen:
        return MaterialPageRoute(builder: (context) => OnboardingScreen());
      case PagesRouteName.signInScreen:
        return MaterialPageRoute(builder: (context) => SignInScreen());
      case PagesRouteName.signUpScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case PagesRouteName.forgetPasswordScreen:
        return MaterialPageRoute(builder: (context) => ForgetPasswordScreen());
      case PagesRouteName.homeLayoutScreen:
        return MaterialPageRoute(builder: (context) => HomeLayoutScreen());
      case PagesRouteName.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case PagesRouteName.favouriteScreen:
        return MaterialPageRoute(builder: (context) => FavouriteScreen());
      case PagesRouteName.profileScreen:
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      case PagesRouteName.addEventScreen:
        return MaterialPageRoute(builder: (context) => AddEventScreen());
      case PagesRouteName.editEventScreen:
        final args = settings.arguments as EventDataModel;
        return MaterialPageRoute(builder: (context) => EditEventScreen(event: args));
      case PagesRouteName.eventDetailsScreen:
        final eventSelected = settings.arguments as EventDataModel;
        return MaterialPageRoute(builder: (context) => EventDetailsScreen(event: eventSelected));
      default:
        return MaterialPageRoute(builder: (context) => OnboardingScreen());
    }
  }
}
