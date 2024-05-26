part of '../usecases.dart';

class CreateEmployerWorkingPreferenceUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerUpdateWorkingPreferenceRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerWorkingPreferenceUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerUpdateWorkingPreferenceRequestParams? params}) {
    return _employerRepository.employerUpdateWorkingPreferences(params!);
  }
}
