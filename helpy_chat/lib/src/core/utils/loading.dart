import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../presentations/values/values.dart';

class Loading {
  static void confligLogin() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 30.0
      ..radius = 10.0
      ..progressColor = AppColors.primaryColor
      ..maskColor = AppColors.black.withOpacity(0.2)
      ..indicatorColor = AppColors.primaryColor
      ..textColor = AppColors.primaryColor
      ..backgroundColor = AppColors.black
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static Future<void> showLoading({required String message}) async {
    if (!EasyLoading.isShow) {
      await EasyLoading.show(
          status: message,
          maskType: EasyLoadingMaskType.custom,
          dismissOnTap: false);
    }
  }

  static Future<void> cancelLoading() async {
    if (EasyLoading.isShow) {
      await EasyLoading.dismiss();
    }
  }
}
