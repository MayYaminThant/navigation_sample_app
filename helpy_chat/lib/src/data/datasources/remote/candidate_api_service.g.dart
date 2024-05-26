// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _CandidateApiService implements CandidateApiService {
  _CandidateApiService(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<DataResponseModel>> createUserLogin({
    acceptType,
    path,
    countryCallingCode,
    phoneNumber,
    email,
    password,
    fcmToken,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Accept': acceptType};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'country_calling_code': countryCallingCode,
      'phone_number': phoneNumber,
      'email': email,
      'password': password,
      'fcm_token': fcmToken,
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
              '/candidate/login/${path}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> userLogout({
    acceptType,
    token,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/candidate/logout',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createSocialLogin({
    acceptType,
    provider,
    userId,
    fcmToken,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Accept': acceptType};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'provider': provider,
      'user_id': userId,
      'fcm_token': fcmToken,
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
              '/candidate/login/social',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createSocialRegister({
    acceptType,
    firstName,
    lastName,
    email,
    appAlpha2Code,
    provider,
    userId,
    referCode,
    preferredLanguage,
    appLocale,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Accept': acceptType};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'app_alpha2_code': appAlpha2Code,
      'provider': provider,
      'user_id': userId,
      'refer_code': referCode,
      'preferred_language': preferredLanguage,
      'app_locale': appLocale,
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
              '/candidate/social/register',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createUserRegister({
    acceptType,
    firstName,
    lastName,
    email,
    password,
    countryCallingCode,
    phoneNumber,
    verifiedMethod,
    referCode,
    requestId,
    preferredLanguage,
    appLocale,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Accept': acceptType};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'country_calling_code': countryCallingCode,
      'phone_number': phoneNumber,
      'verified_method': verifiedMethod,
      'refer_code': referCode,
      'request_id': requestId,
      'preferred_language': preferredLanguage,
      'app_locale': appLocale,
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
              '/candidate/register',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createCandidateContactUs({
    acceptType,
    defaultToken,
    name,
    email,
    issue,
    message,
    phone,
    loginName,
    countryCallingCode,
    canContactViaPhone,
    images,
    thumbnails,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': defaultToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry(
        'name',
        name,
      ));
    }
    if (email != null) {
      _data.fields.add(MapEntry(
        'email',
        email,
      ));
    }
    if (issue != null) {
      _data.fields.add(MapEntry(
        'issue',
        issue,
      ));
    }
    if (message != null) {
      _data.fields.add(MapEntry(
        'message',
        message,
      ));
    }
    if (phone != null) {
      _data.fields.add(MapEntry(
        'phone_number',
        phone,
      ));
    }
    if (loginName != null) {
      _data.fields.add(MapEntry(
        'login_name',
        loginName,
      ));
    }
    if (countryCallingCode != null) {
      _data.fields.add(MapEntry(
        'country_calling_code',
        countryCallingCode.toString(),
      ));
    }
    if (canContactViaPhone != null) {
      _data.fields.add(MapEntry(
        'can_contact_via_phone',
        canContactViaPhone.toString(),
      ));
    }
    if (images != null) {
      _data.files.addAll(images.map((i) => MapEntry(
          'images[]',
          MultipartFile.fromFileSync(
            i.path,
            filename: i.path.split(Platform.pathSeparator).last,
          ))));
    }
    if (thumbnails != null) {
      _data.files.addAll(thumbnails.map((i) => MapEntry(
          'thumbnails[]',
          MultipartFile.fromFileSync(
            i.path,
            filename: i.path.split(Platform.pathSeparator).last,
          ))));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              '/candidate/contact',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> getCandidateConfigs({
    acceptType,
    token,
    lastTimestamp,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'last_timestamp': lastTimestamp};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
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
              '/candidate/configs',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> getCandidateCountries({
    acceptType,
    token,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
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
              '/candidate/countries',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> getCandidateGenders({
    acceptType,
    token,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
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
              '/candidate/genders',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> getCandidateLanguageTypes({
    acceptType,
    token,
    appSilo,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'app_silo': appSilo};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
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
              '/candidate/language_type',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> getCandidateReligions({
    acceptType,
    token,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
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
              '/candidate/religions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> getCandidateProfile({
    acceptType,
    token,
    userId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
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
              '/candidate/profile/detail',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createCandidateAbout({
    acceptType,
    token,
    selfDesc,
    expectedEmployer,
    firstName,
    lastName,
    email,
    countryCallingCode,
    phoneNumber,
    dateOfBirth,
    height,
    weight,
    religion,
    nationality,
    countryOfResidence,
    gender,
    proficientEnglish,
    chineseMandarin,
    bahasaMelayu,
    tamil,
    hokkien,
    teochew,
    cantonese,
    bahasaIndonesian,
    japanese,
    korean,
    french,
    german,
    arabic,
    othersSpecify,
    media,
    updateProgress,
    isEmailVerified,
    isPhoneVerified,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (selfDesc != null) {
      _data.fields.add(MapEntry(
        'self_desc',
        selfDesc,
      ));
    }
    if (expectedEmployer != null) {
      _data.fields.add(MapEntry(
        'expect_employer',
        expectedEmployer,
      ));
    }
    if (firstName != null) {
      _data.fields.add(MapEntry(
        'first_name',
        firstName,
      ));
    }
    if (lastName != null) {
      _data.fields.add(MapEntry(
        'last_name',
        lastName,
      ));
    }
    if (email != null) {
      _data.fields.add(MapEntry(
        'email',
        email,
      ));
    }
    if (countryCallingCode != null) {
      _data.fields.add(MapEntry(
        'country_calling_code',
        countryCallingCode,
      ));
    }
    if (phoneNumber != null) {
      _data.fields.add(MapEntry(
        'phone_number',
        phoneNumber,
      ));
    }
    if (dateOfBirth != null) {
      _data.fields.add(MapEntry(
        'date_of_birth',
        dateOfBirth,
      ));
    }
    if (height != null) {
      _data.fields.add(MapEntry(
        'height_cm',
        height.toString(),
      ));
    }
    if (weight != null) {
      _data.fields.add(MapEntry(
        'weight_g',
        weight.toString(),
      ));
    }
    if (religion != null) {
      _data.fields.add(MapEntry(
        'religion',
        religion,
      ));
    }
    if (nationality != null) {
      _data.fields.add(MapEntry(
        'nationality',
        nationality,
      ));
    }
    if (countryOfResidence != null) {
      _data.fields.add(MapEntry(
        'country_of_residence',
        countryOfResidence,
      ));
    }
    if (gender != null) {
      _data.fields.add(MapEntry(
        'gender',
        gender,
      ));
    }
    if (proficientEnglish != null) {
      _data.fields.add(MapEntry(
        'languages[language_proficient_english]',
        proficientEnglish.toString(),
      ));
    }
    if (chineseMandarin != null) {
      _data.fields.add(MapEntry(
        'languages[language_chinese_mandarin]',
        chineseMandarin.toString(),
      ));
    }
    if (bahasaMelayu != null) {
      _data.fields.add(MapEntry(
        'languages[language_bahasa_melayu]',
        bahasaMelayu.toString(),
      ));
    }
    if (tamil != null) {
      _data.fields.add(MapEntry(
        'languages[language_tamil]',
        tamil.toString(),
      ));
    }
    if (hokkien != null) {
      _data.fields.add(MapEntry(
        'languages[language_hokkien]',
        hokkien.toString(),
      ));
    }
    if (teochew != null) {
      _data.fields.add(MapEntry(
        'languages[language_teochew]',
        teochew.toString(),
      ));
    }
    if (cantonese != null) {
      _data.fields.add(MapEntry(
        'languages[language_cantonese]',
        cantonese.toString(),
      ));
    }
    if (bahasaIndonesian != null) {
      _data.fields.add(MapEntry(
        'languages[language_bahasa_indonesian]',
        bahasaIndonesian.toString(),
      ));
    }
    if (japanese != null) {
      _data.fields.add(MapEntry(
        'languages[language_japanese]',
        japanese.toString(),
      ));
    }
    if (korean != null) {
      _data.fields.add(MapEntry(
        'languages[language_korean]',
        korean.toString(),
      ));
    }
    if (french != null) {
      _data.fields.add(MapEntry(
        'languages[language_french]',
        french.toString(),
      ));
    }
    if (german != null) {
      _data.fields.add(MapEntry(
        'languages[language_german]',
        german.toString(),
      ));
    }
    if (arabic != null) {
      _data.fields.add(MapEntry(
        'languages[language_arabic]',
        arabic.toString(),
      ));
    }
    if (othersSpecify != null) {
      _data.fields.add(MapEntry(
        'language_others_specify',
        othersSpecify,
      ));
    }
    if (media != null) {
      _data.fields.add(MapEntry(
        'media',
        media,
      ));
    }
    if (updateProgress != null) {
      _data.fields.add(MapEntry(
        'update_progress',
        updateProgress.toString(),
      ));
    }
    if (isEmailVerified != null) {
      _data.fields.add(MapEntry(
        'is_email_verified',
        isEmailVerified.toString(),
      ));
    }
    if (isPhoneVerified != null) {
      _data.fields.add(MapEntry(
        'is_phone_verified',
        isPhoneVerified.toString(),
      ));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/candidate/profile/about',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> singleFileUploadProfile({
    acceptType,
    token,
    portfolio,
    thumbnail,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (portfolio != null) {
      _data.files.add(MapEntry(
        'portfolio',
        MultipartFile.fromFileSync(
          portfolio.path,
          filename: portfolio.path.split(Platform.pathSeparator).last,
        ),
      ));
    }
    if (thumbnail != null) {
      _data.files.add(MapEntry(
        'thumbnail',
        MultipartFile.fromFileSync(
          thumbnail.path,
          filename: thumbnail.path.split(Platform.pathSeparator).last,
        ),
      ));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
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
  Future<HttpResponse<DataResponseModel>> updateCandidateFamilyInformation({
    acceptType,
    token,
    familyStatus,
    numOfSiblings,
    members,
    updateProgress,
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
      'family_status': familyStatus,
      'num_of_siblings': numOfSiblings,
      'members': members,
      'update_progress': updateProgress,
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
  Future<HttpResponse<DataResponseModel>> updateCandidateSkillAndQualification({
    acceptType,
    token,
    highestQualification,
    educationJourneyDesc,
    skillInfantCare,
    skillSpecialNeedsCare,
    skillElderlyCare,
    skillCooking,
    skillGeneralHousework,
    skillPetCare,
    skillHandicapCare,
    skillBedriddenCare,
    skillOthersSpecify,
    workPermitFinNumberHash,
    workPermitIssueCountryName,
    updateProgress,
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
      'highest_qualification': highestQualification,
      'education_journey_desc': educationJourneyDesc,
      'skills[skill_infant_care]': skillInfantCare,
      'skills[skill_special_needs_care]': skillSpecialNeedsCare,
      'skills[skill_elderly_care]': skillElderlyCare,
      'skills[skill_cooking]': skillCooking,
      'skills[skill_general_housework]': skillGeneralHousework,
      'skills[skill_pet_care]': skillPetCare,
      'skills[skill_handicap_care]': skillHandicapCare,
      'skills[skill_bedridden_care]': skillBedriddenCare,
      'skill_others_specify': skillOthersSpecify,
      'work_permit_fin_number_hash': workPermitFinNumberHash,
      'work_permit_issue_country_name': workPermitIssueCountryName,
      'update_progress': updateProgress,
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
  Future<HttpResponse<DataResponseModel>> getCandidateEmployments({
    acceptType,
    token,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
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
              '/candidate/employments',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createCandidateEmployment({
    acceptType,
    token,
    countryName,
    displayOrder,
    startDate,
    endDate,
    workDesc,
    dhRelated,
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
      'work_country_name': countryName,
      'display_order': displayOrder,
      'start_date': startDate,
      'end_date': endDate,
      'work_desc': workDesc,
      'dh_related': dhRelated,
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
  Future<HttpResponse<DataResponseModel>> updateCandidateEmployment({
    acceptType,
    token,
    employmentId,
    userId,
    startDate,
    endDate,
    countryName,
    workDesc,
    dhRelated,
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
      'user_id': userId,
      'start_date': startDate,
      'end_date': endDate,
      'work_country_name': countryName,
      'work_desc': workDesc,
      'dh_related': dhRelated,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'PUT',
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
  Future<HttpResponse<DataResponseModel>> deleteCandidateEmployment({
    acceptType,
    token,
    employmentId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
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
  Future<HttpResponse<DataResponseModel>> getCandidateAvailabilityStatus({
    acceptType,
    token,
    appSilo,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'app_silo': appSilo};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
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
              '/candidate/availability_status',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> updateCandidateAvailabilityStatus({
    acceptType,
    token,
    userId,
    status,
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
      'user_id': userId,
      'status': status,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'PUT',
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
  Future<HttpResponse<DataResponseModel>> getCandidateStarsList({
    acceptType,
    token,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
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
              '/candidate/stars',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> postCandidateStarsList({
    acceptType,
    token,
    employerId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'employer_id': employerId};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
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
  Future<HttpResponse<DataResponseModel>> removeCandidateStarsList({
    acceptType,
    token,
    starId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
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
  Future<HttpResponse<DataResponseModel>> createCandidateForgotPassword({
    acceptType,
    path,
    countryCallingCode,
    phoneNumber,
    email,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Accept': acceptType};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'country_calling_code': countryCallingCode,
      'phone_number': phoneNumber,
      'email': email,
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
              '/candidate/forgot-password/${path}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createCandidateResetPassword({
    acceptType,
    path,
    requestId,
    countryCallingCode,
    phoneNumber,
    email,
    password,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Accept': acceptType};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'request_id': requestId,
      'country_calling_code': countryCallingCode,
      'phone_number': phoneNumber,
      'email': email,
      'password': password,
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
              '/candidate/reset-password/${path}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> updateCandidateWorkPreference({
    acceptType,
    token,
    restDayChoice,
    restDayWorkPref,
    foodAllergy,
    additionalWorkPref,
    tasks,
    updateProgress,
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
      'rest_day_per_month_choice': restDayChoice,
      'rest_day_work_pref': restDayWorkPref,
      'food_drug_allergy': foodAllergy,
      'additional_work_pref': additionalWorkPref,
      'tasks': tasks,
      'update_progress': updateProgress,
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
  Future<HttpResponse<DataResponseModel>> createCandidateSpotlights({
    acceptType,
    category,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Accept': acceptType};
    _headers.removeWhere((k, v) => v == null);
    final _data = {'category': category};
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
              '/candidate/spotlights',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> candidateSaveSearchList({
    acceptType,
    token,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
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
  Future<HttpResponse<DataResponseModel>> updateCandidateSaveSearch({
    acceptType,
    token,
    saveSearchId,
    name,
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
      'id': saveSearchId,
      'name': name,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'PUT',
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
  Future<HttpResponse<DataResponseModel>> deleteCandidateSaveSearch({
    acceptType,
    token,
    saveSearchId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
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
  Future<HttpResponse<DataResponseModel>> createCandidateFCMTOken({
    acceptType,
    token,
    fcmToken,
    userId,
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
      'fcm_token': fcmToken,
      'user_id': userId,
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
              '/candidate/fcm_token',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createCandidateAvatar({
    acceptType,
    token,
    avatar,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (avatar != null) {
      _data.files.add(MapEntry(
        'avatar',
        MultipartFile.fromFileSync(
          avatar.path,
          filename: avatar.path.split(Platform.pathSeparator).last,
          contentType: MediaType.parse('image/png'),
        ),
      ));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              '/candidate/avatar',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> deleteCandidateAvatar({
    acceptType,
    token,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/candidate/avatar',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createCandidateVerification({
    acceptType,
    token,
    requestId,
    method,
    email,
    countryCallingCode,
    phoneNumber,
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
      'request_id': requestId,
      'verified_method': method,
      'email': email,
      'country_calling_code': countryCallingCode,
      'phone_number': phoneNumber,
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
              '/candidate/update_verification',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> deleteCandidateAccount({
    acceptType,
    token,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/candidate/account',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> deleteCandidateProfile({
    acceptType,
    token,
    candidateId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/candidate/profile/${candidateId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createCandidateBId({
    acceptType,
    token,
    countryOfWork,
    salary,
    currency,
    availableStartDate,
    availableEndDate,
    religion,
    restDayChoice,
    restDayWorkPref,
    skillInfantCare,
    skillSpecialNeedsCare,
    skillElderlyCare,
    skillCooking,
    skillGeneralHousework,
    skillPetCare,
    skillHandicapCare,
    skillBedriddenCare,
    age,
    availabilityStatus,
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
      'country_of_work': countryOfWork,
      'salary': salary,
      'currency': currency,
      'start_date': availableStartDate,
      'end_date': availableEndDate,
      'religion': religion,
      'rest_day_per_month_choice': restDayChoice,
      'rest_day_work_pref': restDayWorkPref,
      'skill_infant_care': skillInfantCare,
      'skill_special_needs_care': skillSpecialNeedsCare,
      'skill_elderly_care': skillElderlyCare,
      'skill_cooking': skillCooking,
      'skill_general_housework': skillGeneralHousework,
      'skill_pet_care': skillPetCare,
      'skill_handicap_care': skillHandicapCare,
      'skill_bedridden_care': skillBedriddenCare,
      'age': age,
      'availability_status': availabilityStatus,
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
              '/candidate/bid',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> deleteCandidateBId({
    acceptType,
    token,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/candidate/bid',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> getCandidateReviews({
    acceptType,
    token,
    userId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': userId};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
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
              '/candidate/reviews',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createCandidateReviews({
    acceptType,
    token,
    onUserId,
    review,
    reviewStarRating,
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
      'on_user_id': onUserId,
      'review': review,
      'review_star_rating': reviewStarRating,
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
              '/candidate/reviews',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> updateCandidateReviews({
    acceptType,
    token,
    reviewId,
    review,
    reviewStarRating,
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
      'user_review_id': reviewId,
      'review': review,
      'review_star_rating': reviewStarRating,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/candidate/reviews',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> deleteCandidateReview({
    acceptType,
    token,
    reviewId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/candidate/reviews/${reviewId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> candidateCoinListHistory({
    acceptType,
    token,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
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
  Future<HttpResponse<DataResponseModel>> candidateCoinListBalance({
    acceptType,
    token,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
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
  Future<HttpResponse<DataResponseModel>> candidateReferFriendList({
    acceptType,
    token,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
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
  Future<HttpResponse<DataResponseModel>> candidateAccountUpdate({
    acceptType,
    token,
    avatar,
    firstName,
    lastName,
    email,
    countryCallingCode,
    phoneNumber,
    isEmailVerified,
    isPhoneVerified,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (avatar != null) {
      _data.files.add(MapEntry(
        'avatar',
        MultipartFile.fromFileSync(
          avatar.path,
          filename: avatar.path.split(Platform.pathSeparator).last,
          contentType: MediaType.parse('image/png'),
        ),
      ));
    }
    if (firstName != null) {
      _data.fields.add(MapEntry(
        'first_name',
        firstName,
      ));
    }
    if (lastName != null) {
      _data.fields.add(MapEntry(
        'last_name',
        lastName,
      ));
    }
    if (email != null) {
      _data.fields.add(MapEntry(
        'email',
        email,
      ));
    }
    if (countryCallingCode != null) {
      _data.fields.add(MapEntry(
        'country_calling_code',
        countryCallingCode.toString(),
      ));
    }
    if (phoneNumber != null) {
      _data.fields.add(MapEntry(
        'phone_number',
        phoneNumber.toString(),
      ));
    }
    if (isEmailVerified != null) {
      _data.fields.add(MapEntry(
        'is_email_verified',
        isEmailVerified.toString(),
      ));
    }
    if (isPhoneVerified != null) {
      _data.fields.add(MapEntry(
        'is_phone_verified',
        isPhoneVerified.toString(),
      ));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
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
  Future<HttpResponse<DataResponseModel>> candidateCreateEmploymentSort({
    acceptType,
    token,
    employments,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'employments[]': employments};
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
  Future<HttpResponse<DataResponseModel>> updateCandidateSaveSearchNotify({
    acceptType,
    token,
    savedSearchId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'saved_search_id': savedSearchId};
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
  Future<HttpResponse<DataResponseModel>> updateCandidateShareableLink({
    acceptType,
    token,
    userId,
    link,
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
      'user_id': userId,
      'link': link,
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
  Future<HttpResponse<DataResponseModel>> getCandidateCheckVerified({
    acceptType,
    type,
    email,
    countryCallingCode,
    phoneNumber,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Accept': acceptType};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'type': type,
      'email': email,
      'country_calling_code': countryCallingCode,
      'phone_number': phoneNumber,
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
              '/candidate/check-already-verified',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createCandidateWorkPermit({
    acceptType,
    token,
    dob,
    fin,
    country,
    workPermitFrontFile,
    workPermitBackFile,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (dob != null) {
      _data.fields.add(MapEntry(
        'dob',
        dob,
      ));
    }
    if (fin != null) {
      _data.fields.add(MapEntry(
        'fin',
        fin,
      ));
    }
    if (country != null) {
      _data.fields.add(MapEntry(
        'country',
        country,
      ));
    }
    if (workPermitFrontFile != null) {
      _data.files.add(MapEntry(
        'work_permit_front_filepath',
        MultipartFile.fromFileSync(
          workPermitFrontFile.path,
          filename: workPermitFrontFile.path.split(Platform.pathSeparator).last,
        ),
      ));
    }
    if (workPermitBackFile != null) {
      _data.files.add(MapEntry(
        'work_permit_back_filepath',
        MultipartFile.fromFileSync(
          workPermitBackFile.path,
          filename: workPermitBackFile.path.split(Platform.pathSeparator).last,
        ),
      ));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
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
  Future<HttpResponse<DataResponseModel>> createCandidateComplaint({
    acceptType,
    token,
    userId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'profile_id': userId};
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
  Future<HttpResponse<DataResponseModel>> updateCandidateConfigs({
    acceptType,
    token,
    path,
    appLocale,
    preferredLanguage,
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
      'app_locale': appLocale,
      'preferred_language': preferredLanguage,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'PUT',
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
  Future<HttpResponse<DataResponseModel>> candidateExchange({
    acceptType,
    token,
    base,
    target,
    baseAmount,
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
      'base': base,
      'target': target,
      'base_amount': baseAmount,
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
  Future<HttpResponse<DataResponseModel>> candidateOfferAction({
    acceptType,
    token,
    notificationId,
    action,
    employerId,
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
      'notification_id': notificationId,
      'action': action,
      'employer_id': employerId,
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
