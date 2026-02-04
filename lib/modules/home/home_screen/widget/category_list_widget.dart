
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/model/event_category_model.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/widget/custom_choice_chip_widget.dart';
import 'package:flutter/material.dart';

class CategoryListWidget extends StatelessWidget {
  final int selectedItem;
  final Function(int) onCategoryChanged;
  const CategoryListWidget({
    super.key, required this.onCategoryChanged, required this.selectedItem,
  });
  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final categoryList = EventCategoryModel.categoryList;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        child:  SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(categoryList.length , (index) {
              final isSelected = (selectedItem == index);
              return CustomChoiceChipWidget(
                title: categoryList[index].name(appLocalization),
                customChildWidget: Icon(
                  categoryList[index].icon,
                  color:
                  isSelected
                      ? AppColor.whiteColor
                      : AppColor.primaryColor,
                ),
                selected: isSelected,
                onSelected:(selected) {
                  if (selected) {
                    onCategoryChanged(index);
                  }
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
