part of '../usecases.dart';

class UpdateEmployerSaveSearchNotifyUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerNotifySaveSearchRequestParams> {
  final EmployerRepository _employerRepository;
  UpdateEmployerSaveSearchNotifyUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerNotifySaveSearchRequestParams? params}) {
    return _employerRepository.updateEmployerSavedSearchNotify(params!);
  }
}
