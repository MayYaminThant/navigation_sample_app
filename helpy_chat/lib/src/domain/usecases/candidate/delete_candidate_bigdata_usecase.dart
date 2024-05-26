part of '../usecases.dart';

class DeleteCandidateBigDataUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateDeleteBigDataRequestParams> {
  final CandidateRepository _candidateRepository;
  DeleteCandidateBigDataUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateDeleteBigDataRequestParams? params}) {
    return _candidateRepository.deleteCandidateBigData(params!);
  }
}
