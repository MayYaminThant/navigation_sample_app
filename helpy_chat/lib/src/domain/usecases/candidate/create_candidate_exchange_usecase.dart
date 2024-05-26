part of '../usecases.dart';

class CreateCandidateExchangeUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateExchangeRateRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateExchangeUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateExchangeRateRequestParams? params}) {
    return _candidateRepository.candidateExchangeRate(params!);
  }
}
