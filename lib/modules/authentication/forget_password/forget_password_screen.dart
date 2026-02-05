
import 'package:evently_app/core/extension/padding_extension.dart';
import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/widget/custom_app_bar_widget.dart';
import 'package:evently_app/core/widget/custom_elevated_button_widget.dart';
import 'package:evently_app/modules/provider/app_provider/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations =AppLocalizations.of(context)!;
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);
    bool isDark = appSettingsProvider.currentThemeMode == ThemeMode.dark;
    return Scaffold(
      appBar: CustomAppBarWidget(
        customLeadingWidget: IconButton(
          color: isDark? AppColor.secondDarkBlueColor: AppColor.whiteColor,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color:isDark?AppColor.whiteColor: AppColor.primaryColor),
        ),
        customTitleWidget: Text(
          appLocalizations.forgetPassword,
          style: theme.textTheme.titleMedium?.copyWith(
            color: isDark?AppColor.whiteColor:AppColor.blackColor,
          ),
        ),
      ),
      body: Column(
        children: [
          if (isDark)
            Assets.images.forgetPasswordDarkBackgroundImg.image(
            width: 326.39,
            height: 319.13,
            fit: BoxFit.contain,
          ),
          Assets.images.forgetPasswordLightBackgroundImg.image(
            width: 326.39,
            height: 319.13,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomElevatedButtonWidget(
                  backgroundColor: isDark?AppColor.lightBlueColor:AppColor.primaryColor,
                  onPressed: (){

                  },
                  customChildWidget: Text(appLocalizations.resetPassword,style:theme.textTheme.titleLarge,textAlign: TextAlign.center,),
                ),
              ),
            ],
          ),
        ],
      ).setHorizontalAndVerticalPadding(
        context,
        16,
        48,
        enableMediaQuery: false,
      ),
    );
  }
}
