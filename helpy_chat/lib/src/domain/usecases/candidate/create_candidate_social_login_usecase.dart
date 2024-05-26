part of '../usecases.dart';

class CreateCandidateSocialLoginUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateSocialLoginRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateSocialLoginUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateSocialLoginRequestParams? params}) {
    return _candidateRepository.candidateSocialLogin(params!);
  }
}
