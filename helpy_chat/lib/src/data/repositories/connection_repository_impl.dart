part of 'repositories_impl.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  final ConnectionApiService _connectionApiService;

  const ConnectionRepositoryImpl(this._connectionApiService);

  @override
  Future<DataState<DataResponseModel>> createAcceptRequests(
      ConnectionAcceptRequestParams params) async {
    try {
      final httpResponse = await _connectionApiService.createAcceptRequest(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        requestId: params.chatRequestId,
      );

      if (httpResponse.response.statusCode == 201) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> createRejectRequests(
      ConnectionRejectRequestParams params) async {
    try {
      final httpResponse = await _connectionApiService.createRejectRequest(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          requestId: params.chatRequestId);

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> createSendRequest(
      ConnectionSendRequestParams params) async {
    try {
      final httpResponse = await _connectionApiService.createSendequest(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        receiverUserId: params.receiverUserId,
      );

      if (httpResponse.response.statusCode == 201) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> getIncomingRequests(
      ConnectionIncomingRequestParams params) async {
    try {
      final httpResponse = await _connectionApiService.getIncomingsRequests(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> getMyRequests(
      ConnectionGetMyRequestParams params) async {
    try {
      final httpResponse = await _connectionApiService.getMyRequests(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> deleteMyRequests(
      ConnectionCancelRequestParams params) async {
    try {
      final httpResponse = await _connectionApiService.deleteMyRequest(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        chatRequestId: params.chatRequestId,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  //Connection List
  @override
  Future<DataState<DataResponseModel>> connectionList(
      ConnectionListRequestParams params) async {
    try {
      final httpResponse = await _connectionApiService.getConnections(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  //Connection Unlink
  @override
  Future<DataState<DataResponseModel>> connectionUnlink(
      ConnectionUnlinkRequestParams params) async {
    try {
      final httpResponse = await _connectionApiService.unlinkConnection(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          chatConnectId: params.connectId);

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
