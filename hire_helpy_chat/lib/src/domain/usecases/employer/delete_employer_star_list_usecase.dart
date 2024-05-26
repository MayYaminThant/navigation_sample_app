part of '../usecases.dart';

class RemoveEmployerStarListUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerStarListRemoveRequestParams> {
  final EmployerRepository _employerRepository;
  RemoveEmployerStarListUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerStarListRemoveRequestParams? params}) {
    return _employerRepository.employerStarListRemove(params!);
  }
}
