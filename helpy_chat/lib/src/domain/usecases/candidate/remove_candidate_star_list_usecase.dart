part of '../usecases.dart';

class RemoveCandidateStarListUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateStarListRemoveRequestParams> {
  final CandidateRepository _candidateRepository;
  RemoveCandidateStarListUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateStarListRemoveRequestParams? params}) {
    return _candidateRepository.candidateStarListRemove(params!);
  }
}
