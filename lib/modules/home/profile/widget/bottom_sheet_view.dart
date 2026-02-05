import 'package:evently_app/core/extension/padding_extension.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/modules/provider/app_provider/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetView extends StatefulWidget {
  const BottomSheetView({super.key});

  @override
  State<BottomSheetView> createState() => _BottomSheetViewState();
}

class _BottomSheetViewState extends State<BottomSheetView> {
  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);
    final theme = Theme.of(context);
    bool isDark = appSettingsProvider.currentThemeMode == ThemeMode.dark;
    String currentLanguage = appSettingsProvider.currentLanguage;
    bool isActiveEn = currentLanguage == 'en';
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColor.darkBlueColor : AppColor.customWhiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            appLocalization.selectText,
            style: theme.textTheme.titleLarge?.copyWith(
              color: isDark ? AppColor.whiteColor : AppColor.primaryColor,
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  isDark ? AppColor.secondDarkBlueColor : AppColor.whiteColor,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: isDark ? AppColor.lightBlueColor : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Text(
                  appLocalization.english,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isDark ? AppColor.whiteColor : AppColor.blackColor,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isActiveEn = !isActiveEn;
                      appSettingsProvider.changeCurrentLanguage('en');
                    });
                  },
                  icon: Icon(
                    isActiveEn
                        ? Icons.radio_button_checked_outlined
                        : Icons.radio_button_off_outlined,
                  ),
                  color:
                      isDark ? AppColor.lightBlueColor : AppColor.primaryColor,
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  isDark ? AppColor.secondDarkBlueColor : AppColor.whiteColor,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: isDark ? AppColor.lightBlueColor : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Text(
                  appLocalization.arabic,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isDark ? AppColor.whiteColor : AppColor.blackColor,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isActiveEn = !isActiveEn;
                      appSettingsProvider.changeCurrentLanguage('ar');
                    });
                  },
                  icon: Icon(
                    isActiveEn
                        ? Icons.radio_button_off_outlined
                        : Icons.radio_button_checked_outlined,
                  ),
                  color:
                  isDark ? AppColor.lightBlueColor : AppColor.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    ).setHorizontalAndVerticalPadding(context, 16, 16, enableMediaQuery: false);
  }
}
