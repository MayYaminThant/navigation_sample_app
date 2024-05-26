part of '../usecases.dart';

class UpdateCandidateConfigsUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateUpdateConfigsRequestParams> {
  final CandidateRepository _candidateRepository;
  UpdateCandidateConfigsUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateUpdateConfigsRequestParams? params}) {
    return _candidateRepository.updateCandidateConfigs(params!);
  }
}
