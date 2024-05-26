part of '../usecases.dart';

class UpdateEmployerSaveSearchUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerUpdateSaveSearchRequestParams> {
  final EmployerRepository _employerRepository;
  UpdateEmployerSaveSearchUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerUpdateSaveSearchRequestParams? params}) {
    return _employerRepository.employerUpdateSaveSearch(params!);
  }
}
