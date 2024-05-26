part of '../usecases.dart';

class GetCandidateReferFriendUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateReferFriendRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateReferFriendUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateReferFriendRequestParams? params}) {
    return _candidateRepository.candidateReferFriendList(params!);
  }
}
