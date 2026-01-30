import 'package:evently_app/core/gen/assets.gen.dart';
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
              SizedBox(height: 16,),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return EventCardWidget(
                      dateText: "21",
                      bodyText: "Hello World",
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemCount: 7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
