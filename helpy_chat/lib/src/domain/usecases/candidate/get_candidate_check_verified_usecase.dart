part of '../usecases.dart';

class GetCandidateCheckVerifiedUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateCheckVerifiedRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateCheckVerifiedUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateCheckVerifiedRequestParams? params}) {
    return _candidateRepository.getCandidateCheckVerified(params!);
  }
}
