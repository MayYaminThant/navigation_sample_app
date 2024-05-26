import 'dart:async';

import 'package:dh_mobile/src/core/utils/configs_key_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/routes.dart';
import '../../presentations/views/notification/components/offer_modal.dart';
import '../../presentations/widgets/widgets.dart';
import 'db_utils.dart';

class StringUtils {
  static bool salaryStringIsZero(String? salary) {
    try {
      if (salary == null) return true;
      final salaryNumberText = salary.split(' ')[1];
      final salaryValue = double.parse(salaryNumberText);
      if (salaryValue < 1) return true;
      return false;
    } catch (e) {
      return true;
    }
  }

  static String getShortName(String firstName, String lastName) {
    return '${firstName[0]}.${lastName[0]}';
  }

  static String getFullName(String firstName, String lastName) {
    return '$firstName $lastName';
  }

  static String censorName(String? firstName, String? lastName) {
    final firstLength = firstName?.length ?? 0;
    final lastLength = lastName?.length ?? 0;
    return '${firstName?[0] ?? ''}${firstLength > 1 ? '*' * (firstLength - 1) : ''}${firstLength != 0 ? ' ' : ''}${lastName?[0] ?? ''}${lastLength > 1 ? '*' * (lastLength - 1) : ''}';
  }

  static void notificationScreenRoute(String screenName, BuildContext ctx,
      {int? id,
      String? expiry,
      String? salary,
      String? currency,
      int? employerId,
      int? notificationId,
      String? action}) {
    switch (screenName) {
      case 'A40':
        Get.offAllNamed(phluidCoinsPageRoute);
        break;

      case 'A56':
        Get.offAllNamed(requestChatPageRoute, parameters: {'route': rootRoute});
        break;

      case 'A26':
        Get.offAllNamed(articlesAndEventsDetailPageRoute,
            parameters: {'id': id.toString()});
        break;

      case 'A54':
        Get.offAllNamed(chatListPageRoute, parameters: {'route': rootRoute});
        break;

      case 'notification2':
        if (action != null && action != '') {
          bool isDialogOpen = false;
          showDialog(
            context: ctx,
            barrierDismissible: false,
            builder: (context) {
              isDialogOpen = true;
              void closeDialog() {
                if (ctx.mounted) {
                  isDialogOpen ? Navigator.of(ctx).pop() : null;
                  isDialogOpen = false;
                }
              }

              Timer(const Duration(seconds: 3), () => closeDialog());
              return WillPopScope(
                onWillPop: () async {
                  isDialogOpen = false;
                  return true;
                },
                child: AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: SizedBox(
                    width: 300,
                    child: InfoPopup(
                        title: 'Info',
                        message: 'You have already ${action}ed this offer.',
                        type: 'info'),
                  ),
                ),
              );
            },
          );
        } else {
          showOfferModal(ctx,
              expiry: expiry,
              salary: salary,
              currency: currency,
              notificationId: notificationId,
              employerId: employerId);
        }

        break;
    }
  }

  static Future<List<dynamic>?> getExchangeList() async {
    return await DBUtils.getKeyDataList(ConfigsKeyHelper.exchangePHCkey)
        as List<dynamic>;
  }

  static Future<int?> getWorkPermitValue() async {
    return await DBUtils.getKeyDataList(ConfigsKeyHelper.workPermitKey);
  }

  static Future<int?> getWorkPermitVerifyDelayValue() async {
    return await DBUtils.getKeyDataList(ConfigsKeyHelper.workPermitVerifyDelay)
        as int;
  }

  static void showOfferModal(context,
      {String? expiry,
      String? salary,
      String? currency,
      int? notificationId,
      int? employerId}) {
    Get.dialog(
      AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: OfferModal(
            expiry: expiry,
            salary: salary,
            currency: currency,
            notificationId: notificationId,
            employerId: employerId),
      ),
      barrierDismissible: true,
    );
  }
}
