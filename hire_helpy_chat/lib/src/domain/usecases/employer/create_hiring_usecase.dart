part of '../usecases.dart';

class CreateEmployerHiringUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerHiringRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerHiringUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerHiringRequestParams? params}) {
    return _employerRepository.createEmployerHiring(params!);
  }
}
