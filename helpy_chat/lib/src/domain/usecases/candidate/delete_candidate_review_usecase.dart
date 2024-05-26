part of '../usecases.dart';

class DeleteCandidateReviewUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateDeleteReviewsRequestParams> {
  final CandidateRepository _candidateRepository;
  DeleteCandidateReviewUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateDeleteReviewsRequestParams? params}) {
    return _candidateRepository.deleteCandidateReview(params!);
  }
}
