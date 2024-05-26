part of 'entities.dart';

class NotificationData extends Equatable {
  final String? title;
  final String? message;
  final String? screenName;
  final int? id;

  const NotificationData({this.title, this.message, this.screenName, this.id});

  @override
  List<Object?> get props => [title, message, screenName, id];

  @override
  bool get stringify => true;
}
