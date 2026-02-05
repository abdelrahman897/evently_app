import 'package:evently_app/core/extension/padding_extension.dart';
import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/model/event_data_model.dart';
import 'package:evently_app/core/routes/pages_route_name.dart';
import 'package:evently_app/core/services/toast_message.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/utils/firestore/firestore_utils.dart';
import 'package:evently_app/core/widget/custom_app_bar_widget.dart';
import 'package:evently_app/core/widget/custom_button_widget.dart';
import 'package:evently_app/core/widget/custom_icon_button_widget.dart';
import 'package:evently_app/modules/provider/app_provider/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventDataModel event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);
     bool  isDark = appSettingsProvider.currentThemeMode == ThemeMode.dark;
    return Scaffold(
      appBar: CustomAppBarWidget(
        customLeadingWidget: CustomIconButtonWidget(
          isDark: isDark,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              PagesRouteName.homeLayoutScreen,
              (route) => false,
            );
          },
        ),
        customTitleWidget: Text(
          appLocalization.eventDetails,
          style: theme.textTheme.titleMedium?.copyWith(
            color:isDark ? AppColor.whiteColor : AppColor.blackColor,
          ),
        ),
        customActionListWidget: [
          CustomButtonWidget(
            isDark: isDark,
            lengthOfWidth: 32,
            lengthOfHeight: 32,
            onTap: () {
              Navigator.pushNamed(
                context,
                PagesRouteName.editEventScreen,
                arguments: widget.event,
              );
            },
            backgroundColor: isDark ? AppColor.secondDarkBlueColor : AppColor.whiteColor,
            customChildWidget: Assets.icons.editIcn.svg(width: 24, height: 24),
          ),
          SizedBox(width: 8),
          CustomButtonWidget(
            isDark: isDark,
            lengthOfWidth: 32,
            lengthOfHeight: 32,
            onTap: () async {
              EasyLoading.show();
              bool isDeleted = await FirestoreUtils.deleteEvent(widget.event);
              EasyLoading.dismiss();
              if (isDeleted) {
                ToastMessage.showSuccessMessage("Event deleted successfully");
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  PagesRouteName.homeScreen,
                  (route) => false,
                );
              } else {
                ToastMessage.showErrorMessage(
                  "Failed to delete event, please try again",
                );
              }
            },
            backgroundColor: isDark? AppColor.secondDarkBlueColor : AppColor.whiteColor,
            customChildWidget: Assets.icons.deleteIcn.svg(
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(isDark ? widget.event.categoryDarkImage : widget.event.categoryLightImage),
            SizedBox(height: 16),
            Text(
              widget.event.eventTitle,
              style: theme.textTheme.bodyLarge?.copyWith(
                color:isDark? AppColor.whiteColor : AppColor.blackColor,
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark?AppColor.lightBlueColor:Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(16.0),
                color: isDark? AppColor.secondDarkBlueColor :AppColor.whiteColor,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isDark? AppColor.secondDarkBlueColor : AppColor.customWhiteColor,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: isDark ? AppColor.lightBlueColor : Colors.transparent,
                        ),
                      ),
                      child: Assets.icons.calendarIcn.svg(
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(isDark?AppColor.lightBlueColor:AppColor.primaryColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  Column(
                    spacing: 8,
                    children: [
                      Text(
                        DateFormat("dd MMM").format(widget.event.eventDate),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: isDark ? AppColor.lightBlueColor : AppColor.blackColor,
                        ),
                      ),
                      Text(
                        EventDataModel.formatTimeOfDay(widget.event.eventTime),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color:isDark ? AppColor.whiteColor : AppColor.hintTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              appLocalization.description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color:isDark?AppColor.whiteColor :  AppColor.blackColor,
              ),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: isDark ? AppColor.secondDarkBlueColor :AppColor.whiteColor,
              ),
              child: Text(
                widget.event.eventDescription,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color:isDark? AppColor.whiteColor:  AppColor.blackColor,
                ),
              ),
            ),
          ],
        ).setHorizontalAndVerticalPadding(
          context,
          16,
          16,
          enableMediaQuery: false,
        ),
      ),
    );
  }
}
