part of '../usecases.dart';

class CreateEmployerAboutUseCase
    implements
        UseCase<DataState<DataResponseModel>,
            EmployerCreateAboutRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerAboutUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call(
      {EmployerCreateAboutRequestParams? params}) {
    return _employerRepository.createEmployerAbout(params!);
  }
}
