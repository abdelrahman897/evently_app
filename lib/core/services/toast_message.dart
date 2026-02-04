import 'package:bot_toast/bot_toast.dart';
import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class ToastMessage {
  static void showSuccessMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 14.0,
            ),
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Assets.icons.successIcn.svg(width: 24, height: 24),
                ),
                const SizedBox(width: 6),
                Expanded(
                  flex: 8,
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 14,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: cancelFunc,
                    icon: Icon(
                      Icons.close_outlined,
                      color: AppColor.darkGreyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      duration: Duration(seconds: 5),
      dismissDirections: [DismissDirection.endToStart],
    );
  }

  static void showWarningMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 14.0,
            ),
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Assets.icons.warningIcn.image(width: 24, height: 24),
                ),
                const SizedBox(width: 6),
                Expanded(
                  flex: 8,
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 14,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: cancelFunc,
                    icon: Icon(
                      Icons.close_outlined,
                      color: AppColor.darkGreyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      duration: const Duration(seconds: 5),
      dismissDirections: const [DismissDirection.endToStart],
    );
  }

  static void showErrorMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 14.0,
            ),
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Assets.icons.errorIcn.svg(width: 24, height: 24),
                ),
                const SizedBox(width: 6),
                Expanded(
                  flex: 8,
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 14,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: cancelFunc,
                    icon: Icon(
                      Icons.close_outlined,
                      color: AppColor.darkGreyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      duration: const Duration(seconds: 5),
      dismissDirections: const [DismissDirection.endToStart],
    );
  }
}
