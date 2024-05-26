part of '../usecases.dart';

class GetEmployerAvailabilityUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerRequestParams> {
  final EmployerRepository _employerRepository;
  GetEmployerAvailabilityUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerRequestParams? params}) {
    return _employerRepository.getEmployerAvailabilityStatus(params!);
  }
}
