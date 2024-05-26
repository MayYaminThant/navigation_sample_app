part of '../usecases.dart';

class UpdateCandidateSaveSearchNotifyUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateNotifySaveSearchRequestParams> {
  final CandidateRepository _candidateRepository;
  UpdateCandidateSaveSearchNotifyUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateNotifySaveSearchRequestParams? params}) {
    return _candidateRepository.updateCandidateSavedSearchNotify(params!);
  }
}
