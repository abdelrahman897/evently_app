import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomIconButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final bool isDark;
  const CustomIconButtonWidget({super.key, this.onPressed, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:onPressed ,
      style: IconButton.styleFrom(
        backgroundColor: isDark ? AppColor.secondDarkBlueColor: AppColor.whiteColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: isDark? BorderSide(
            color: AppColor.lightBlueColor,
          ):BorderSide.none,
        ),
      ),
      icon: Icon(
        Icons.arrow_back_ios,
        color: isDark? AppColor.whiteColor :AppColor.primaryColor,
        size: 24,
      ),
    );
  }
}
