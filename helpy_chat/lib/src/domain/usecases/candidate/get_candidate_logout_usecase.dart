part of '../usecases.dart';

class GetCandidateLoginOutUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateLogoutRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateLoginOutUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateLogoutRequestParams? params}) {
    return _candidateRepository.candidateLogout(params!);
  }
}
