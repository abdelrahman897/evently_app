import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/model/category_model.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  final int index;
  final bool isActive;
  const TabItemWidget({super.key, required this.index,required this.isActive});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalization = AppLocalizations.of(context)!;
    return Container(
      width: 84,
      height: 40,
      decoration: BoxDecoration(
        color: isActive ? AppColor.primaryColor : AppColor.whiteColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CategoryModel.categoryList[index].icon,color: isActive ? AppColor.whiteColor:AppColor.primaryColor,size: 24,),
            SizedBox(width: 4),
            FittedBox(
              child: Text(
                CategoryModel.categoryList[index].name(appLocalization),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: isActive ? AppColor.whiteColor : AppColor.blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
