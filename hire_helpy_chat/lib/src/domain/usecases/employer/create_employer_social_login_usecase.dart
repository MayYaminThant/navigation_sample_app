part of '../usecases.dart';

class CreateEmployerSocialLoginUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerSocialLoginRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerSocialLoginUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerSocialLoginRequestParams? params}) {
    return _employerRepository.employerSocialLogin(params!);
  }
}
