part of blocs;

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class InitializeNotificationEvent extends NotificationEvent {
  @override
  String toString() => "InitializePageEvent";
}

//Request Notifications
class NotificationsRequested extends NotificationEvent {
  final NotificationListRequestParams? params;
  
  const NotificationsRequested({this.params});

  @override
  List<Object> get props => [];
}

class NotificationReadRequested extends NotificationEvent {
  final NotificationReadRequestParams? params;
  const NotificationReadRequested({this.params});

  @override
  List<Object> get props => [];
}

class NotificationUnReadRequested extends NotificationEvent {
  final NotificationReadRequestParams? params;
  const NotificationUnReadRequested({this.params});

  @override
  List<Object> get props => [];
}

class NotificationDeleteRequested extends NotificationEvent {
  final NotificationReadRequestParams? params;
  const NotificationDeleteRequested({this.params});

  @override
  List<Object> get props => [];
}

class NotificationAllDeleteRequested extends NotificationEvent {
  final NotificationAllDeleteRequestParams? params;
  const NotificationAllDeleteRequested({this.params});

  @override
  List<Object> get props => [];
}