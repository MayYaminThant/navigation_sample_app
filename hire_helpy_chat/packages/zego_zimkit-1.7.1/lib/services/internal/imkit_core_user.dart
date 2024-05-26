part of 'imkit_core.dart';

extension ZIMKitCoreUser on ZIMKitCore {
  Future<int> connectUser(
      {required String id, String name = '', String avatarUrl = ''}) async {
    if (!isInited) {
      ZIMKitLogger.info('is not inited.');
      throw Exception('ZIMKit is not inited.');
    }
    if (currentUser != null) {
      ZIMKitLogger.info('has login, auto logout');
      await disconnectUser();
    }

    ZIMKitLogger.info('login request, user id:$id, user name:$name');
    currentUser = ZIMUserFullInfo()
      ..baseInfo.userID = id
      ..baseInfo.userName = name.isNotEmpty ? name : id;

    ZIMKitLogger.info('ready to login..');
    final connectResult =
        await ZegoUIKitSignalingPlugin().connectUser(id: id, name: name);

    if (connectResult.error == null) {
      ZIMKitLogger.info('login success');

      await updateUserInfo(avatarUrl: avatarUrl);

      // query currentUser's full info
      queryUser(currentUser!.baseInfo.userID).then((ZIMUserFullInfo zimResult) {
        currentUser = zimResult;
        loginCompleter?.complete();
      });

      return 0;
    } else {
      ZIMKitLogger.info('login error, ${connectResult.error}');
      return int.parse(connectResult.error!.code);
    }
  }

  Future<void> disconnectUser() async {
    ZIMKitLogger.info('logout.');
    clear();
    ZegoUIKitSignalingPlugin().disconnectUser().then((result) {
      if (result.timeout) {
        ZIMKitLogger.warning('logout timeout');
      }
    });
  }

  Future<void> waitForLoginOrNot() async {
    if (currentUser == null) {
      ZIMKitLogger.info('wait for login...');
      loginCompleter ??= Completer();
      await loginCompleter!.future;
      loginCompleter = null;
    }
  }

  Future<int> checkNeedReloginOrNot(Exception error) async {
    if (error is PlatformException &&
        int.parse(error.code) == ZIMErrorCode.networkModuleUserIsNotLogged &&
        currentUser != null) {
      ZIMKitLogger.info('try auto relogin.');
      return connectUser(
          id: currentUser!.baseInfo.userID,
          name: currentUser!.baseInfo.userName);
    } else {
      return -1;
    }
  }

  // TODO 优化，如果短时间内来了大量请求，合并请求再调sdk
  Future<ZIMUserFullInfo> queryUser(String id,
      {bool isQueryFromServer = true}) async {
    await waitForLoginOrNot();
    final queryHash = Object.hash(id, isQueryFromServer);
    if (_queryUserCache[queryHash] == null) {
      _queryUserCache[queryHash] = AsyncCache(const Duration(minutes: 5));
    }
    return _queryUserCache[queryHash]!.fetch(() async {
      ZIMKitLogger.info(
          'queryUser, id:$id, isQueryFromServer:$isQueryFromServer');
      final config = ZIMUserInfoQueryConfig()
        ..isQueryFromServer = isQueryFromServer;
      return ZIM.getInstance()!.queryUsersInfo([id], config).then(
          (ZIMUsersInfoQueriedResult result) {
        return result.userList.first;
      }).catchError((error) {
        Timer.run(() => _queryUserCache[queryHash]?.invalidate());

        // qps limit
        if (error is PlatformException && int.parse(error.code) == 6000012) {
          if (isQueryFromServer) {
            ZIMKitLogger.info('queryUser faild, retry queryUser from sdk');
            return queryUser(id, isQueryFromServer: false);
          } else {
            ZIMKitLogger.info(
                'queryUser from sdk faild, retry queryUser from server later');
            return Future.delayed(
              Duration(milliseconds: Random().nextInt(5000)),
              () => queryUser(id),
            );
          }
        }

        return checkNeedReloginOrNot(error).then((retryCode) {
          if (retryCode == 0) {
            ZIMKitLogger.info('relogin success, retry queryUser');
            return queryUser(id);
          } else {
            ZIMKitLogger.severe('queryUser faild', error);
            throw error;
          }
        });
      });
    });
  }

  Future<void> updateUserInfo({String name = '', String avatarUrl = ''}) async {
    if (name.isNotEmpty) {
      await ZIM.getInstance()!.updateUserName(name).then((value) {
        ZIMKitLogger.info('updateUserName success: $name');
        currentUser?.baseInfo.userName = name;
      }).catchError((error) {
        ZIMKitLogger.info('updateUserName faild', error);
        throw error;
      });
    }
    if (avatarUrl.isNotEmpty) {
      await ZIM.getInstance()!.updateUserAvatarUrl(avatarUrl).then((value) {
        ZIMKitLogger.info('updateUserAvatarUrl success: $avatarUrl');
        currentUser?.userAvatarUrl = avatarUrl;
      }).catchError((error) {
        ZIMKitLogger.info('updateUserAvatarUrl faild', error);
        throw error;
      });
    }
  }
}

mixin ZIMKitCoreUserData {
  ZIMConnectionState get connectionState =>
      ZegoUIKitSignalingPlugin().eventCenter.connectionState;
}

extension ZIMKitCoreUserEvent on ZIMKitCore {
  Stream<ZegoSignalingPluginConnectionStateChangedEvent>
      getConnectionStateChangedEventStream() {
    return ZegoUIKitSignalingPlugin().getConnectionStateChangedEventStream();
  }

  Stream<ZegoSignalingPluginTokenWillExpireEvent>
      getTokenWillExpireEventStream() {
    return ZegoUIKitSignalingPlugin().getTokenWillExpireEventStream();
  }
}
