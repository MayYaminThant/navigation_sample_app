part of '../usecases.dart';

class UpdateCandidateShareableLinkUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateUpdateShareableLinkRequestParams> {
  final CandidateRepository _candidateRepository;
  UpdateCandidateShareableLinkUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateUpdateShareableLinkRequestParams? params}) {
    return _candidateRepository.updateCandidateShareableLink(params!);
  }
}
