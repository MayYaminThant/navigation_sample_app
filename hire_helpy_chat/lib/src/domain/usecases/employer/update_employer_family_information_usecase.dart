part of '../usecases.dart';

class UpdateEmployerFamilyInformationUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerUpdateFamilyStatusRequestParams> {
  final EmployerRepository _EmployerRepository;
  UpdateEmployerFamilyInformationUseCase(this._EmployerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerUpdateFamilyStatusRequestParams? params}) {
    return _EmployerRepository.updateEmployerFamilyInformation(params!);
  }
}
