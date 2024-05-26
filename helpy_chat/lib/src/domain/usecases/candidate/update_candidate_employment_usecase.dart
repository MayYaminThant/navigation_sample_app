part of '../usecases.dart';

class UpdateCandidateEmploymentUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateUpdateEmploymentRequestParams> {
  final CandidateRepository _candidateRepository;
  UpdateCandidateEmploymentUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateUpdateEmploymentRequestParams? params}) {
    return _candidateRepository.updateCandidateEmployment(params!);
  }
}
