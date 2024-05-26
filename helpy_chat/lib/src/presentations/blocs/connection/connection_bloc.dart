part of blocs;

class ConnectionBloc extends BlocWithState<ConnectionEvent, ConnectionState> {
  // ignore: non_constant_identifier_names
  final CreateSendConnectionUseCase _createSendConnectionUseCase;
  final GetMyConnectionRequestUseCase _getMyConnectionRequestUseCase;
  final GetIncomingConnectionRequestUseCase
      _getIncomingConnectionRequestUseCase;
  final CreateAcceptConnectionUseCase _createAcceptConnectionUseCase;
  final CreateRejectConnectionUseCase _createRejectConnectionUseCase;
  final DeleteMyConnectionRequestUseCase _deleteMyConnectionRequestUseCase;
  final GetConnectionListUseCase _getConnectionListUseCase;
  final DeleteConnectionLinkUseCase _deleteConnectionLinkUseCase;

  ConnectionBloc(
      this._createSendConnectionUseCase,
      this._getMyConnectionRequestUseCase,
      this._getIncomingConnectionRequestUseCase,
      this._createAcceptConnectionUseCase,
      this._createRejectConnectionUseCase,
      this._deleteMyConnectionRequestUseCase,
      this._getConnectionListUseCase,
      this._deleteConnectionLinkUseCase)
      : super(ConnectionInitialState());

  @override
  Stream<ConnectionState> mapEventToState(ConnectionEvent event) async* {
    if (event is InitializeConnectionEvent) {
      yield* _getInitializeConnection(event);
    }

    if (event is ConnectionSendRequested) {
      yield* _createConnectionSendRequest(event);
    }

    if (event is ConnectionGetMyRequested) {
      yield* _getMyConnectionRequest(event);
    }

    if (event is ConnectionGetIncomingRequested) {
      yield* _getIncomingConnectionRequest(event);
    }

    if (event is ConnectionCreateAcceptRequested) {
      yield* _connectionAcceptRequest(event);
    }

    if (event is ConnectionCreateRejectRequested) {
      yield* _connectionRejectRequest(event);
    }

    if (event is ConnectionDeleteMyRequested) {
      yield* _connectionDeleteMyRequest(event);
    }

    if (event is ConnectionListRequested) {
      yield* _connectionList(event);
    }

    if (event is ConnectionUnlinkRequested) {
      yield* _connectionUnlink(event);
    }
  }

  Stream<ConnectionState> _getInitializeConnection(
      InitializeConnectionEvent event) async* {
    yield* runBlocProcess(() async* {
      yield ConnectionInitialState();
    });
  }

  //Connection Send Request
  Stream<ConnectionState> _createConnectionSendRequest(
      ConnectionSendRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ConnectionSendRequestLoading();
      final dataState = await _createSendConnectionUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ConnectionSendRequestSuccess(connectionData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ConnectionSendRequestFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ConnectionSendRequestFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Connection My Request
  Stream<ConnectionState> _getMyConnectionRequest(
      ConnectionGetMyRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ConnectionMyRequestLoading();
      final dataState = await _getMyConnectionRequestUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ConnectionMyRequestSuccess(connectionData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ConnectionMyRequestFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ConnectionMyRequestFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Connection Incoming Request
  Stream<ConnectionState> _getIncomingConnectionRequest(
      ConnectionGetIncomingRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ConnectionIncomingRequestLoading();
      final dataState = await _getIncomingConnectionRequestUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ConnectionIncomingRequestSuccess(connectionData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ConnectionIncomingRequestFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ConnectionIncomingRequestFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Connection Accept Request
  Stream<ConnectionState> _connectionAcceptRequest(
      ConnectionCreateAcceptRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ConnectionAcceptRequestLoading();
      final dataState = await _createAcceptConnectionUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ConnectionAcceptRequestSuccess(connectionData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ConnectionAcceptRequestFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ConnectionAcceptRequestFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Connection Reject Request
  Stream<ConnectionState> _connectionRejectRequest(
      ConnectionCreateRejectRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ConnectionRejectRequestLoading();
      final dataState = await _createRejectConnectionUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ConnectionRejectRequestSuccess(connectionData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ConnectionRejectRequestFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ConnectionRejectRequestFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Connection Delete My Request
  Stream<ConnectionState> _connectionDeleteMyRequest(
      ConnectionDeleteMyRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ConnectionDeleteMyRequestLoading();
      final dataState = await _deleteMyConnectionRequestUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ConnectionDeleteMyRequestSuccess(connectionData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ConnectionDeleteMyRequestFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ConnectionDeleteMyRequestFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Connection List
  Stream<ConnectionState> _connectionList(
      ConnectionListRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ConnectionListRequestLoading();
      final dataState = await _getConnectionListUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ConnectionListRequestSuccess(connectionData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ConnectionListRequestFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ConnectionListRequestFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Connection Unlink
  Stream<ConnectionState> _connectionUnlink(
      ConnectionUnlinkRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ConnectionUnlinkRequestLoading();
      final dataState = await _deleteConnectionLinkUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ConnectionUnlinkRequestSuccess(connectionData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ConnectionUnlinkRequestFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ConnectionUnlinkRequestFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }
}
