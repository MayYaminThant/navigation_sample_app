part of 'repositories_impl.dart';

class EmployerRepositoryImpl implements EmployerRepository {
  final EmployerApiSerice _employerApiSerice;

  const EmployerRepositoryImpl(this._employerApiSerice);

  @override
  Future<DataState<DataResponseModel>> employerSearch(
      EmployerSearchCreateRequestParams params) async {
    try {
      final httpResponse = await _employerApiSerice.createEmployerSearch(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          // agentFee: params.agentFee,
          country: params.country,
          currency: params.currency,
          expectedSalary: params.expectedSalary,
          restDayChoice: params.restDayChoice,
          saveMySearch: params.saveMySearch != null
              ? params.saveMySearch!
                  ? 1
                  : 0
              : null,
          showOnlyEntriesWithPics: params.showOnlyEntriesWithPics != null
              ? params.showOnlyEntriesWithPics!
                  ? 1
                  : 0
              : null,
          skillInfantCare: params.skillInfantCare,
          skillSpecialNeedsCare: params.skillSpecialNeedsCare,
          skillElderlyCare: params.skillElderlyCare,
          skillCooking: params.skillCooking,
          skillGeneralHousework: params.skillGeneralHousework,
          skillPetCare: params.skillPetCare,
          skillBedriddenCare: params.skillBedriddenCare,
          skillHandicapCare: params.skillHandicapCare,
          startDate: params.startDate,
          endDate: params.endDate,
          workRestDays: params.workRestDays != null
              ? params.workRestDays!
                  ? 1
                  : 0
              : null,     
          religion: params.religion
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
  Future<DataState<DataResponseModel>> employerPublicProfile(
      EmployerPublicProfileRequestParams params) async {
    try {
      final httpResponse = await _employerApiSerice.getPublicEmployerProfile(
          acceptType: 'application/json', employerId: params.employerId);

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
