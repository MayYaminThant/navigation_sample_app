part of '../usecases.dart';

class CreateNotificationUnReadUseCase
    implements UseCase<DataState<DataResponseModel>, NotificationReadRequestParams> {
  final NotificationRepository _notificationRepository;
  CreateNotificationUnReadUseCase(this._notificationRepository);

  @override
  Future<DataState<DataResponseModel>> call({NotificationReadRequestParams? params}) {
    return _notificationRepository.postCandidateNotificationsUnRead(params!);
  }
}
