part of '../usecases.dart';

class GetEmployerCheckVerifiedUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerCheckVerifiedRequestParams> {
  final EmployerRepository _employerRepository;
  GetEmployerCheckVerifiedUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerCheckVerifiedRequestParams? params}) {
    return _employerRepository.getEmployerCheckVerified(params!);
  }
}
