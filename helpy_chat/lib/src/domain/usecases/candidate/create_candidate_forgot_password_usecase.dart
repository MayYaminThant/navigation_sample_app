part of '../usecases.dart';

class CreateCandidateForgotPasswordUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateForgotPasswordRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateForgotPasswordUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateForgotPasswordRequestParams? params}) {
    return _candidateRepository.candidateForgotPassword(params!);
  }
}
