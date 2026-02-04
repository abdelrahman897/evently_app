import 'package:flutter/material.dart';

class EventDataModel {
  static const String collectionName = "EventlyCollection";
  String? eventId;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  TimeOfDay eventTime;
  String eventCategoryId;
  String categoryLightImage;
  String categoryDarkImage;
  bool isFavourite;

  EventDataModel({
    this.eventId,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.eventTime,
    required this.eventCategoryId,
    required this.categoryLightImage,
    required this.categoryDarkImage,
    this.isFavourite = false,
  });


 static  String formatTimeOfDay(TimeOfDay time){
    final hours =time.hourOfPeriod == 0 ? 12 :time.hourOfPeriod;
    final mins = time.minute.toString().padLeft(2,'0');
    final period = time.period == DayPeriod.am ? 'AM':'PM' ;
    return "$hours:$mins $period";
  }

  static TimeOfDay parseTime(String timeStr) {
    final parts = timeStr.split(' ');
    final timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    if (parts[1] == 'PM' && hour < 12) hour += 12;
    if (parts[1] == 'AM' && hour == 12) hour = 0;
    return TimeOfDay(hour: hour, minute: minute);
  }
  Map<String, dynamic> toFireStore() {
    return {
      "eventId": eventId,
      "eventTitle": eventTitle,
      "eventDescription": eventDescription,
      "eventDate": eventDate.millisecondsSinceEpoch,
      "eventTime":formatTimeOfDay(eventTime),
      "eventCategoryId": eventCategoryId,
      "categoryLightImage": categoryLightImage,
      "categoryDarkImage": categoryDarkImage,
      "isFavourite": isFavourite,
    };
  }

  factory EventDataModel.fromFireStore(Map<String, dynamic> json) {
    return EventDataModel(
      eventId: json["eventId"],
      eventTitle: json["eventTitle"],
      eventDescription: json["eventDescription"],
      eventDate: DateTime.fromMillisecondsSinceEpoch(json["eventDate"]),
      eventTime: parseTime(json["eventTime"]),
      eventCategoryId: json["eventCategoryId"],
      categoryDarkImage: json["categoryDarkImage"],
      categoryLightImage: json["categoryLightImage"],
      isFavourite: json["isFavourite"],
    );
  }
}
