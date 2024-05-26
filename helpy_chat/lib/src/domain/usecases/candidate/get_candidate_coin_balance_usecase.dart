part of '../usecases.dart';

class GetCandidateCoinBalanceUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateListCoinBalanceRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateCoinBalanceUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateListCoinBalanceRequestParams? params}) {
    return _candidateRepository.candidateCoinListBalance(params!);
  }
}
