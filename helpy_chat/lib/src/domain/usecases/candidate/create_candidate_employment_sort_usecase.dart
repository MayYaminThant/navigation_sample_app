part of '../usecases.dart';

class CreateCandidateEmploymentSortUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateCreateEmploymentSortRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateEmploymentSortUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateCreateEmploymentSortRequestParams? params}) {
    return _candidateRepository.createCandidateEmploymentSort(params!);
  }
}
