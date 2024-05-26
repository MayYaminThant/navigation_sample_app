part of '../usecases.dart';

class CreateCandidateWorkingPreferenceUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateUpdateWorkingPreferenceRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateWorkingPreferenceUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateUpdateWorkingPreferenceRequestParams? params}) {
    return _candidateRepository.candidateUpdateWorkingPreferences(params!);
  }
}
