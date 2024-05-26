part of '../usecases.dart';

class GetCandidateConfigsUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateConfigsRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateConfigsUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateConfigsRequestParams? params}) {
    return _candidateRepository.candidateConfigs(params!);
  }
}
