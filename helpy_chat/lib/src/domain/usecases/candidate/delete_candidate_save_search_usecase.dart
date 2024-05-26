part of '../usecases.dart';

class DeleteCandidateSaveSearchUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateDeleteSaveSearchRequestParams> {
  final CandidateRepository _candidateRepository;
  DeleteCandidateSaveSearchUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateDeleteSaveSearchRequestParams? params}) {
    return _candidateRepository.candidateDeleteSaveSearch(params!);
  }
}
