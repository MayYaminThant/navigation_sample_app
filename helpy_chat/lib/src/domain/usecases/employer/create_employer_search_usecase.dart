part of '../usecases.dart';

class CreateEmployerSearchUseCase
    implements
        UseCase<DataState<DataResponseModel>,
            EmployerSearchCreateRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerSearchUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call(
      {EmployerSearchCreateRequestParams? params}) {
    return _employerRepository.employerSearch(params!);
  }
}
