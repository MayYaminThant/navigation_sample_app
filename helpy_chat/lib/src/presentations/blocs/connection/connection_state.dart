part of blocs;

abstract class ConnectionState extends Equatable {
  const ConnectionState();

  @override
  List<Object> get props => [];
}

class ConnectionInitialState extends ConnectionState {
  @override
  String toString() => "InitializePageState";
}

//Connection Send Request
class ConnectionSendRequestLoading extends ConnectionState {}

class ConnectionSendRequestSuccess extends ConnectionState {
  final DataResponseModel connectionData;

  const ConnectionSendRequestSuccess({required this.connectionData});

  @override
  List<Object> get props => [connectionData];
}

class ConnectionSendRequestFail extends ConnectionState {
  final String message;
  const ConnectionSendRequestFail({required this.message});
}

//Connection My Request
class ConnectionMyRequestLoading extends ConnectionState {}

class ConnectionMyRequestSuccess extends ConnectionState {
  final DataResponseModel connectionData;

  const ConnectionMyRequestSuccess({required this.connectionData});

  @override
  List<Object> get props => [connectionData];
}

class ConnectionMyRequestFail extends ConnectionState {
  final String message;
  const ConnectionMyRequestFail({required this.message});
}

//Connection Incoming Request
class ConnectionIncomingRequestLoading extends ConnectionState {}

class ConnectionIncomingRequestSuccess extends ConnectionState {
  final DataResponseModel connectionData;

  const ConnectionIncomingRequestSuccess({required this.connectionData});

  @override
  List<Object> get props => [connectionData];
}

class ConnectionIncomingRequestFail extends ConnectionState {
  final String message;
  const ConnectionIncomingRequestFail({required this.message});
}

//Connection Accept Request
class ConnectionAcceptRequestLoading extends ConnectionState {}

class ConnectionAcceptRequestSuccess extends ConnectionState {
  final DataResponseModel connectionData;

  const ConnectionAcceptRequestSuccess({required this.connectionData});

  @override
  List<Object> get props => [connectionData];
}

class ConnectionAcceptRequestFail extends ConnectionState {
  final String message;
  const ConnectionAcceptRequestFail({required this.message});
}

//Connection Accept Request
class ConnectionRejectRequestLoading extends ConnectionState {}

class ConnectionRejectRequestSuccess extends ConnectionState {
  final DataResponseModel connectionData;

  const ConnectionRejectRequestSuccess({required this.connectionData});

  @override
  List<Object> get props => [connectionData];
}

class ConnectionRejectRequestFail extends ConnectionState {
  final String message;
  const ConnectionRejectRequestFail({required this.message});
}

//Connection Delete My Request
class ConnectionDeleteMyRequestLoading extends ConnectionState {}

class ConnectionDeleteMyRequestSuccess extends ConnectionState {
  final DataResponseModel connectionData;

  const ConnectionDeleteMyRequestSuccess({required this.connectionData});

  @override
  List<Object> get props => [connectionData];
}

class ConnectionDeleteMyRequestFail extends ConnectionState {
  final String message;
  const ConnectionDeleteMyRequestFail({required this.message});
}

//Connection List
class ConnectionListRequestLoading extends ConnectionState {}

class ConnectionListRequestSuccess extends ConnectionState {
  final DataResponseModel connectionData;

  const ConnectionListRequestSuccess({required this.connectionData});

  @override
  List<Object> get props => [connectionData];
}

class ConnectionListRequestFail extends ConnectionState {
  final String message;
  const ConnectionListRequestFail({required this.message});
}

//Connection Unlink
class ConnectionUnlinkRequestLoading extends ConnectionState {}

class ConnectionUnlinkRequestSuccess extends ConnectionState {
  final DataResponseModel connectionData;

  const ConnectionUnlinkRequestSuccess({required this.connectionData});

  @override
  List<Object> get props => [connectionData];
}

class ConnectionUnlinkRequestFail extends ConnectionState {
  final String message;
  const ConnectionUnlinkRequestFail({required this.message});
}






