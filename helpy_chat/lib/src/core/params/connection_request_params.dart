part of 'params.dart';

//Create Send Request
class ConnectionSendRequestParams {
  final String? token;
  final int? senderUserId;
  final int? receiverUserId;
  final String? appSiloName;

  ConnectionSendRequestParams(
      {this.token,
      this.senderUserId,
      this.receiverUserId,
      this.appSiloName
      });
}

//Get My Requests
class ConnectionGetMyRequestParams{
  final String? token;
  final int? userId;

  ConnectionGetMyRequestParams(
      {this.token,
      this.userId,
      });
}

//Get Incoming Requests
class ConnectionIncomingRequestParams{
  final String? token;
  final int? userId;

  ConnectionIncomingRequestParams(
      {this.token,
      this.userId,
      });
}

//Connection Accept Requests
class ConnectionAcceptRequestParams{
  final String? token;
  final int? chatRequestId;

  ConnectionAcceptRequestParams(
      {this.token,
      this.chatRequestId,
      });
}

//Connection Reject Requests
class ConnectionRejectRequestParams{
  final String? token;
  final int? chatRequestId;

  ConnectionRejectRequestParams(
      {this.token,
      this.chatRequestId,
      });
}

//Connection Cancel My Requests
class ConnectionCancelRequestParams{
  final String? token;
  final int? chatRequestId;

  ConnectionCancelRequestParams(
      {this.token,
      this.chatRequestId,
      });
}

//Connections
class ConnectionListRequestParams{
  final String? token;

  ConnectionListRequestParams(
      {this.token,
      });
}

//Unlink Connection
class ConnectionUnlinkRequestParams{
  final String? token;
  final int? connectId;

  ConnectionUnlinkRequestParams(
      {this.token,
      this.connectId,
      });
}