
import 'package:dh_mobile/src/core/utils/db_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../config/routes/routes.dart';

final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

Future<void> iosPermission() async {
  NotificationSettings settings = await firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //superPrint('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    //superPrint('User granted provisional permission');
  } else {
    //superPrint('User declined or has not accepted permission');
  }
}

void goToRegisterPage(String link) async {
  Box box = await Hive.openBox(DBUtils.dbName);
  Map? data = box.get(DBUtils.candidateTableName);
  if (link.contains('profile')) {
    String profileId = link.split('/')[link.split('/').length - 1];
    Get.offAllNamed(employeerProfilePageRoute,
        parameters: {'id': profileId, 'route': rootRoute});
  } else if (link.contains('articles')) {
    String articleId = link.split('/')[link.split('/').length - 1];
    Get.offAllNamed(articlesAndEventsDetailPageRoute, parameters: {
      'id': articleId.toString(),
      'showLikes': 'true',
      'route': rootRoute
    });
  } else if (link.contains('news')) {
    String articleId = link.split('/')[link.split('/').length - 1];
    Get.offAllNamed(newsDetailPageRoute,
        parameters: {'id': articleId.toString(), 'route': rootRoute});
  } else {
    String? country = box.get(DBUtils.country);
    String? language = box.get(DBUtils.language);

    if (data == null) {
      String referCode = link.split('/')[link.split('/').length - 1];
      if (country != null && language != null) {
        Get.offAllNamed(registerPageRoute,
            parameters: {'refer_code': referCode});
      } else {
        Get.offAllNamed(languageCountryPageRoute,
            parameters: {'refer_code': referCode});
      }
    } else {
      // ignore: use_build_context_synchronously
      Get.offAllNamed(installedPageRoute);
    }
  }
}
