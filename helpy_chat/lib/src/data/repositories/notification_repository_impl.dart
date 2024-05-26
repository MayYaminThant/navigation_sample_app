part of 'repositories_impl.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationApiService _notificationApiService;

  const NotificationRepositoryImpl(this._notificationApiService);

  //getNotifications
  @override
  Future<DataState<DataResponseModel>> getNotifications(
      NotificationListRequestParams params) async {
    try {
      final httpResponse =
          await _notificationApiService.getCandidateNotifications(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        perPage: params.perPage,
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
  Future<DataState<DataResponseModel>> postCandidateNotificationsRead(
      NotificationReadRequestParams params) async {
    try {
      final httpResponse =
          await _notificationApiService.postCandidateNotificationsRead(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        notificationId: params.notificationId,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      // ignore: deprecated_member_use
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          // ignore: deprecated_member_use
          type: DioErrorType.response));
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
  
  @override
  Future<DataState<DataResponseModel>> deleteAllCandidateNotification(NotificationAllDeleteRequestParams params) async{
    try {
      final httpResponse =
          await _notificationApiService.deleteAllCandidateNotification(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      // ignore: deprecated_member_use
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          // ignore: deprecated_member_use
          type: DioErrorType.response));
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
  
  @override
  Future<DataState<DataResponseModel>> deleteCandidateNotification(NotificationReadRequestParams params) async{
    try {
      final httpResponse =
          await _notificationApiService.deleteCandidateNotification(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        notificationId: params.notificationId,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      // ignore: deprecated_member_use
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          // ignore: deprecated_member_use
          type: DioErrorType.response));
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
  
  @override
  Future<DataState<DataResponseModel>> postCandidateNotificationsUnRead(NotificationReadRequestParams params) async{
    try {
      final httpResponse =
          await _notificationApiService.postCandidateNotificationsUnRead(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        notificationId: params.notificationId,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      // ignore: deprecated_member_use
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          // ignore: deprecated_member_use
          type: DioErrorType.response));
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
