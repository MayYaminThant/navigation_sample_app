part of '../usecases.dart';

class UpdateCandidateSkillQualificationUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateUpdateSkillAndQualificationRequestParams> {
  final CandidateRepository _candidateRepository;
  UpdateCandidateSkillQualificationUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateUpdateSkillAndQualificationRequestParams? params}) {
    return _candidateRepository.updateCandidateSkillAndQualification(params!);
  }
}
