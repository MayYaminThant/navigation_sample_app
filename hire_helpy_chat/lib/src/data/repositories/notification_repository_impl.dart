part of 'repositories_impl.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationApiService _notificationApiService;

  const NotificationRepositoryImpl(this._notificationApiService);
  
  //getNotifications
  @override
  Future<DataState<DataResponseModel>> getNotifications(NotificationListRequestParams params) async {
    try {
      final httpResponse = await _notificationApiService.getEmployerNotifications(
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
  Future<DataState<DataResponseModel>> postCandidateNotificationsRead(NotificationReadRequestParams params) async {
   try {
      final httpResponse = await _notificationApiService.postEmployerNotificationsRead(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        notificationId: params.notificationId,
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
  Future<DataState<DataResponseModel>> deleteAllCandidateNotification(NotificationAllDeleteRequestParams params) async{
    try {
      final httpResponse = await _notificationApiService.deleteAllEmployerNotification(
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
  Future<DataState<DataResponseModel>> deleteCandidateNotification(NotificationReadRequestParams params) async{
    try {
      final httpResponse = await _notificationApiService.deleteEmployerNotification(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        notificationId: params.notificationId,
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
  Future<DataState<DataResponseModel>> postCandidateNotificationsUnRead(NotificationReadRequestParams params) async{
    try {
      final httpResponse = await _notificationApiService.postEmployerNotificationsUnRead(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        notificationId: params.notificationId,
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
}
