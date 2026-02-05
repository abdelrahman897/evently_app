import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomAnimatedContainerWidget extends StatelessWidget {
  final bool isActive;
  final bool isDark;

  const CustomAnimatedContainerWidget({
    super.key,
    required this.isActive,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 20.92 : 8,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color:
            isActive
                ? (isDark ? AppColor.lightBlueColor : AppColor.primaryColor)
                : (isDark ? AppColor.customWhiteColor : AppColor.hintTextColor),
        borderRadius: BorderRadius.circular(36),
      ),
    );
  }
}
