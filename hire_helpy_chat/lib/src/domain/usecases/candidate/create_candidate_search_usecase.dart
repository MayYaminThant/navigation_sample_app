part of '../usecases.dart';

class CreateCandidateSearchUseCase
    implements
        UseCase<DataState<DataResponseModel>,
            CandidateSearchCreateRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateSearchUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call(
      {CandidateSearchCreateRequestParams? params}) {
    return _candidateRepository.candidateSearch(params!);
  }
}
