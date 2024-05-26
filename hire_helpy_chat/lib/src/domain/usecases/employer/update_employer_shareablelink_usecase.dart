part of '../usecases.dart';

class UpdateEmployerShareableLinkUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerUpdateShareableLinkRequestParams> {
  final EmployerRepository _employerRepository;
  UpdateEmployerShareableLinkUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerUpdateShareableLinkRequestParams? params}) {
    return _employerRepository.updateEmployerShareableLink(params!);
  }
}
