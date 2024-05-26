part of '../usecases.dart';

class UpdateEmployerConfigsUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerUpdateConfigsRequestParams> {
  final EmployerRepository _employerRepository;
  UpdateEmployerConfigsUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerUpdateConfigsRequestParams? params}) {
    return _employerRepository.updateEmployerConfigs(params!);
  }
}
