part of '../usecases.dart';

class DeleteAllNotificationUseCase
    implements UseCase<DataState<DataResponseModel>, NotificationAllDeleteRequestParams> {
  final NotificationRepository _notificationRepository;
  DeleteAllNotificationUseCase(this._notificationRepository);

  @override
  Future<DataState<DataResponseModel>> call({NotificationAllDeleteRequestParams? params}) {
    return _notificationRepository.deleteAllCandidateNotification(params!);
  }
}
