part of '../usecases.dart';

class CreateEmployerSpotlightsUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerSpotlightsRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerSpotlightsUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerSpotlightsRequestParams? params}) {
    return _employerRepository.employerSpotlights(params!);
  }
}
