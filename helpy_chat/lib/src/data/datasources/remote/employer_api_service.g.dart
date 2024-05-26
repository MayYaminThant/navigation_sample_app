// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _EmployerApiSerice implements EmployerApiSerice {
  _EmployerApiSerice(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<DataResponseModel>> createEmployerSearch({
    acceptType,
    token,
    country,
    currency,
    expectedSalary,
    startDate,
    endDate,
    skillInfantCare,
    skillSpecialNeedsCare,
    skillElderlyCare,
    skillCooking,
    skillGeneralHousework,
    skillPetCare,
    skillHandicapCare,
    skillBedriddenCare,
    restDayChoice,
    workRestDays,
    showOnlyEntriesWithPics,
    saveMySearch,
    religion,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'country': country,
      'currency': currency,
      'expected_salary': expectedSalary,
      'start_date': startDate,
      'end_date': endDate,
      'skill_infant_care': skillInfantCare,
      'skill_special_needs_care': skillSpecialNeedsCare,
      'skill_elderly_care': skillElderlyCare,
      'skill_cooking': skillCooking,
      'skill_general_housework': skillGeneralHousework,
      'skill_pet_care': skillPetCare,
      'skill_handicap_care': skillHandicapCare,
      'skill_bedridden_care': skillBedriddenCare,
      'rest_day_per_month_choice': restDayChoice,
      'work_on_rest_day': workRestDays,
      'show_only_entries_with_pics': showOnlyEntriesWithPics,
      'save_my_search': saveMySearch,
      'employer_religion': religion,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/candidate',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> getPublicEmployerProfile({
    acceptType,
    employerId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Accept': acceptType};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/employer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
