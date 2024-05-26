import 'package:dh_employer/src/core/utils/login_resume.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/routes.dart';
import '../../presentations/views/profile/components/empty_profile_container.dart';
import '../../presentations/widgets/widgets.dart';
import 'db_utils.dart';

void showErrorSnackBar(
  String message, {
  String? title,
  bool? barrierDismissible,
  Function? autoDismissCallback,
}) {
  showInfoModal(
      title: title,
      message: message,
      barrierDismissible: barrierDismissible,
      autoDismissCallback: autoDismissCallback,
      type: 'error');
}

void showSuccessSnackBar(
  String message, {
  bool? barrierDismissible,
  Function? autoDismissCallback,
}) {
  showInfoModal(
      message: message,
      barrierDismissible: barrierDismissible,
      autoDismissCallback: autoDismissCallback,
      type: 'success');
}

showEmptyProfileModal(BuildContext context, {String? route}) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Builder(
              builder: (context) {
                return SizedBox(
                  width: 300,
                  child: EmptyProfileContainer(route: route),
                );
              },
            ),
          ));
}

showInfoModal(
    {String? title,
    String? message,
    bool? barrierDismissible,
    Function? autoDismissCallback,
    int? durationInSec,
    required String type}) {
  if (message == 'Unauthenticated.') {
    DBUtils.clearLoginIn();
    final loginResume = LoginResume();
    loginResume.saveCurrentState(
        Get.currentRoute, Get.parameters, Get.arguments);
    Get.offAllNamed(signInPageRoute);
    showErrorSnackBar('You have been logged out, please log in again.',
        barrierDismissible: true);
    return;
  }

  if (message != null &&
      message.contains('Your account is currently under probation')) {
    DBUtils.clearLoginIn();
    Get.offAllNamed(signInPageRoute);
  }

  Future.delayed(const Duration(milliseconds: 100), () {
    Get.dialog(
        barrierDismissible: barrierDismissible ?? true,
        AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(
            builder: (context) {
              return SizedBox(
                width: 300,
                child: InfoPopup(title: title, message: message, type: type),
              );
            },
          ),
        ));
  }).then((value) {
    Future.delayed(Duration(seconds: durationInSec ?? 6), () {
      if (!(Get.isDialogOpen ?? true)) return;
      Get.back();
      if (autoDismissCallback != null) {
        autoDismissCallback();
      }
    });
  });
}

showCustomDialogModal(
    {String? title,
    String? message,
    required String buttonText,
    String? secondaryButtonText,
    required VoidCallback onButtonClick,
    VoidCallback? onSecondaryButtonClick,
    Future<bool> Function()? onWillPop,
    bool? barrierDismissible,
    bool? autoDismiss,
    Function? autoDismissCallback}) {
  Get.dialog(
      barrierDismissible: barrierDismissible ?? true,
      WillPopScope(
          onWillPop: onWillPop,
          child: CustomDialogSimple(
            title: title,
            message: message ?? '',
            positiveText: buttonText,
            negativeText: secondaryButtonText,
            onButtonClick: onButtonClick,
            onNegativeButtonClick: onSecondaryButtonClick,
          )));

  if (!(autoDismiss ?? true)) {
    return;
  }
  Future.delayed(const Duration(seconds: 6), () {
    if (!(Get.isDialogOpen ?? true)) return;
    Get.back();
    if (autoDismissCallback != null) {
      autoDismissCallback();
    }
  });
}
