import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/widget/custom_button_widget.dart';
import 'package:evently_app/modules/provider/app_provider/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventlyAppBarWidget extends StatefulWidget {
  const EventlyAppBarWidget({super.key});

  @override
  State<EventlyAppBarWidget> createState() => _EventlyAppBarWidgetState();
}

bool isActiveLanguage = true;
bool isActiveTheme = true;

class _EventlyAppBarWidgetState extends State<EventlyAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalization = AppLocalizations.of(context)!;
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);
    bool isEnglish = appSettingsProvider.currentLanguage == 'EN';
    return ListTile(
      title: Text(appLocalization.titleHome,style: theme.textTheme.bodyMedium,),
      trailing: SizedBox(
        width: 80,
        height: 32,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButtonWidget(
              backgroundColor:
              isActiveTheme ? AppColor.whiteColor : AppColor.darkBlueColor,
              onTap: () {
                if (!isActiveTheme) {
                  setState(() {
                    appSettingsProvider.changeCurrentThemeMode(ThemeMode.light);
                    isActiveTheme = !isActiveTheme;
                  });
                } else if (isActiveTheme) {
                  setState(() {
                    appSettingsProvider.changeCurrentThemeMode(ThemeMode.dark);
                    isActiveTheme = !isActiveTheme;
                  });
                }
              },
              lengthOfWidth: 34,
              lengthOfHeight: 32,
              customChildWidget:
              isActiveTheme
                  ? Assets.icons.sunIcn.svg(
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  AppColor.primaryColor,
                  BlendMode.srcIn,
                ),
              )
                  : Assets.icons.moonIcn.svg(
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  AppColor.lightBlueColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 8),
            CustomButtonWidget(
              onTap: () {
                if (isEnglish) {
                  appSettingsProvider.changeCurrentLanguage('ar');
                  isActiveLanguage = !isActiveLanguage;
                } else {
                  appSettingsProvider.changeCurrentLanguage('en');
                  isActiveLanguage = !isActiveLanguage;
                }
                setState(() {

                });
              },
              lengthOfWidth: 34,
              lengthOfHeight: 32,
              customChildWidget: Text(
                isActiveLanguage ? "EN" : "AR",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color:  AppColor.whiteColor,
                ),
              ),
              backgroundColor:
              isActiveLanguage
                  ? AppColor.primaryColor
                  : AppColor.lightBlueColor,
            ),
          ],
        ),
      ),
      subtitle: Text(
        appLocalization.subTitle,
        style: theme.textTheme.titleLarge?.copyWith(color: AppColor.blackColor),
      ),
    );
  }
}
