import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/model/event_category_model.dart';
import 'package:evently_app/core/model/event_data_model.dart';
import 'package:evently_app/core/routes/pages_route_name.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/utils/firestore/firestore_utils.dart';
import 'package:evently_app/modules/home/home_screen/widget/category_list_widget.dart';
import 'package:evently_app/modules/home/home_screen/widget/event_card_widget.dart';
import 'package:evently_app/modules/home/home_screen/widget/evently_app_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 26),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: EventlyAppBarWidget()),
              SliverToBoxAdapter(
                child: CategoryListWidget(
                  selectedItem: selectedIndex,
                  onCategoryChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              ),
              StreamBuilder<QuerySnapshot<EventDataModel>>(
                stream: FirestoreUtils.getStreamDataFromFirestore(
                  EventCategoryModel.categoryList[selectedIndex].id,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return SliverToBoxAdapter(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  var docs = snapshot.data?.docs ?? [];

                  if (docs.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("no event found you can create event."),
                      )),
                    );
                  }
                  List<EventDataModel> dataList =
                      docs.map((element) {
                        return element.data();
                      }).toList();
                  return SliverPadding(
                    padding: const EdgeInsets.only(top: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final eventSelected = dataList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: InkWell(onTap: (){
                            Navigator.pushNamed(context, PagesRouteName.eventDetailsScreen,arguments: eventSelected);
                          },child: EventCardWidget(event: eventSelected)),
                        );
                      }, childCount: dataList.length),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
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
