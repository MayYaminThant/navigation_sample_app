part of '../usecases.dart';

class CreateCandidateEmploymentUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateCreateEmploymentRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateEmploymentUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateCreateEmploymentRequestParams? params}) {
    return _candidateRepository.createCandidateEmployment(params!);
  }
}
