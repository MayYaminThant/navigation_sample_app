part of '../usecases.dart';

class UpdateCandidateFCMUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateFCMRequestParams> {
  final CandidateRepository _candidateRepository;
  UpdateCandidateFCMUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateFCMRequestParams? params}) {
    return _candidateRepository.candidateUpdateFCM(params!);
  }
}
