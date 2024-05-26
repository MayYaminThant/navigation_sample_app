part of blocs;

abstract class ConnectionEvent extends Equatable {
  const ConnectionEvent();

  @override
  List<Object> get props => [];
}

class InitializeConnectionEvent extends ConnectionEvent {
  @override
  String toString() => "InitializePageEvent";
}

//Connection Send Request
class ConnectionSendRequested extends ConnectionEvent {
  final ConnectionSendRequestParams? params;

  const ConnectionSendRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Connection My Request
class ConnectionGetMyRequested extends ConnectionEvent {
  final ConnectionGetMyRequestParams? params;

  const ConnectionGetMyRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Connection Incoming Request
class ConnectionGetIncomingRequested extends ConnectionEvent {
  final ConnectionIncomingRequestParams? params;

  const ConnectionGetIncomingRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}


//Connection Accept Request
class ConnectionCreateAcceptRequested extends ConnectionEvent {
  final ConnectionAcceptRequestParams? params;

  const ConnectionCreateAcceptRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Connection Reject Request
class ConnectionCreateRejectRequested extends ConnectionEvent {
  final ConnectionRejectRequestParams? params;

  const ConnectionCreateRejectRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Connection Delete My Request
class ConnectionDeleteMyRequested extends ConnectionEvent {
  final ConnectionCancelRequestParams? params;

  const ConnectionDeleteMyRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}


//Connection List
class ConnectionListRequested extends ConnectionEvent {
  final ConnectionListRequestParams? params;

  const ConnectionListRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Connection Unlink
class ConnectionUnlinkRequested extends ConnectionEvent {
  final ConnectionUnlinkRequestParams? params;

  const ConnectionUnlinkRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}
