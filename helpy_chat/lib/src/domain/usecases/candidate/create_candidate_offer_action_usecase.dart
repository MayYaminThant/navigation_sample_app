part of '../usecases.dart';

class CreateCandidateOfferActionUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateOfferActionRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateOfferActionUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateOfferActionRequestParams? params}) {
    return _candidateRepository.candidateOfferAction(params!);
  }
}
