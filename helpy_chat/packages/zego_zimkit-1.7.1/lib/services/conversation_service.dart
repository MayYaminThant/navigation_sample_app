part of 'services.dart';

mixin ZIMKitConversationService {
  Future<ZIMKitConversationListNotifier> getConversationListNotifier() {
    return ZIMKitCore.instance.getConversationListNotifier();
  }

  ValueNotifier<ZIMKitConversation> getConversation(
      String id, ZIMConversationType type) {
    return ZIMKitCore.instance.db.conversations.get(id, type);
  }

  ValueNotifier<int> getTotalUnreadMessageCount() {
    return ZIMKitCore.instance.totalUnreadMessageCount;
  }

  Future<void> deleteConversation(
    String id,
    ZIMConversationType type, {
    bool isAlsoDeleteMessages = false,
  }) async {
    await ZIMKitCore.instance.deleteConversation(id, type,
        isAlsoDeleteMessages: isAlsoDeleteMessages);
  }

  Future<void> clearUnreadCount(
      String conversationID, ZIMConversationType conversationType) async {
    ZIMKitCore.instance.clearUnreadCount(conversationID, conversationType);
  }

  Future<int> loadMoreConversation() async {
    return ZIMKitCore.instance.loadMoreConversation();
  }
}
