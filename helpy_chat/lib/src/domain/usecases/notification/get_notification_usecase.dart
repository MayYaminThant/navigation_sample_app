part of '../usecases.dart';

class GetNotificationsUseCase
    implements UseCase<DataState<DataResponseModel>, NotificationListRequestParams> {
  final NotificationRepository _notificationRepository;
  GetNotificationsUseCase(this._notificationRepository);

  @override
  Future<DataState<DataResponseModel>> call({NotificationListRequestParams? params}) {
    return _notificationRepository.getNotifications(params!);
  }
}
