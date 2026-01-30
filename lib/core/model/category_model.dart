import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CategoryModel{
   IconData icon;
   String  Function(AppLocalizations) name;


  CategoryModel({
    required this.icon,
    required this.name,
  });
  static List<CategoryModel> categoryList = [
    CategoryModel(icon: Icons.grid_view_rounded, name:(l10n) => l10n.allText ),
    CategoryModel(icon: Icons.directions_bike, name: (l10n) => l10n.sportText),
    CategoryModel(icon: Icons.groups, name: (l10n) => l10n.meetingText),
    CategoryModel(icon: Icons.museum, name: (l10n) => l10n.exhibitionText),
    CategoryModel(icon: Icons.cake, name: (l10n) => l10n.birthdayText),
    CategoryModel(icon: Icons.menu_book, name: (l10n) => l10n.bookClubText),
  ];
}