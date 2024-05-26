import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/routes.dart';
import 'configs_key_helper.dart';
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

  static getShortName(String firstName, String lastName) {
    if (firstName.isEmpty || lastName.isEmpty) return '';
    if (firstName.isEmpty) return lastName[0];
    if (lastName.isEmpty) return firstName[0];
    return '${firstName[0]}.${lastName[0]}';
  }

  static getFullName(String firstName, String lastName) {
    return '$firstName $lastName';
  }

  static censorName(String? firstName, String? lastName) {
    final firstLength = firstName?.length ?? 0;
    final lastLength = lastName?.length ?? 0;

    return '${firstName?[0] ?? ''}${firstLength > 1 ? '*' * (firstLength-1) : ''}${firstLength != 0 ? ' ' : ''}${lastName?[0] ?? ''}${lastLength > 1 ? '*' * (lastLength-1) : ''}';
  }

  static notificationScreenRoute(String screenName, BuildContext context,
      {int? id}) {
    switch (screenName) {
      case 'A40':
        Get.toNamed(phluidCoinsPageRoute);
        break;

      case 'A56':
        Get.toNamed(requestChatPageRoute, parameters: {'route': rootRoute});
        break;

      case 'A26':
        Get.toNamed(articlesAndEventsDetailPageRoute,
            parameters: {'id': id.toString()});
        break;

      case 'A54':
        Get.toNamed(chatListPageRoute, parameters: {'route': rootRoute});
        break;
    }
  }

  static getExchangeList() async {
    return await DBUtils.getKeyDataList(ConfigsKeyHelper.exchangePHCkey)
        as List<dynamic>;
  }
}
