part of '../usecases.dart';

class CreateCandidateVerificationUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateUpdateVerificationRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateVerificationUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateUpdateVerificationRequestParams? params}) {
    return _candidateRepository.updateVerification(params!);
  }
}
