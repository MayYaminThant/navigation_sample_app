part of '../usecases.dart';

class CreateCandidateContactUsUseCase 
    implements UseCase<DataState<DataResponseModel>, CandidateContactUsRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateContactUsUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateContactUsRequestParams? params}) {
    return _candidateRepository.candidateContactUs(params!);
  }
}
