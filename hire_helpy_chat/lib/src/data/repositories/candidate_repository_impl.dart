part of 'repositories_impl.dart';

class CandidateRepositoryImpl implements CandidateRepository {
  final CandidateApiService _candidateApiSerice;

  const CandidateRepositoryImpl(this._candidateApiSerice);

  @override
  Future<DataState<DataResponseModel>> candidateSearch(
      CandidateSearchCreateRequestParams params) async {
    try {
      final HttpResponse<DataResponseModel> httpResponse;
      httpResponse = await _candidateApiSerice.createCandidateSearch(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        country: params.country,
        currency: params.currency,
        offeredSalary: params.offeredSalary,
        candidateNationality: params.candidateNationality,
        startDate: params.startDate,
        endDate: params.endDate,
        skillInfantCare: params.skillInfantCare,
        skillSpecialNeedsCare: params.skillSpecialNeedsCare,
        skillElderlyCare: params.skillElderlyCare,
        skillCooking: params.skillCooking,
        skillGeneralHousework: params.skillGeneralHousework,
        skillPetCare: params.skillPetCare,
        skillBedriddenCare: params.skillBedriddenCare,
        skillHandicapCare: params.skillHandicapCare,
        religion: params.religion,
        ageMin: params.ageMin,
        ageMax: params.ageMax,
        restDaysPerMonthChoice: params.restDaysPerMonthChoice,
        workRestDays: params.workRestDays != null
            ? params.workRestDays!
                ? 1
                : 0
            : null,
        showOnlyEntriesWithPics: params.showOnlyEntriesWithPics != null
            ? params.showOnlyEntriesWithPics!
                ? 1
                : 0
            : null,
        saveMySearch: params.saveMySearch != null
            ? params.saveMySearch!
                ? 1
                : 0
            : null,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> candidatePublicProfile(
      CandidatePublicProfileRequestParams params) async {
    try {
      final httpResponse = await _candidateApiSerice.getPublicCandidateProfile(
          acceptType: 'application/json', userId: params.candidateId);

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
