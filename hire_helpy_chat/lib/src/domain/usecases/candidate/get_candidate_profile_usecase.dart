part of '../usecases.dart';

class GetCandidateProfileUseCase
    implements
        UseCase<DataState<DataResponseModel>,
            CandidatePublicProfileRequestParams> {
  final CandidateRepository _candidateRepository;
  GetCandidateProfileUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call(
      {CandidatePublicProfileRequestParams? params}) {
    return _candidateRepository.candidatePublicProfile(params!);
  }
}
