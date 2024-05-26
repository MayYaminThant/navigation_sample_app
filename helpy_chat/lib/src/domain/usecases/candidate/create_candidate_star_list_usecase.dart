part of '../usecases.dart';

class CreateCandidateStarListUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateStarListAddRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateStarListUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateStarListAddRequestParams? params}) {
    return _candidateRepository.candidateStarListAdd(params!);
  }
}
