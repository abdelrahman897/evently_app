import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class   EventCategoryModel {
  final String id;
  final IconData icon;
  final String Function(AppLocalizations) name;
  final String lightImagePath;
  final String darkImagePath;


  EventCategoryModel({
    required this.icon,
    required this.id,
    required this.name,
    required this.lightImagePath,
    required this.darkImagePath,
  });

  static List<EventCategoryModel> categoryList = [
    EventCategoryModel(
      id: "sport",
      icon: Icons.directions_bike,
      name: (l10n) => l10n.sportText,
      darkImagePath: Assets.images.sportDarkBackgroundImg.path,
      lightImagePath: Assets.images.sportLightBackgroundImg.path,
    ),
    EventCategoryModel(
      id: "meeting",
      icon: Icons.groups,
      name: (l10n) => l10n.meetingText,
      darkImagePath: Assets.images.meetingDarkBackgroundImg.path,
      lightImagePath: Assets.images.meetingLightBackgroundImg.path,
    ),
    EventCategoryModel(
      id: "exhibition",
      icon: Icons.museum,
      name: (l10n) => l10n.exhibitionText,
      darkImagePath: Assets.images.exhibitionDarkBackgroundImg.path,
      lightImagePath: Assets.images.exhibitionLightBackgroundImg.path,
    ),
    EventCategoryModel(
      id: "birthday",
      icon: Icons.cake,
      name: (l10n) => l10n.birthdayText,
      darkImagePath: Assets.images.birthdayDarkBackgroundImg.path,
      lightImagePath: Assets.images.birthdayLightBackgroundImg.path,
    ),
    EventCategoryModel(
      id: "bookClub",
      icon: Icons.menu_book,
      name: (l10n) => l10n.bookClubText,
      darkImagePath: Assets.images.bookClubDarkBackgroundImg.path,
      lightImagePath: Assets.images.bookClubLightBackgroundImg.path,
    ),
  ];
}
