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
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectedItem = 0;
  DateTime? selectedEventDate;
  TimeOfDay? selectedEventTime;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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

  void resetFields() {
    setState(() {
      titleController.clear();
      descriptionController.clear();
      selectedEventDate = null;
      selectedEventTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final categoryList = EventCategoryModel.categoryList;
    return Scaffold(
      appBar: CustomAppBarWidget(
        customLeadingWidget: CustomIconButtonWidget(
          onPressed: () {
            Navigator.pushReplacementNamed(context, PagesRouteName.homeLayoutScreen);
          },
        ),
        customTitleWidget: Text(
          appLocalization.addEvent,
          style: theme.textTheme.titleMedium?.copyWith(
            color: AppColor.blackColor,
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
              Image.asset(categoryList[selectedItem].lightImagePath),
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
                                : AppColor.primaryColor,
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
                  color: AppColor.blackColor,
                ),
              ),
              SizedBox(height: 8),
              CustomTextFormFieldWidget(
                text: appLocalization.eventTitle,
                controller: titleController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter title";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                appLocalization.description,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor.blackColor,
                ),
              ),
              SizedBox(height: 8),
              CustomTextFormFieldWidget(
                text: appLocalization.eventDescription,
                maxLines: 4,
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter description";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Assets.icons.calendarIcn.svg(width: 24, height: 24),
                  SizedBox(width: 4),
                  Text(
                    appLocalization.eventDate,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColor.blackColor,
                    ),
                  ),
                  Spacer(),
                  Bounceable(
                    onTap: () {
                      getSelectedDate();
                    },
                    child: Text(
                      selectedEventDate != null
                          ? DateFormat("dd,MMM,yyyy").format(selectedEventDate!)
                          : appLocalization.chooseDate,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColor.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.primaryColor,
                        decorationThickness: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Assets.icons.clockIcn.svg(width: 24, height: 24),
                  SizedBox(width: 4),
                  Text(
                    appLocalization.eventTime,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColor.blackColor,
                    ),
                  ),
                  Spacer(),
                  Bounceable(
                    onTap: () {
                      getSelectedTime();
                    },
                    child: Text(
                      selectedEventTime != null
                          ? EventDataModel.formatTimeOfDay(selectedEventTime!)
                          : appLocalization.chooseTime,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColor.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.primaryColor,
                        decorationThickness: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButtonWidget(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (selectedEventDate == null || selectedEventTime == null) {
                            ToastMessage.showErrorMessage("Please select date and time");
                            return;
                          }
                          EventDataModel data = EventDataModel(
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
                            FirestoreUtils.addEvent(data).then((value) {
                              EasyLoading.dismiss();
                              if (value) {
                                ToastMessage.showSuccessMessage(
                                  "Event created successfully",
                                );
                                Navigator.pushReplacementNamed(context, PagesRouteName.homeLayoutScreen);
                              } else {
                                ToastMessage.showErrorMessage(
                                  "Event failed created",
                                );
                              }
                            });
                          });
                          resetFields();
                        }
                      },
                      customChildWidget: Text(
                        appLocalization.addEvent,
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
