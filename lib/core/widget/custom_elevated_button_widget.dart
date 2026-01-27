import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  final Widget? customChildWidget;
  final void Function()? onPressed;
  final Color? backgroundColor;

  const CustomElevatedButtonWidget({
    super.key,
    this.onPressed,
    this.customChildWidget,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        alignment: Alignment.center,
        backgroundColor: backgroundColor ?? AppColor.primaryColor,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColor.primaryColor),
        ),
      ),
      child: customChildWidget,
    );
  }
}
