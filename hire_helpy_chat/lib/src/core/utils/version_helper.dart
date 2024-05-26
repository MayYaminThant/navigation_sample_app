import 'package:dh_employer/src/core/utils/db_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'configs_key_helper.dart';
import 'environment_manager.dart';

class VersionHelper {
  static Future<void> storeCurrentConfigDetails() async {
    final AppVersion currentAppVersion = await getCurrentAppVersion();
    Box box = await Hive.openBox(DBUtils.dbName);
    box.put(DBUtils.configRetrievalAppEnvironment, '$currentEnvironment');
    box.put(DBUtils.configRetrievalAppVersion, currentAppVersion.versionString);
  }

  static Future<bool> shouldRefreshConfig() async {
    return await configAppVersionChanged() || await configEnvironmentChanged();
  }

  static Future<bool> configEnvironmentChanged() async {
    try {
      final currentEnvironmentString = '$currentEnvironment';
      final configRetrievalEnvironmentString =
          await getConfigRetrievalEnvironment();
      if (configRetrievalEnvironmentString == null) return true;
      return !(currentEnvironmentString == (configRetrievalEnvironmentString));
    } catch (e) {
      return true;
    }
  }

  static Future<String?> getConfigRetrievalEnvironment() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    final configRetrievalEnvironmentString =
        box.get(DBUtils.configRetrievalAppEnvironment);
    return configRetrievalEnvironmentString;
  }

  static Future<bool> configAppVersionChanged() async {
    try {
      final AppVersion currentAppVersion = await getCurrentAppVersion();
      final AppVersion? configRetrievalAppVersion =
          await getConfigRetrievalAppVersion();
      if (configRetrievalAppVersion == null) return true;
      return !currentAppVersion.isEqualTo(configRetrievalAppVersion);
    } catch (e) {
      return true;
    }
  }

  static Future<AppVersion?> getConfigRetrievalAppVersion() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    final configRetrievalVersionString =
        box.get(DBUtils.configRetrievalAppVersion);
    if (configRetrievalVersionString == null) return null;
    return AppVersion.fromVersionString(configRetrievalVersionString);
  }

  static Future<bool> shouldForceUpdate() async {
    try {
      final AppVersion currentAppVersion = await getCurrentAppVersion();
      final AppVersion minCompatibleVersion =
          await getMinimumCompatibleVersion();
      final shouldForceUpdate =
          minCompatibleVersion.isGreaterThan(currentAppVersion);
      return shouldForceUpdate;
    } catch (e) {
      return false;
    }
  }

  static Future<AppVersion> getCurrentAppVersion() async {
    WidgetsFlutterBinding.ensureInitialized();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return AppVersion(
        version: packageInfo.version, buildNumber: packageInfo.buildNumber);
  }

  static Future<AppVersion> getMinimumCompatibleVersion() async {
    final minCompatibleVersionString = await DBUtils.getEmployerConfigs(
        ConfigsKeyHelper.employerAppMinCompatibleVersionKey) as String;
    return AppVersion.fromVersionString(minCompatibleVersionString);
  }
}

class AppVersion {
  final String version;
  final String buildNumber;

  AppVersion({required this.version, required this.buildNumber});

  factory AppVersion.fromVersionString(String versionString) {
    final versionParts = versionString.split('+');
    return AppVersion(version: versionParts[0], buildNumber: versionParts[1]);
  }

  bool isGreaterThan(AppVersion otherVersion) {
    // compare version number
    List<String> myV = version.split('.');
    List<String> otherV = otherVersion.version.split('.');
    if (myV.length != otherV.length) {
      throw Exception('Unable to compare version numbers');
    }
    for (var i = 0; i < myV.length; i++) {
      final myN = int.parse(myV[i]);
      final otherN = int.parse(otherV[i]);
      if (otherN == myN) {
        continue;
      }
      return myN > otherN;
    }

    // if version number is the same, compare build numbers
    final myBuildNumber = int.parse(buildNumber);
    final otherBuildNumber = int.parse(otherVersion.buildNumber);
    return myBuildNumber > otherBuildNumber;
  }

  bool isEqualTo(AppVersion otherVersion) {
    if (version != otherVersion.version) return false;
    if (buildNumber != otherVersion.buildNumber) return false;
    return true;
  }

  String get versionString {
    return '$version+$buildNumber';
  }
}
