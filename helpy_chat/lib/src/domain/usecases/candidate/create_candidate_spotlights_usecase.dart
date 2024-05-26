part of '../usecases.dart';

class CreateCandidateSpotlightsUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateSpotlightsRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateSpotlightsUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateSpotlightsRequestParams? params}) {
    return _candidateRepository.candidateSpotlights(params!);
  }
}
