part of '../usecases.dart';

class CreateEmployerContactUsUseCase 
    implements UseCase<DataState<DataResponseModel>, EmployerContactUsRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerContactUsUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerContactUsRequestParams? params}) {
    return _employerRepository.employerContactUs(params!);
  }
}
