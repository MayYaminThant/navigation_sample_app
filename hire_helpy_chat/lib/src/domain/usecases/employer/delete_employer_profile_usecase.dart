part of '../usecases.dart';

class DeleteEmployerProfileUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerDeleteProfileRequestParams> {
  final EmployerRepository _employerRepository;
  DeleteEmployerProfileUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerDeleteProfileRequestParams? params}) {
    return _employerRepository.deleteEmployerProfile(params!);
  }
}
