part of '../usecases.dart';

class DeleteCandidateAccountUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateDeleteAccountRequestParams> {
  final CandidateRepository _candidateRepository;
  DeleteCandidateAccountUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateDeleteAccountRequestParams? params}) {
    return _candidateRepository.deleteCandidateAccount(params!);
  }
}
