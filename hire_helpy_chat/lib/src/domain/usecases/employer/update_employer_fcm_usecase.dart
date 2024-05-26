part of '../usecases.dart';

class UpdateEmployerFCMUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerFCMRequestParams> {
  final EmployerRepository _employerRepository;
  UpdateEmployerFCMUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerFCMRequestParams? params}) {
    return _employerRepository.employerUpdateFCM(params!);
  }
}
