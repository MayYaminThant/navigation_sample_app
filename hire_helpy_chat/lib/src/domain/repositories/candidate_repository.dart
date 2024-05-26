part of 'repositories.dart';

abstract class CandidateRepository {
  //Candidate Search Create
  Future<DataState<DataResponseModel>> candidateSearch(
      CandidateSearchCreateRequestParams params);

  //Candidate Public Profile
  Future<DataState<DataResponseModel>> candidatePublicProfile(
      CandidatePublicProfileRequestParams params);
}
