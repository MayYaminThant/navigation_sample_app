part of '../usecases.dart';

class GetEmployerLoginOutUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerLogoutRequestParams> {
  final EmployerRepository _employerRepository;
  GetEmployerLoginOutUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerLogoutRequestParams? params}) {
    return _employerRepository.employerLogout(params!);
  }
}
