import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/routes/pages_route_name.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/utils/authentication/firebase_auth/firebase_auth_utils.dart';
import 'package:evently_app/core/widget/custom_button_widget.dart';
import 'package:evently_app/modules/home/profile/widget/bottom_sheet_view.dart';
import 'package:evently_app/modules/provider/app_provider/app_settings_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDark = false;

  void customShowBottomSheet() async {
    var result = await showModalBottomSheet(
      context: context,
      backgroundColor:
          isDark ? AppColor.darkBlueColor : AppColor.customWhiteColor,
      elevation: 0,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return BottomSheetView();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);
    bool isDarkTheme = appSettingsProvider.currentThemeMode == ThemeMode.dark;
    final currentUser = FirebaseAuth.instance.currentUser;
    final String userEmail = currentUser?.email ?? "No Email Found";
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: AppColor.hintTextColor,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: Assets.images.profileBackgroundImg.provider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                currentUser?.displayName ?? "User Name",
                style: theme.textTheme.titleLarge?.copyWith(
                  color: isDarkTheme ? AppColor.whiteColor : AppColor.blackColor,
                ),
              ),
              SizedBox(height: 4),
              Text(userEmail, style: theme.textTheme.bodyMedium),
              SizedBox(height: 32),
              CustomButtonWidget(
                lengthOfWidth: 343,
                lengthOfHeight: 48,
                isDark: isDarkTheme,
                backgroundColor: isDarkTheme ? AppColor.secondDarkBlueColor: AppColor.whiteColor,
                customChildWidget: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        appLocalization.darkMode,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color:
                              isDarkTheme
                                  ? AppColor.whiteColor
                                  : AppColor.blackColor,
                        ),
                      ),
                      Spacer(),
                      Switch(
                        value: isDark,
                        onChanged: (value) {
                          isDark = value;
                          if (isDark) {
                            appSettingsProvider.changeCurrentThemeMode(
                              ThemeMode.dark,
                            );
                          } else {
                            appSettingsProvider.changeCurrentThemeMode(
                              ThemeMode.light,
                            );
                          }
                          setState(() {});
                        },
                        activeColor: AppColor.lightBlueColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              CustomButtonWidget(
                lengthOfWidth: 343,
                lengthOfHeight: 48,
                isDark: isDarkTheme,
                backgroundColor: isDarkTheme ? AppColor.secondDarkBlueColor:AppColor.whiteColor,
                onTap: customShowBottomSheet,
                customChildWidget: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        appLocalization.language,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color:
                              isDarkTheme
                                  ? AppColor.whiteColor
                                  : AppColor.blackColor,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color:
                            isDarkTheme
                                ? AppColor.lightBlueColor
                                : AppColor.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              CustomButtonWidget(
                isDark: isDarkTheme,
                lengthOfWidth: 343,
                lengthOfHeight: 48,
                backgroundColor:isDarkTheme?AppColor.secondDarkBlueColor : AppColor.whiteColor,
                onTap: () {
                  EasyLoading.show();
                  FirebaseAuthUtils.singOut().then((value) {
                    EasyLoading.dismiss();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      PagesRouteName.signInScreen,
                      (route) => false,
                    );
                  });
                },
                customChildWidget: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        appLocalization.logout,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color:
                              isDarkTheme
                                  ? AppColor.whiteColor
                                  : AppColor.blackColor,
                        ),
                      ),
                      Spacer(),
                      Assets.icons.logoutIcn.svg(width: 24, height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
