part of '../usecases.dart';

class UpdateEmployerAvailabilityUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerUpdateAvailabilityStatusRequestParams> {
  final EmployerRepository _employerRepository;
  UpdateEmployerAvailabilityUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerUpdateAvailabilityStatusRequestParams? params}) {
    return _employerRepository.updateEmployerAvailabilityStatus(params!);
  }
}
