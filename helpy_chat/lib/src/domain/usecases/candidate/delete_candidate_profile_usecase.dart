part of '../usecases.dart';

class DeleteCandidateProfileUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateDeleteProfileRequestParams> {
  final CandidateRepository _candidateRepository;
  DeleteCandidateProfileUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateDeleteProfileRequestParams? params}) {
    return _candidateRepository.deleteCandidateProfile(params!);
  }
}
