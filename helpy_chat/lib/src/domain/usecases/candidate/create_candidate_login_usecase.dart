part of '../usecases.dart';

class CreateCandidateLoginUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateLoginRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateLoginUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateLoginRequestParams? params}) {
    return _candidateRepository.candidateLogin(params!);
  }
}
