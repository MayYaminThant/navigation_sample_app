import 'dart:developer';

import 'package:zego_zimkit/services/services.dart';
import 'package:zego_zpns/zego_zpns.dart';

class ZPNsEventHandlerManager {
  static loadingEventHandler() {
    
    ZPNsEventHandler.onRegistered = (pushID) {
      log(pushID.toString());
    };
  }
}

class ZegoUtils{
  static loginToZimKit(String userId, String userName) async {
    await ZIMKit()
        .connectUser(
            id: userId,
            name: userName)
        .then((errorCode) {});
  }
}

