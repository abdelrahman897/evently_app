import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/widget/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(customTitleWidget: Assets.images.headerLogoBackgroundImg.image(
        width: 142,
        height: 27,
      ),),
    );
  }
}
