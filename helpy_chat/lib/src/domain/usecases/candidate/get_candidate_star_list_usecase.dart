part of '../usecases.dart';

class GetCandidateStarListUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateStarListRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateStarListUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateStarListRequestParams? params}) {
    return _candidateRepository.candidateStarList(params!);
  }
}
