part of 'models.dart';

class NotificationModel extends Notification {
  const NotificationModel({
    int? id,
    String? type,
    String? notifiableType,
    int? userId,
    NotificationData? notificationData,
    String? notificationReadDatetime,
    String? notificationCreationDatetime,
    String? notificationUpdateDatetime,
  }) : super(
            id: id,
            type: type,
            notifiableType: notifiableType,
            userId: userId,
            notificationData: notificationData,
            notificationReadDatetime: notificationReadDatetime,
            notificationCreationDatetime: notificationCreationDatetime,
            notificationUpdateDatetime: notificationUpdateDatetime);

  factory NotificationModel.fromJson(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['notification_id'] != null ? int.parse(map['notification_id'].toString()) : null,
      type: map['type'] != null ? map['type'] as String : null,
      notifiableType: map['notifiable_type'] != null
          ? map['notifiable_type'] as String
          : null,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : null,
      notificationData: map['notification_data'] != null
          ? NotificationDataModel.fromJson(map['notification_data'])
          : null,
      notificationReadDatetime: map['notification_read_datetime'] != null
          ? map['notification_read_datetime'] as String
          : null,
      notificationCreationDatetime:
          map['notification_creation_datetime'] != null
              ? map['notification_creation_datetime'] as String
              : null,
      notificationUpdateDatetime: map['notification_update_datetime'] != null
          ? map['notification_update_datetime'] as String
          : null,
    );
  }
}
