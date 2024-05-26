part of '../usecases.dart';

class UpdateCandidateAccountUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateUpdateAccountRequestParams> {
  final CandidateRepository _candidateRepository;
  UpdateCandidateAccountUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateUpdateAccountRequestParams? params}) {
    return _candidateRepository.updateCandidateAccount(params!);
  }
}
