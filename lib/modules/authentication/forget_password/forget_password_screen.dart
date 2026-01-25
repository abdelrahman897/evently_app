import 'package:evently_app/core/constant/app_strings.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/widget/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        customLeadingWidget: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: AppColor.primaryColor),
        ),
        customTitleWidget: Text(
          AppStrings.forgetPasswordText,
          style: theme.textTheme.titleMedium,
        ),
      ),
    );
  }
}
