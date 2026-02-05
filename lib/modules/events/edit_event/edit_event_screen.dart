import 'package:evently_app/core/extension/padding_extension.dart';
import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/model/event_category_model.dart';
import 'package:evently_app/core/model/event_data_model.dart';
import 'package:evently_app/core/routes/pages_route_name.dart';
import 'package:evently_app/core/services/toast_message.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/utils/firestore/firestore_utils.dart';
import 'package:evently_app/core/widget/custom_app_bar_widget.dart';
import 'package:evently_app/core/widget/custom_choice_chip_widget.dart';
import 'package:evently_app/core/widget/custom_elevated_button_widget.dart';
import 'package:evently_app/core/widget/custom_icon_button_widget.dart';
import 'package:evently_app/core/widget/custom_text_form_field_widget.dart';
import 'package:evently_app/modules/provider/app_provider/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  final EventDataModel event;
  const EditEventScreen({super.key, required this.event,});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  int selectedItem = 0;
  DateTime? selectedEventDate;
  TimeOfDay? selectedEventTime;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.event.eventTitle;
    descriptionController.text = widget.event.eventDescription;
    selectedEventDate = widget.event.eventDate;
    selectedEventTime = widget.event.eventTime;
    selectedItem = EventCategoryModel.categoryList.indexWhere(
          (element) => element.id == widget.event.eventCategoryId,
    );

    if (selectedItem == -1) selectedItem = 0;
  }
  void getSelectedDate() async {
    var currentDateTime = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    setState(() {
      selectedEventDate = currentDateTime;
    });
  }

  bool isDataChanged() {
    return titleController.text != widget.event.eventTitle ||
        descriptionController.text != widget.event.eventDescription ||
        selectedEventDate != widget.event.eventDate ||
        selectedEventTime != widget.event.eventTime ||
        EventCategoryModel.categoryList[selectedItem].id != widget.event.eventCategoryId;
  }
  void getSelectedTime() async {
    var currentsTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (currentsTime != null) {
      setState(() {
        selectedEventTime = currentsTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final categoryList = EventCategoryModel.categoryList;
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);
     bool  isDark = appSettingsProvider.currentThemeMode == ThemeMode.dark;
    return Scaffold(
      appBar: CustomAppBarWidget(
        customLeadingWidget: CustomIconButtonWidget(
          isDark: isDark,
          onPressed: () {
            Navigator.pushReplacementNamed(context, PagesRouteName.homeLayoutScreen);
          },
        ),
        customTitleWidget: Text(
          appLocalization.editEvent,
          style: theme.textTheme.titleMedium?.copyWith(
            color: isDark? AppColor.whiteColor : AppColor.blackColor,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(isDark ? EventCategoryModel.categoryList[selectedItem].darkImagePath: EventCategoryModel.categoryList[selectedItem].lightImagePath),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categoryList.length, (index) {
                  final isSelected = (selectedItem == index);
                  return CustomChoiceChipWidget(
                    title: categoryList[index].name(appLocalization),
                    customChildWidget: Icon(
                      categoryList[index].icon,
                      color:
                      isSelected
                          ? AppColor.whiteColor
                          : (isDark?AppColor.lightBlueColor :AppColor.primaryColor),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedItem = index;
                      });
                    },
                  );
                }),
              ),
            ),
            SizedBox(height: 16),
            Text(
              appLocalization.title,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isDark? AppColor.whiteColor : AppColor.blackColor,
              ),
            ),
            SizedBox(height: 16),
            CustomTextFormFieldWidget(isDark:isDark,text: appLocalization.eventTitle,controller: titleController,validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Enter title";
              }
              return null;
            }),
            SizedBox(height: 16),
            Text(
              appLocalization.description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isDark ? AppColor.whiteColor : AppColor.blackColor,
              ),
            ),
            SizedBox(height: 8),
            CustomTextFormFieldWidget(isDark:isDark,text: appLocalization.eventDescription,controller: descriptionController,maxLines: 4, validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Enter description";
              }
              return null;
            },),
            SizedBox(height: 16),
            Row(
              children: [
                Assets.icons.calendarIcn.svg(width: 24, height: 24,colorFilter: ColorFilter.mode(isDark?AppColor.lightBlueColor:AppColor.primaryColor, BlendMode.srcIn),),
                SizedBox(width: 4),
                Text(
                  appLocalization.eventDate,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDark ?AppColor.whiteColor  : AppColor.blackColor,
                  ),
                ),
                Spacer(),
                Bounceable(
                  onTap: () {
                    getSelectedDate();
                  },
                  child: Text(
                    selectedEventDate != null ?
                    DateFormat('dd MMM yyyy').format(selectedEventDate!)
                    :DateFormat('dd MMM yyyy').format(widget.event.eventDate),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark? AppColor.lightBlueColor:AppColor.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor:isDark? AppColor.lightBlueColor: AppColor.primaryColor,
                      decorationThickness: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Assets.icons.clockIcn.svg(width: 24, height: 24,colorFilter: ColorFilter.mode(isDark?AppColor.lightBlueColor:AppColor.primaryColor, BlendMode.srcIn),),
                SizedBox(width: 4),
                Text(
                  appLocalization.eventTime,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDark? AppColor.whiteColor:AppColor.blackColor,
                  ),
                ),
                Spacer(),
                Bounceable(
                  onTap: () {
                    getSelectedTime();
                  },
                  child: Text(
                    selectedEventTime != null ?
                    EventDataModel.formatTimeOfDay(selectedEventTime!)
                    : EventDataModel.formatTimeOfDay(widget.event.eventTime),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark? AppColor.lightBlueColor : AppColor.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor:isDark? AppColor.lightBlueColor:  AppColor.primaryColor,
                      decorationThickness: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButtonWidget(
                    backgroundColor: isDark? AppColor.lightBlueColor : AppColor.primaryColor,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (!isDataChanged()) {
                          ToastMessage.showWarningMessage("No changes made to update");
                          return;
                        }
                        EventDataModel updateData = EventDataModel(
                          eventId: widget.event.eventId,
                          eventTitle: titleController.text,
                          eventDescription: descriptionController.text,
                          eventDate: selectedEventDate!,
                          eventTime: selectedEventTime!,
                          eventCategoryId: categoryList[selectedItem].id,
                          categoryLightImage:
                          categoryList[selectedItem].lightImagePath,
                          categoryDarkImage:
                          categoryList[selectedItem].darkImagePath,
                        );
                        EasyLoading.show();
                        Future.delayed(Duration(seconds: 2), () {
                          FirestoreUtils.updateEvent(updateData).then((value) {
                            EasyLoading.dismiss();
                            if (value) {
                              ToastMessage.showSuccessMessage(
                                "Event updated successfully",
                              );
                              Navigator.pop(context);
                            } else {
                              ToastMessage.showErrorMessage(
                                "Event failed updated",
                              );
                            }
                          });
                        });
                      }
                    },
                    customChildWidget: Text(
                      appLocalization.updateEvent,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).setHorizontalAndVerticalPadding(
          context,
          16,
          16,
          enableMediaQuery: false,
        ),
      ),
      ),
    );
  }
}
