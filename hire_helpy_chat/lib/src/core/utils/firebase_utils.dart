import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../config/routes/routes.dart';
import 'db_utils.dart';

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
    //print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    //print('User granted provisional permission');
  } else {
    //print('User declined or has not accepted permission');
  }
}

goToRegisterPage(String link) async {
  Box box = await Hive.openBox(DBUtils.dbName);
  Map? data = box.get(DBUtils.employerTableName);
  if (link.contains('profile')) {
    String profileId = link.split('/')[link.split('/').length - 1];
    Get.offAndToNamed(candidateProfilePageRoute,
        arguments: {'id': int.parse(profileId), 'route': rootRoute});
  } else if (link.contains('articles')) {
    String articleId = link.split('/')[link.split('/').length - 1];
    Get.offAndToNamed(articlesAndEventsDetailPageRoute, parameters: {
      'id': articleId.toString(),
      'showLikes': 'true',
      'route': rootRoute
    });
  } else if (link.contains('news')) {
    String articleId = link.split('/')[link.split('/').length - 1];
    Get.offAndToNamed(newsDetailPageRoute,
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
      Get.offAllNamed(installedPageRoute);
    }
  }
}
