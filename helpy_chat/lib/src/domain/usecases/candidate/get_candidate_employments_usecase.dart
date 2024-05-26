part of '../usecases.dart';

class GetCandidateEmploymentsUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateEmploymentsUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateRequestParams? params}) {
    return _candidateRepository.candidateProfile(params!);
  }
}
