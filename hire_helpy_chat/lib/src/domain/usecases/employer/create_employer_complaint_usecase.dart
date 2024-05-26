part of '../usecases.dart';

class CreateEmployerComplaintUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerProfileComplaintRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerComplaintUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerProfileComplaintRequestParams? params}) {
    return _employerRepository.createEmployerComplaint(params!);
  }
}
