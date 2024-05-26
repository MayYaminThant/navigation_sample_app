part of '../usecases.dart';

class UpdateEmployerAccountUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerUpdateAccountRequestParams> {
  final EmployerRepository _employerRepository;
  UpdateEmployerAccountUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerUpdateAccountRequestParams? params}) {
    return _employerRepository.updateEmployerAccount(params!);
  }
}
