import 'package:evently_app/core/extension/padding_extension.dart';
import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/model/onboarding_model.dart';
import 'package:evently_app/core/routes/pages_route_name.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/widget/custom_app_bar_widget.dart';
import 'package:evently_app/core/widget/custom_button_widget.dart';
import 'package:evently_app/core/widget/custom_elevated_button_widget.dart';
import 'package:evently_app/modules/onboarding/widget/custom_animated_container_widget.dart';
import 'package:evently_app/modules/provider/app_provider/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController(initialPage: 0);
  var pageList = OnboardingModel.onboardingList;
  bool isActiveLanguage = true;
  bool isActiveTheme = true;
  int currentIndex = 0;

  @override
  void initState() {
    pageController.addListener(() {
      if (pageController.page! % 1 == 0) {
        currentIndex = pageController.page!.toInt();
      }
      setState(() {});
    });
    super.initState();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenOnboarding = await prefs.setBool(
      'complete-onboarding',
      true,
    );
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        hasSeenOnboarding
            ? PagesRouteName.signInScreen
            : PagesRouteName.onboardingScreen,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations =AppLocalizations.of(context)!;
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        customLeadingWidget: Visibility(
          visible: currentIndex > 1,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () {
                pageController.animateToPage(
                  currentIndex - 1,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                );
              },
              child: Icon(Icons.arrow_back_ios, color: AppColor.primaryColor),
            ),
          ),
        ),
        customTitleWidget: Assets.images.headerLogoBackgroundImg.image(
          width: 142,
          height: 27,
        ),
        customActionListWidget: [
          Visibility(
            visible: currentIndex != 0,
            child: CustomButtonWidget(
              onTap: () {
                completeOnboarding();
              },
              lengthOfWidth: 63,
              lengthOfHeight: 32,
              backgroundColor: AppColor.whiteColor,
              customChildWidget: Text(
                appLocalizations.skip,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColor.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return Image.asset(pageList[index].imagePath);
                },
                itemCount: pageList.length,
                controller: pageController,
              ),
            ),
            Visibility(
              visible: currentIndex != 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pageList.length - 1, (index) {
                  return CustomAnimatedContainerWidget(
                    isActive: currentIndex - 1 == index,
                  );
                }),
              ),
            ),
            SizedBox(height: 16),
            Text(
              pageList[currentIndex].titleText(appLocalizations),
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColor.blackColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              pageList[currentIndex].bodyText(appLocalizations),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColor.darkGreyColor,
              ),
            ),
            SizedBox(height: 16),
            Visibility(
              visible: currentIndex == 0,
              child: Row(
                children: [
                  Text(
                    appLocalizations.language,
                    style: theme.textTheme.titleMedium,
                  ),
                  Spacer(),
                  CustomButtonWidget(
                    onTap: () {
                      if (!isActiveLanguage) {
                        setState(() {
                          appSettingsProvider.changeCurrentLanguage('en');
                          isActiveLanguage = !isActiveLanguage;
                        });
                      }
                    },
                    lengthOfWidth: 83,
                    lengthOfHeight: 32,
                    customChildWidget: Text(
                      appLocalizations.english,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            isActiveLanguage
                                ? AppColor.whiteColor
                                : AppColor.primaryColor,
                      ),
                    ),
                    backgroundColor:
                        isActiveLanguage
                            ? AppColor.primaryColor
                            : AppColor.whiteColor,
                  ),
                  SizedBox(width: 8),
                  CustomButtonWidget(
                    onTap: () {
                      if (isActiveLanguage) {
                        setState(() {
                          appSettingsProvider.changeCurrentLanguage('ar');
                          isActiveLanguage = !isActiveLanguage;

                        });
                      }
                    },
                    lengthOfWidth: 83,
                    lengthOfHeight: 32,
                    customChildWidget: Text(
                      appLocalizations.arabic,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            isActiveLanguage
                                ? AppColor.primaryColor
                                : AppColor.whiteColor,
                      ),
                    ),
                    backgroundColor:
                        isActiveLanguage
                            ? AppColor.whiteColor
                            : AppColor.primaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Visibility(
              visible: currentIndex == 0,
              child: Row(
                children: [
                  Text(appLocalizations.theme, style: theme.textTheme.titleMedium),
                  Spacer(),
                  CustomButtonWidget(
                    onTap: () {
                      if (!isActiveTheme) {
                        setState(() {
                          appSettingsProvider.changeCurrentThemeMode(ThemeMode.light);
                          isActiveTheme = !isActiveTheme;
                        });
                      }
                    },
                    lengthOfWidth: 56,
                    lengthOfHeight: 32,
                    customChildWidget: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Assets.icons.sunIcn.svg(
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          isActiveTheme
                              ? AppColor.whiteColor
                              : AppColor.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    backgroundColor:
                        isActiveTheme
                            ? AppColor.primaryColor
                            : AppColor.whiteColor,
                  ),
                  SizedBox(width: 8),
                  CustomButtonWidget(
                    lengthOfWidth: 56,
                    lengthOfHeight: 32,
                    onTap: () {
                      if (isActiveTheme) {
                        setState(() {
                          appSettingsProvider.changeCurrentThemeMode(ThemeMode.dark);
                          isActiveTheme = !isActiveTheme;
                        });
                      }
                    },
                    backgroundColor: isActiveTheme
                        ? AppColor.whiteColor
                        : AppColor.primaryColor,
                    customChildWidget: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Assets.icons.moonIcn.svg(width: 20, height: 20,colorFilter: ColorFilter.mode(
                        isActiveTheme
                            ? AppColor.primaryColor
                            : AppColor.whiteColor,
                        BlendMode.srcIn,
                      ),),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButtonWidget(
                    onPressed: () {
                      if (currentIndex < pageList.length - 1) {
                        pageController.animateToPage(
                          currentIndex + 1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                        );
                      } else {
                        completeOnboarding();
                      }
                    },
                    customChildWidget: Text(
                      currentIndex == 0
                          ? appLocalizations.letsStart
                          : currentIndex == pageList.length - 1
                          ? appLocalizations.getStarted
                          : appLocalizations.next,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).setHorizontalAndVerticalPadding(
          context,
          16,
          24,
          enableMediaQuery: false,
        ),
    );
  }
}
