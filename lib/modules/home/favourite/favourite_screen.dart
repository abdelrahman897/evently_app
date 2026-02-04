import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/model/event_data_model.dart';
import 'package:evently_app/core/routes/pages_route_name.dart';
import 'package:evently_app/core/utils/firestore/firestore_utils.dart';
import 'package:evently_app/core/widget/custom_text_form_field_widget.dart';
import 'package:evently_app/modules/home/home_screen/widget/event_card_widget.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool isActiveFavourite = false;
  int selectedIndex = 0;
  List<EventDataModel> ee = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
          child: Column(
            children: [
              CustomTextFormFieldWidget(
                text: "Search for event",
                customSuffixWidget: Assets.icons.searchIcn.svg(
                  width: 24,
                  height: 24,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<QuerySnapshot<EventDataModel>>(
                  stream: FirestoreUtils.getStreamFavouriteDataFromFirestore(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    var docs = snapshot.data?.docs ?? [];

                    if (docs.isEmpty) {
                      return Center(child: Text("no event found you can create event."));
                    }
                    List<EventDataModel> dataList =  docs.map((element) {
                          return element.data();
                        }).toList();
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final eventSelected = dataList[index];
                        return InkWell(onTap: (){
                          Navigator.pushNamed(context, PagesRouteName.eventDetailsScreen,arguments: eventSelected);
                        },child: EventCardWidget(event: eventSelected));
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 16),
                      itemCount: dataList.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
