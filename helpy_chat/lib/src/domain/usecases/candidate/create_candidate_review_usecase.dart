part of '../usecases.dart';

class CreateCandidateReviewUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateCreateReviewsRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateReviewUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateCreateReviewsRequestParams? params}) {
    return _candidateRepository.createCandidateReview(params!);
  }
}
