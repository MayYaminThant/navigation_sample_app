part of '../usecases.dart';

class CreateCandidateComplaintUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateProfileComplaintRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateComplaintUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateProfileComplaintRequestParams? params}) {
    return _candidateRepository.createCandidateComplaint(params!);
  }
}
