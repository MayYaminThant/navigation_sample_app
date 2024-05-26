part of '../usecases.dart';

class DeleteCandidateAvatarUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateDeleteAvatarRequestParams> {
  final CandidateRepository _candidateRepository;
  DeleteCandidateAvatarUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateDeleteAvatarRequestParams? params}) {
    return _candidateRepository.deleteCandidateAvatar(params!);
  }
}
