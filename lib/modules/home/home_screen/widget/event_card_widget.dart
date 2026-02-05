import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/model/event_data_model.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/utils/firestore/firestore_utils.dart';
import 'package:evently_app/modules/provider/app_provider/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventCardWidget extends StatefulWidget {
  final EventDataModel event;
  final void Function()? onTap;

  const EventCardWidget({
    super.key,
    this.onTap,
    required this.event,
  });

  @override
  State<EventCardWidget> createState() => _EventCardWidgetState();
}

class _EventCardWidgetState extends State<EventCardWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isFav = widget.event.isFavourite;
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);
     bool  isDark = appSettingsProvider.currentThemeMode == ThemeMode.dark;
    return Container(
      width: 343,
      height: 193,
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColor.secondDarkBlueColor: AppColor.whiteColor,
        border: Border.all(
          color: isDark?AppColor.lightBlueColor:Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
          image: AssetImage(isDark ? widget.event.categoryDarkImage : widget.event.categoryLightImage),
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
              width: 80,
              height: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark?AppColor.lightBlueColor:Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(8.0),
                color: isDark ? AppColor.secondDarkBlueColor: AppColor.customWhiteColor,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(DateFormat("dd MMM").format(widget.event.eventDate), style: theme.textTheme.bodyLarge?.copyWith(
                  color:isDark?AppColor.lightBlueColor:AppColor.primaryColor ,
                ),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0,right: 8.0,left: 8.0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark ? AppColor.lightBlueColor : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(8.0),
                color: isDark ? AppColor.secondDarkBlueColor : AppColor.customWhiteColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.event.eventDescription,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? AppColor.whiteColor : AppColor.blackColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      FirestoreUtils.updateFavouriteStatus(widget.event);
                    },
                    child:
                        isFav
                            ? Assets.icons.heartActiveIcn.svg(
                              width: 24,
                              height: 24,
                          colorFilter: ColorFilter.mode(isDark ? AppColor.lightBlueColor : AppColor.primaryColor, BlendMode.srcIn),
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
