import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomAnimatedContainerWidget extends StatelessWidget {
  final bool isActive;
  const CustomAnimatedContainerWidget({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(duration: Duration(milliseconds: 300),
    height: 8,
    width: isActive ? 20.92 : 8,
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    curve: Curves.easeInOut,
    decoration: BoxDecoration(
      color: isActive ? AppColor.primaryColor:AppColor.hintTextColor,
      borderRadius: BorderRadius.circular(36),
    ),);
  }
}
