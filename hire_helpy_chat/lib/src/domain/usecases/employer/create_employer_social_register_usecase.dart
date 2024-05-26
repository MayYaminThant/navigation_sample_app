part of '../usecases.dart';

class CreateEmployerSocialRegisterUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerSocialRegisterRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerSocialRegisterUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerSocialRegisterRequestParams? params}) {
    return _employerRepository.employerSocialRegister(params!);
  }
}
