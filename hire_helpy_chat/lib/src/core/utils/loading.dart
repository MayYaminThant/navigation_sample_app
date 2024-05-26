import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../presentations/values/values.dart';

class Loading {
  static confligLogin() {
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
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  static showLoading({required String message}) async {
    await EasyLoading.show(
        status: message,
        maskType: EasyLoadingMaskType.custom,
        dismissOnTap: false);
  }

  static cancelLoading() async {
    await EasyLoading.dismiss();
  }
}
