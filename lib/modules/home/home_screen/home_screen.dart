import 'package:evently_app/core/extension/padding_extension.dart';
import 'package:evently_app/core/routes/pages_route_name.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/modules/home/home_screen/widget/category_list_widget.dart';
import 'package:evently_app/modules/home/home_screen/widget/event_card_widget.dart';
import 'package:evently_app/modules/home/home_screen/widget/evently_app_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 16,right: 16,top: 26),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: EventlyAppBarWidget(
              )),
              SliverToBoxAdapter(child: CategoryListWidget()),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 7,
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: EventCardWidget(
                      bodyText: "hello world",
                      dateText: "21",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, PagesRouteName.addEventScreen);
          },
          backgroundColor: AppColor.primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(Icons.add, color: AppColor.whiteColor, size: 24),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
