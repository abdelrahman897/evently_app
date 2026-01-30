import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class EventCardWidget extends StatefulWidget {
  final String dateText;
  final String bodyText;
  final void Function()? onTap;

  const EventCardWidget({
    super.key,
    required this.dateText,
    this.onTap,
    required this.bodyText,
  });

  @override
  State<EventCardWidget> createState() => _EventCardWidgetState();
}

class _EventCardWidgetState extends State<EventCardWidget> {
  bool isActiveFavourite = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 343,
      height: 193,
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
          image: Assets.images.sportLightBackgroundImg.provider(),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0,left: 8.0),
            child: Container(
              width: 66,
              height: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColor.customWhiteColor,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(widget.dateText, style: theme.textTheme.bodyLarge),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0,right: 8.0,left: 8.0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColor.customWhiteColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.bodyText,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColor.blackColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                         isActiveFavourite = !isActiveFavourite;
                      });
                    },
                    child:
                        isActiveFavourite
                            ? Assets.icons.heartActiveIcn.svg(
                              width: 24,
                              height: 24,
                            )
                            : Assets.icons.heartIcn.svg(width: 24, height: 24),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
