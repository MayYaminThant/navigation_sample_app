part of '../usecases.dart';

class GetCandidateReviewUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateReviewsRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateReviewUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateReviewsRequestParams? params}) {
    return _candidateRepository.getCandidateReviews(params!);
  }
}
