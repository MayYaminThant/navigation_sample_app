import 'dart:io';

import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DBUtils {
  static String stroagePrefix = 'STORAGE_PREFIX';
  static String dbName = 'employerDb';
  static String employerTableName = 'employer';
  static String loginName = 'loginName';
  static String tempFiles = 'temp_files';
  static String tempEmployer = 'temp_employer';
  static String email = 'email';
  static String phone = 'phone';
  static String language = 'language';
  static String country = 'country';
  static String signInCountry = 'sign_in_country';
  static String signinCountryCallCode = 'sign_in_country_call_code';
  static String tempSupport = 'temp_support';
  static String lastTimeStamp = 'last_timestamp';
  static String singleSession =
      'single_session_${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
  static String configRetrievalAppVersion = 'config_retrieval_app_version';
  static String configRetrievalAppEnvironment = 'config_retrieval_app_environment';
  static String dhConfig = 'config';

  static saveNewData(Map<String, dynamic>? data, String name) async {
    Box box = await Hive.openBox(dbName);
    box.put(name, data!['data']);
  }

  static saveConfigsData(Map<String, dynamic>? data, String name) async {
    Box box = await Hive.openBox(dbName);
    box.put(name, data);
  }

  static Future<dynamic> getKeyDataList(key) => getEmployerConfigs(key);
  static Future<dynamic> get getCountryList => getEmployerConfigs('countries');

  static Future<dynamic> get getCountryOfWorkList =>
      getEmployerConfigs('country_of_work');

  static getEmployerConfigs(String name) async {
    Box box = await Hive.openBox(dbName);
    try {
      var configItem = box.get('configs')['data'][name];
      return configItem;
    } catch (e) {
      throw Exception('CONFIG DOES NOT EXIST');
      return null;
    }
  }

  static clearLoginIn() async {
    Box box = await Hive.openBox(dbName);
    await box.delete(employerTableName);
    await box.delete(tempFiles);
    await box.delete(tempEmployer);
  }

  static saveListData(List<String>? data, String name) async {
    Box box = await Hive.openBox(dbName);
    box.put(name, data);
  }

  static saveString(String data, String name) async {
    Box box = await Hive.openBox(dbName);
    box.put(name, data);
  }

  static clearData(String name) async {
    Box box = await Hive.openBox(dbName);
    await box.delete(name);
  }

  static createFolder() async {
    String folderName = "Hire Helpy";
    final dir = Directory(
        '${(Platform.isAndroid ? await getExternalStorageDirectory() //FOR ANDROID
                : await getApplicationDocumentsDirectory() //FOR IOS
            )!.path}/$folderName');

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await dir.exists())) {
      return dir;
    } else {
      dir.create();
      return dir;
    }
  }
}
