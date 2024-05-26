part of '../usecases.dart';

class DeleteCandidateEmploymentUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateDeleteEmploymentRequestParams> {
  final CandidateRepository _candidateRepository;
  DeleteCandidateEmploymentUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateDeleteEmploymentRequestParams? params}) {
    return _candidateRepository.deleteCandidateEmployment(params!);
  }
}
