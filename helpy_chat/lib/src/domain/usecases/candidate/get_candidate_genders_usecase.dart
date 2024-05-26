part of '../usecases.dart';

class GetCandidateGendersUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateGendersUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateRequestParams? params}) {
    return _candidateRepository.candidateGenders();
  }
}
