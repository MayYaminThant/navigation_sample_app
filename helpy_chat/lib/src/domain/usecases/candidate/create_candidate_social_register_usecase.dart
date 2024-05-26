part of '../usecases.dart';

class CreateCandidateSocialRegisterUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateSocialRegisterRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateSocialRegisterUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateSocialRegisterRequestParams? params}) {
    return _candidateRepository.candidateSocialRegister(params!);
  }
}
