part of '../usecases.dart';

class DeleteNotificationUseCase
    implements UseCase<DataState<DataResponseModel>, NotificationReadRequestParams> {
  final NotificationRepository _notificationRepository;
  DeleteNotificationUseCase(this._notificationRepository);

  @override
  Future<DataState<DataResponseModel>> call({NotificationReadRequestParams? params}) {
    return _notificationRepository.deleteCandidateNotification(params!);
  }
}
