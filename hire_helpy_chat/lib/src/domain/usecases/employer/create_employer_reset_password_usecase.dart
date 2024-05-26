part of '../usecases.dart';

class CreateEmployerResetPasswordUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerResetPasswordRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerResetPasswordUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerResetPasswordRequestParams? params}) {
    return _employerRepository.employerResetPassword(params!);
  }
}
