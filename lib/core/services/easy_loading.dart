import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void configLoading(){
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 12.0
    ..backgroundColor = AppColor.whiteColor
    ..indicatorColor = AppColor.primaryColor
    ..textColor = AppColor.primaryColor
    ..maskColor = AppColor.blackColor
    ..userInteractions = false
    ..dismissOnTap = false;
}