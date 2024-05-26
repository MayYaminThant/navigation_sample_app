part of blocs;

class NotificationBloc
    extends BlocWithState<NotificationEvent, NotificationState> {
  // ignore: non_constant_identifier_names
  final GetNotificationsUseCase _getNotificationsUseCase;
  final CreateNotificationReadUseCase _createNotificationReadUseCase;
  final CreateNotificationUnReadUseCase _createNotificationUnReadUseCase;
  final DeleteNotificationUseCase _deleteNotificationUseCase;
  final DeleteAllNotificationUseCase _deleteAllNotificationUseCase;

  NotificationBloc(
    this._getNotificationsUseCase,
    this._createNotificationReadUseCase,
    this._createNotificationUnReadUseCase,
    this._deleteNotificationUseCase,
    this._deleteAllNotificationUseCase
  ) : super(NotificationInitialState());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is InitializeNotificationEvent) {
      yield* _getInitializeNotification(event);
    }

    if (event is NotificationsRequested) yield* _notifications(event);

    if (event is NotificationReadRequested) {
      yield* _notificationRead(event);
    }

    if (event is NotificationUnReadRequested) {
      yield* _notificationUnRead(event);
    }

    if (event is NotificationDeleteRequested) {
      yield* _notificationDelete(event);
    }

    if (event is NotificationAllDeleteRequested) {
      yield* _notificationAllDelete(event);
    }


  }

  Stream<NotificationState> _getInitializeNotification(
      InitializeNotificationEvent event) async* {
    yield* runBlocProcess(() async* {
      yield NotificationInitialState();
    });
  }

  //Get Notifications
  Stream<NotificationState> _notifications(
      NotificationsRequested event) async* {
    yield* runBlocProcess(() async* {
      yield NotificationLoading();
      final dataState =
          await _getNotificationsUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield NotificationSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const NotificationFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield NotificationFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Post Notification Read
  Stream<NotificationState> _notificationRead(
      NotificationReadRequested event) async* {
    yield* runBlocProcess(() async* {
      yield NotificationReadLoading();
      final dataState =
          await _createNotificationReadUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield NotificationReadSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const NotificationReadFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield NotificationFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Post Notification ImRead
  Stream<NotificationState> _notificationUnRead(
      NotificationUnReadRequested event) async* {
    yield* runBlocProcess(() async* {
      yield NotificationReadLoading();
      final dataState =
          await _createNotificationUnReadUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield NotificationUnReadSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const NotificationUnReadFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield NotificationFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Delete Notification 
  Stream<NotificationState> _notificationDelete(
      NotificationDeleteRequested event) async* {
    yield* runBlocProcess(() async* {
      yield NotificationDeleteLoading();
      final dataState =
          await _deleteNotificationUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield NotificationDeleteSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const NotificationDeleteFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield NotificationFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Delete All Notification 
  Stream<NotificationState> _notificationAllDelete(
      NotificationAllDeleteRequested event) async* {
    yield* runBlocProcess(() async* {
      yield NotificationAllDeleteLoading();
      final dataState =
          await _deleteAllNotificationUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield NotificationAllDeleteSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const NotificationAllDeleteFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield NotificationAllDeleteFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }
}
