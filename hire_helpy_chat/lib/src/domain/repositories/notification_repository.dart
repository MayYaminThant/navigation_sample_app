part of 'repositories.dart';

abstract class NotificationRepository {

  //Notifications
  Future<DataState<DataResponseModel>> getNotifications(NotificationListRequestParams params);

  //Notifications Read
  Future<DataState<DataResponseModel>> postCandidateNotificationsRead(NotificationReadRequestParams params);

  //Notifications UnRead
  Future<DataState<DataResponseModel>> postCandidateNotificationsUnRead(NotificationReadRequestParams params);

  //Notification Delete
  Future<DataState<DataResponseModel>> deleteCandidateNotification(NotificationReadRequestParams params);

  //Notifications All Delete
  Future<DataState<DataResponseModel>> deleteAllCandidateNotification(NotificationAllDeleteRequestParams params);

}
