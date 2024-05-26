part of '../usecases.dart';

class UpdateEmployerLanguageUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerUpdateLanguageParams> {
  final EmployerRepository _employerRepository;
  UpdateEmployerLanguageUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerUpdateLanguageParams? params}) {
    return _employerRepository.updateEmployerLanguage(params!);
  }
}
