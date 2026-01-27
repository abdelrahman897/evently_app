
import 'package:evently_app/core/extension/padding_extension.dart';
import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/widget/custom_app_bar_widget.dart';
import 'package:evently_app/core/widget/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations =AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBarWidget(
        customLeadingWidget: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: AppColor.primaryColor),
        ),
        customTitleWidget: Text(
          appLocalizations.forgetPassword,
          style: theme.textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          Assets.images.forgetPasswordBackgroundImg.image(
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
                  onPressed: (){},
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
