part of '../usecases.dart';

class GetEmployerConfigsUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerConfigsRequestParams> {
  final EmployerRepository _employerRepository;
  GetEmployerConfigsUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerConfigsRequestParams? params}) {
    return _employerRepository.employerConfigs(params!);
  }
}
