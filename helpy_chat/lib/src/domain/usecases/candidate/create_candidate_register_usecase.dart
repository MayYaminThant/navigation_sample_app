part of '../usecases.dart';

class CreateCandidateRegisterUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateRegisterRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateRegisterUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateRegisterRequestParams? params}) {
    return _candidateRepository.candidateRegister(params!);
  }
}
