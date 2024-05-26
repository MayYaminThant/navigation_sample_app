part of 'params.dart';

class NotificationListRequestParams {
  final String? token;
  final String? perPage;

  NotificationListRequestParams({
    this.token,
    this.perPage,
  });
}

class NotificationReadRequestParams {
  final String? token;
  final int? notificationId;

  NotificationReadRequestParams({
    this.token,
    this.notificationId,
  });
}

class NotificationAllDeleteRequestParams {
  final String? token;

  NotificationAllDeleteRequestParams({
    this.token,
  });
}

