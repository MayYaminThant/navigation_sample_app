part of '../usecases.dart';

class UpdateCandidateSaveSearchUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateUpdateSaveSearchRequestParams> {
  final CandidateRepository _candidateRepository;
  UpdateCandidateSaveSearchUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateUpdateSaveSearchRequestParams? params}) {
    return _candidateRepository.candidateUpdateSaveSearch(params!);
  }
}
