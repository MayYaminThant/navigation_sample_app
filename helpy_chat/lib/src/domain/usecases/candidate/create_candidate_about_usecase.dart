part of '../usecases.dart';

class CreateCandidateAboutUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateCreateAboutRequestParams> {
  final CandidateRepository _candidateRepository;
  CreateCandidateAboutUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateCreateAboutRequestParams? params}) {
    return _candidateRepository.createCandidateAbout(params!);
  }
}
