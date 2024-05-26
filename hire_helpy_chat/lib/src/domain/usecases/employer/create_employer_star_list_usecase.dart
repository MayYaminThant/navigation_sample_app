part of '../usecases.dart';

class CreateEmployerStarListUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerStarListAddRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerStarListUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerStarListAddRequestParams? params}) {
    return _employerRepository.employerStarListAdd(params!);
  }
}
