part of '../usecases.dart';

class DeleteEmployerAccountUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerDeleteAccountRequestParams> {
  final EmployerRepository _employerRepository;
  DeleteEmployerAccountUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerDeleteAccountRequestParams? params}) {
    return _employerRepository.deleteEmployerAccount(params!);
  }
}
