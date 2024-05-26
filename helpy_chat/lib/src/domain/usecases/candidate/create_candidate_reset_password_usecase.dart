part of '../usecases.dart';

class CreateCandidateResetPasswordUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateResetPasswordRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateResetPasswordUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateResetPasswordRequestParams? params}) {
    return _candidateRepository.candidateResetPassword(params!);
  }
}
