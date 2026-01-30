
import 'package:evently_app/modules/home/home_screen/widget/tab_item_widget.dart';
import 'package:flutter/material.dart';

class CategoryListWidget extends StatefulWidget {

  const CategoryListWidget({
    super.key,
  });

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        child: DefaultTabController(
          length: 6,
          child: TabBar(
            onTap: (index){
              selectedIndex = index;
              setState(() {
              });
            },
            isScrollable: true,
            indicator: BoxDecoration(),
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsets.symmetric(horizontal: 8),
            tabs: List.generate(6, (index) => TabItemWidget(index: index,isActive: selectedIndex == index,)),
          ),
        ),
      ),
    );
  }
}
