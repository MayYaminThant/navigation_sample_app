import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/routes.dart';
import '../../presentations/views/profile/components/empty_profile_container.dart';
import '../../presentations/widgets/widgets.dart';
import 'db_utils.dart';
import 'login_resume.dart';

void showErrorSnackBar(String message,
    {bool? barrierDismissible, String? title, int? duration}) {
  showInfoModal(
      title: title,
      message: message,
      type: 'error',
      duration: duration,
      barrierDismissible: barrierDismissible);
}

void showSuccessSnackBar(String message) {
  showInfoModal(message: message, type: 'success');
}

void showEmptyProfileModal(BuildContext context, {String? route}) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: SizedBox(
            width: 300,
            child: EmptyProfileContainer(route: route),
          )));
}

showInfoModal(
    {String? title,
    String? message,
    bool? barrierDismissible,
    int? duration,
    required String type}) {
  if (message == 'Unauthenticated.') {
    print("RESUMING NOW");
    DBUtils.clearLoginIn();
    final loginResume = LoginResume();
    final success = loginResume.saveCurrentState(
        Get.currentRoute, Get.parameters, Get.arguments);
    if (!success) {
      return;
    }
    Get.offAllNamed(signInPageRoute);
    showErrorSnackBar('You have been logged out, please log in again.'.tr,
        barrierDismissible: true);
    return;
  }

  Get.dialog(barrierDismissible: barrierDismissible ?? true,
      StatefulBuilder(builder: (context, setState) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SizedBox(
        width: 300,
        child: InfoPopup(title: title, message: message ?? '', type: type),
      ),
    );
  }));
  Future.delayed(const Duration(milliseconds: 100), () {}).then((value) {
    Future.delayed(Duration(seconds: duration ?? 3), () {
      if (!(Get.isDialogOpen ?? true)) return;
      Get.back();
    });
  });
}
