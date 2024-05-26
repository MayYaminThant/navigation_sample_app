part of '../usecases.dart';

class CreateEmployerLoginUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerLoginRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerLoginUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerLoginRequestParams? params}) {
    return _employerRepository.employerLogin(params!);
  }
}
