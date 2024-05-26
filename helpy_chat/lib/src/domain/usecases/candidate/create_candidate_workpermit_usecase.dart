part of '../usecases.dart';

class CreateCandidateWorkPermitUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateWorkPermitRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateWorkPermitUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateWorkPermitRequestParams? params}) {
    return _candidateRepository.createCandidateWorkPermit(params!);
  }
}
