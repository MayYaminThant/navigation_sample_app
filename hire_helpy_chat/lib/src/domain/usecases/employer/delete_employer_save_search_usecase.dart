part of '../usecases.dart';

class DeleteEmployerSaveSearchUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerDeleteSaveSearchRequestParams> {
  final EmployerRepository _employerRepository;
  DeleteEmployerSaveSearchUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerDeleteSaveSearchRequestParams? params}) {
    return _employerRepository.employerDeleteSaveSearch(params!);
  }
}
