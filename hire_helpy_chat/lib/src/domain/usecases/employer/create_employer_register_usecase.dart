part of '../usecases.dart';

class CreateEmployerRegisterUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerRegisterRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerRegisterUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerRegisterRequestParams? params}) {
    return _employerRepository.employerRegister(params!);
  }
}
