part of '../usecases.dart';

class GetEmployerStarListUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerStarListRequestParams> {
  final EmployerRepository _employerRepository;
  GetEmployerStarListUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerStarListRequestParams? params}) {
    return _employerRepository.employerStarList(params!);
  }
}
