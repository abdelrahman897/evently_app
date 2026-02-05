import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final double lengthOfWidth;
  final double lengthOfHeight;
  final Color? backgroundColor;
  final Widget customChildWidget;
  final void Function()? onTap;
  final bool isNav;
  final bool isDark;

  const CustomButtonWidget({
    super.key,
    this.backgroundColor,
    required this.lengthOfWidth,
    required this.lengthOfHeight,
    required this.customChildWidget,
    this.onTap,
    this.isNav = false,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: lengthOfWidth,
        height: lengthOfHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColor.primaryColor,
          borderRadius:
              isNav
                  ? BorderRadius.all(Radius.circular(24))
                  : BorderRadius.circular(16),
          border: Border.all(width: 1.5, color: isDark ? AppColor.lightBlueColor: AppColor.whiteColor),
        ),
        child: customChildWidget,
      ),
    );
  }
}
