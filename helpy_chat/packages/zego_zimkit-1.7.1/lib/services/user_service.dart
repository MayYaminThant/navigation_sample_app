part of 'services.dart';

mixin ZIMKitUserService {
  // TODO AvatarUrl
  Future<int> connectUser({
    required String id,
    String name = '',
    String avatarUrl = '',
  }) async {
    return ZIMKitCore.instance
        .connectUser(id: id, name: name, avatarUrl: avatarUrl);
  }

  Future<void> disconnectUser() async {
    return ZIMKitCore.instance.disconnectUser();
  }

  // kituser
  ZIMUserFullInfo? currentUser() {
    return ZIMKitCore.instance.currentUser;
  }

  Future<ZIMUserFullInfo> queryUser(String id) async {
    return ZIMKitCore.instance.queryUser(id);
  }

  Future<void> updateUserInfo({String name = '', String avatarUrl = ''}) async {
    return ZIMKitCore.instance.updateUserInfo(name: name, avatarUrl: avatarUrl);
  }

  Stream<ZegoSignalingPluginConnectionStateChangedEvent>
      getConnectionStateChangedEventStream() {
    return ZIMKitCore.instance.getConnectionStateChangedEventStream();
  }
}
