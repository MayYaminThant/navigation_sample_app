part of '../usecases.dart';

class GetCandidateCoinHistoryUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateListCoinHistoryRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateCoinHistoryUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateListCoinHistoryRequestParams? params}) {
    return _candidateRepository.candidateCoinListHistory(params!);
  }
}
