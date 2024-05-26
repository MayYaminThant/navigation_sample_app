part of '../usecases.dart';

class UpdateCandidateFamilyInformationUseCase
    implements UseCase<DataState<DataResponseModel>, CandidateUpdateFamilyStatusRequestParams> {
  final CandidateRepository _candidateRepository;
  UpdateCandidateFamilyInformationUseCase(this._candidateRepository);

  @override
  Future<DataState<DataResponseModel>> call({CandidateUpdateFamilyStatusRequestParams? params}) {
    return _candidateRepository.updateCandidateFamilyInformation(params!);
  }
}
