part of '../usecases.dart';

class CreateCandidateAvatarUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateCreateAvatarRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateAvatarUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateCreateAvatarRequestParams? params}) {
    return _candidateRepository.createCandidateAvatar(params!);
  }
}
