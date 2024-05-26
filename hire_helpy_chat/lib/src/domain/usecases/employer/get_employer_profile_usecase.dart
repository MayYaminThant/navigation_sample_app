part of '../usecases.dart';

class GetEmployerProfileUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerRequestParams> {
  final EmployerRepository _employerRepository;
  GetEmployerProfileUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerRequestParams? params}) {
    return _employerRepository.employerProfile(params!);
  }
}
