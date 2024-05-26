part of '../usecases.dart';

class CreateEmployerVerificationUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerUpdateVerificationRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerVerificationUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerUpdateVerificationRequestParams? params}) {
    return _employerRepository.updateVerification(params!);
  }
}
