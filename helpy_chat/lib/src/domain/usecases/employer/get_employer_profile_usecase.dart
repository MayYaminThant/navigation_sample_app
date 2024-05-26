part of '../usecases.dart';

class GetEmployerProfileUseCase
    implements
        UseCase<DataState<DataResponseModel>,
            EmployerPublicProfileRequestParams> {
  final EmployerRepository _employerRepository;
  GetEmployerProfileUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call(
      {EmployerPublicProfileRequestParams? params}) {
    return _employerRepository.employerPublicProfile(params!);
  }
}
