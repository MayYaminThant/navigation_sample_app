part of '../usecases.dart';

class CreateEmployerExchangeUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerExchangeRateRequestParams> {
  final EmployerRepository _candidateRepository;
  CreateEmployerExchangeUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerExchangeRateRequestParams? params}) {
    return _candidateRepository.employerExchangeRate(params!);
  }
}
