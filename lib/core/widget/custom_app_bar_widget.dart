import 'package:evently_app/core/extension/padding_extension.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? customLeadingWidget;
  final Widget customTitleWidget;
  final List<Widget>? customActionListWidget;


  const CustomAppBarWidget({
    super.key,
    this.customLeadingWidget,
    required this.customTitleWidget,
    this.customActionListWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:  customLeadingWidget,
      title: customTitleWidget,
      actions: customActionListWidget,
    ).setHorizontalPaddingOnWidget(16);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
