part of '../usecases.dart';

class GetCandidateAvailabilityUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateAvailabilityUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateRequestParams? params}) {
    return _candidateRepository.getCandidateAvailabilityStatus(params!);
  }
}
