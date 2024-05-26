part of '../usecases.dart';

class CreateCandidateBigDataUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateCreateBigDataRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateBigDataUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateCreateBigDataRequestParams? params}) {
    return _candidateRepository.createCandidateBigData(params!);
  }
}
