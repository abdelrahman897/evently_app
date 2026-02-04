import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomIconButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  const CustomIconButtonWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:onPressed ,
      style: IconButton.styleFrom(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColor.primaryColor,
        size: 24,
      ),
    );
  }
}
