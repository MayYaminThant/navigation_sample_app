part of '../usecases.dart';

class GetCandidateReligionsUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateReligionsUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateRequestParams? params}) {
    return _candidateRepository.candidateReligions();
  }
}
