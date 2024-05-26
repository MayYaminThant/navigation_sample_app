part of '../usecases.dart';

class GetEmployerSaveSearchUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerSaveSearchRequestParams> {
  final EmployerRepository _employerRepository;
  GetEmployerSaveSearchUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerSaveSearchRequestParams? params}) {
    return _employerRepository.employerSaveSearchList(params!);
  }
}
