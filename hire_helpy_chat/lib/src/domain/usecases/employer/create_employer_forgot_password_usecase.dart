part of '../usecases.dart';

class CreateEmployerForgotPasswordUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerForgotPasswordRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerForgotPasswordUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerForgotPasswordRequestParams? params}) {
    return _employerRepository.employerForgotPassword(params!);
  }
}
