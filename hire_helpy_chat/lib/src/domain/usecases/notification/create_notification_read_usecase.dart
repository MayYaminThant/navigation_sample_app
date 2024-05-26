part of '../usecases.dart';

class CreateNotificationReadUseCase
    implements UseCase<DataState<DataResponseModel>, NotificationReadRequestParams> {
  final NotificationRepository _notificationRepository;
  CreateNotificationReadUseCase(this._notificationRepository);

  @override
  Future<DataState<DataResponseModel>> call({NotificationReadRequestParams? params}) {
    return _notificationRepository.postCandidateNotificationsRead(params!);
  }
}
