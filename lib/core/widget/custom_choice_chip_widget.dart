import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/modules/provider/app_provider/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomChoiceChipWidget extends StatelessWidget {
  final String title;
  final Widget customChildWidget;
  final bool selected;
  final Function(bool)? onSelected;

  const CustomChoiceChipWidget({
    super.key,
    required this.title,
    required this.customChildWidget,
    required this.selected, this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);
     bool  isDark = appSettingsProvider.currentThemeMode == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: ChoiceChip(
        label: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: selected ? (AppColor.whiteColor) : (isDark? AppColor.whiteColor: AppColor.blackColor),
          ),
        ),
        selected: selected,
        avatar: customChildWidget,
        onSelected: onSelected,
        elevation: 0,
        selectedColor: isDark ?AppColor.lightBlueColor : AppColor.primaryColor,
        backgroundColor: isDark ?AppColor.secondDarkBlueColor : AppColor.whiteColor,
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        showCheckmark: false,
        shape: RoundedRectangleBorder(
          side: isDark ? BorderSide(
            color: AppColor.lightBlueColor,
          ):BorderSide(
            color: Colors.transparent,
          ) ,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
