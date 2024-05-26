part of 'entities.dart';

  /*
    {
            "notification_id": 1,
            "type": "App\\Notifications\\PhluidCoinGainedNotification",
            "notifiable_type": "App\\Models\\User",
            "user_id": 1061,
            "notification_data": {
                "title": "You gained 50 Phluid Coin.",
                "message": "You gained 50 Phluid Coin due to Completing Profile Creation",
                "data": {
                    "click_action": "FLUTTER_NOTIFICATION_CLICK",
                    "sound": "default",
                    "screen": "A40"
                }
            },
            "notification_read_datetime": null,
            "notification_creation_datetime": "2023-08-17T21:49:15.000000Z",
            "notification_update_datetime": null
        }
  */


class Notification extends Equatable {
  final int? id;
  final String? type;
  final String? notifiableType;
  final int? userId;
  final NotificationData? notificationData;
  final String? notificationReadDatetime;
  final String? notificationCreationDatetime;
  final String? notificationUpdateDatetime;

  const Notification({
    this.id,
    this.type,
    this.notifiableType,
    this.userId,
    this.notificationData,
    this.notificationReadDatetime,
    this.notificationCreationDatetime,
    this.notificationUpdateDatetime,
  });

  @override
  List<Object?> get props => [id, type, notifiableType, userId, notificationData, notificationReadDatetime, notificationUpdateDatetime];

  @override
  bool get stringify => true;
}
