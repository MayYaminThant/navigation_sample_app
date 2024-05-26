part of blocs;

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitialState extends NotificationState {
  @override
  String toString() => "InitializePageState";
}

//Notifications 
class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final DataResponseModel data;

  const NotificationSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class NotificationFail extends NotificationState {
  final String message;
  const NotificationFail({required this.message});
}

//Notification Read
class NotificationReadLoading extends NotificationState {}

class NotificationReadSuccess extends NotificationState {
  final DataResponseModel data;

  const NotificationReadSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class NotificationReadFail extends NotificationState {
  final String message;
  const NotificationReadFail({required this.message});
}

//Notification UnRead
class NotificationUnReadLoading extends NotificationState {}

class NotificationUnReadSuccess extends NotificationState {
  final DataResponseModel data;

  const NotificationUnReadSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class NotificationUnReadFail extends NotificationState {
  final String message;
  const NotificationUnReadFail({required this.message});
}

//Notification Delete
class NotificationDeleteLoading extends NotificationState {}

class NotificationDeleteSuccess extends NotificationState {
  final DataResponseModel data;

  const NotificationDeleteSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class NotificationDeleteFail extends NotificationState {
  final String message;
  const NotificationDeleteFail({required this.message});
}

//Notification All Delete
class NotificationAllDeleteLoading extends NotificationState {}

class NotificationAllDeleteSuccess extends NotificationState {
  final DataResponseModel data;

  const NotificationAllDeleteSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class NotificationAllDeleteFail extends NotificationState {
  final String message;
  const NotificationAllDeleteFail({required this.message});
}