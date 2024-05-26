part of '../usecases.dart';

class GetCandidateSaveSearchUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateSaveSearchRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateSaveSearchUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateSaveSearchRequestParams? params}) {
    return _candidateRepository.candidateSaveSearchList(params!);
  }
}
