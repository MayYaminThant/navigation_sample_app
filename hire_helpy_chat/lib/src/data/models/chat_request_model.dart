part of 'models.dart';

class ChatRequestModel extends ChatRequest {
  const ChatRequestModel({
    int? chatRequestId,
    int? senderUserId,
    int? receiverUserId,
    String? creationDatetime,
    String? senderAppSiloName,    
    User? sender,
    User? receiver,
  }) : super(
    chatRequestId: chatRequestId,
    senderUserId: senderUserId,
    receiverUserId: receiverUserId,
    creationDatetime: creationDatetime,
    senderAppSiloName: senderAppSiloName,
    sender: sender,
    receiver: receiver
        );

  factory ChatRequestModel.fromJson(Map<dynamic, dynamic> map) {
    return ChatRequestModel(
      chatRequestId: map['chat_request_id'] != null ? map['chat_request_id'] as int: null,
      senderUserId: map['sender_user_id'] != null ? map['sender_user_id'] as int: null,
      receiverUserId: map['receiver_user_id'] != null ? map['receiver_user_id'] as int: null,
      creationDatetime: map['chat_request_creation_datetime'] != null ? map['chat_request_creation_datetime'] as String: null,
      senderAppSiloName: map['sender_app_silo_name'] != null ? map['sender_app_silo_name'] as String: null,
      sender: map['sender'] != null ? UserModel.fromJson(map['sender']): null,
      receiver: map['receiver'] != null ? UserModel.fromJson(map['receiver']): null,
    );
  }

}
