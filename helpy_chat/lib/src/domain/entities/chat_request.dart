part of 'entities.dart';

class ChatRequest extends Equatable {
  final int? chatRequestId;
  final int? senderUserId;
  final int? receiverUserId;
  final String? creationDatetime;
  final String? senderAppSiloName;
  final User? sender;
  final User? receiver;

  const ChatRequest({this.chatRequestId, this.senderUserId, this.receiverUserId, this.creationDatetime, this.senderAppSiloName, this.sender, this.receiver});

  @override
  List<Object?> get props => [chatRequestId, senderUserId, receiverUserId, creationDatetime, senderAppSiloName, sender, receiver];

  @override
  bool get stringify => true;
}
