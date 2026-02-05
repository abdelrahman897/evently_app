
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/model/event_category_model.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/widget/custom_choice_chip_widget.dart';
import 'package:evently_app/modules/provider/app_provider/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryListWidget extends StatelessWidget {
  final int selectedItem;
  final bool isHomeScreen;
  final Function(int) onCategoryChanged;
  const CategoryListWidget({
    super.key, required this.onCategoryChanged, required this.selectedItem, required this.isHomeScreen,
  });
  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final categoryList = EventCategoryModel.categoryList;
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);
     bool  isDark = appSettingsProvider.currentThemeMode == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 45,
        child:  SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(isHomeScreen ? categoryList.length+1 :categoryList.length  , (index) {
              final isSelected = (selectedItem == index);
              if(isHomeScreen && index == 0){
                return CustomChoiceChipWidget(
                  title: appLocalization.allText,
                  customChildWidget: Icon(
                    Icons.grid_view_rounded,
                    color: isSelected
                        ? AppColor.whiteColor
                        : (isDark ? AppColor.lightBlueColor : AppColor.primaryColor),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) onCategoryChanged(0);
                  },
                );
              }
              final categoryIndex = isHomeScreen ? index - 1 : index;
              final category = categoryList[categoryIndex];
              return CustomChoiceChipWidget(
                title: category.name(appLocalization),
                customChildWidget: Icon(
                  category.icon,
                  color:
                  isSelected
                      ? AppColor.whiteColor
                      : (isDark? AppColor.lightBlueColor:AppColor.primaryColor),
                ),
                selected: isSelected,
                onSelected:(selected) {
                  if (selected) {
                    onCategoryChanged(index);
                  }
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
