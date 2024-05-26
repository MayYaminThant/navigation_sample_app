part of 'models.dart';

class NotificationDataModel extends NotificationData {
  const NotificationDataModel(
      {String? title, String? message, String? screenName, int? id})
      : super(title: title, message: message, screenName: screenName, id: id);

  factory NotificationDataModel.fromJson(Map<String, dynamic> map) {
    return NotificationDataModel(
      title: map['title'] != null ? map['title'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      screenName: map['data'] != null && map['data']['screen'] != null
          ? map['data']['screen'] as String
          : null,
      id: map['data']['id'] != null
          ? (map['data']['id'] is int
              ? map['data']['id'] as int
              : int.tryParse(map['data']['id']))
          : null,
    );
  }
}
