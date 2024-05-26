import 'dart:io';

import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DBUtils {
  static String stroagePrefix = 'STORAGE_PREFIX';
  static String candidateTableName = 'candidate';
  static String dbName = 'candidateDb';
  static String loginName = 'loginName';
  static String tempFiles = 'temp_files';
  static String tempCandidate = 'temp_candidate';
  static String email = 'email';
  static String phone = 'phone';
  static String language = 'language';
  static String phoneCountry = "phone_country";
  static String country = 'country';
  static String tempSupport = 'temp_support';
  static String lastTimeStamp = 'last_timestamp';
  static String singleSession =
      'single_session_${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
  static String configRetrievalAppVersion = 'config_retrieval_app_version';
  static String configRetrievalAppEnvironment = 'config_retrieval_app_environment';
  static String dhConfig = 'config';

  static Future<void> saveNewData(
      Map<String, dynamic>? data, String name) async {
    Box box = await Hive.openBox(dbName);
    box.put(name, data!['data']);
  }

  static Future<void> saveConfigsData(
      Map<String, dynamic>? data, String name) async {
    Box box = await Hive.openBox(dbName);
    box.put(name, data);
  }

  static Future<dynamic> get getCountryList => getCandidateConfigs('countries');

  static Future<dynamic> get getLanguageList =>
      getCandidateConfigs('language_types');

  static Future<dynamic> getKeyDataList(key) => getCandidateConfigs(key);

  static dynamic getCandidateConfigs(String? name) async {
    Box box = await Hive.openBox(dbName);
    var configData = name != null
        ? box.get('configs')['data'][name]
        : box.get('configs')['data'];
    return configData;
  }

  static Future<void> clearLoginIn() async {
    Box box = await Hive.openBox(dbName);
    await box.delete(candidateTableName);
    await box.delete(tempFiles);
    await box.delete(tempCandidate);
  }

  static Future<void> saveListData(List<String>? data, String name) async {
    Box box = await Hive.openBox(dbName);
    box.put(name, data);
  }

  static Future<void> saveString(String data, String name) async {
    Box box = await Hive.openBox(dbName);
    box.put(name, data);
  }

  static Future<void> clearData(String name) async {
    Box box = await Hive.openBox(dbName);
    await box.delete(name);
  }

  static Future<Directory> createFolder() async {
    String folderName = "DH Mobile";
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
