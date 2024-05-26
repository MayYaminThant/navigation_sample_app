part of '../usecases.dart';

class UpdateCandidateAvailabilityUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateUpdateAvailabilityStatusRequestParams> {
  final CandidateRepository _candidateRepository;
  UpdateCandidateAvailabilityUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateUpdateAvailabilityStatusRequestParams? params}) {
    return _candidateRepository.updateCandidateAvailabilityStatus(params!);
  }
}
