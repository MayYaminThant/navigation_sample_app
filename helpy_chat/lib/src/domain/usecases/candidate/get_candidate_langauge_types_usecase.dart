part of '../usecases.dart';

class GetCandidateLanguageTypesUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateLanguageTypesUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateRequestParams? params}) {
    return _candidateRepository.candidateLanguageTypes();
  }
}
