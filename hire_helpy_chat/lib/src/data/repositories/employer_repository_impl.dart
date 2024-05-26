part of 'repositories_impl.dart';

class EmployerRepositoryImpl implements EmployerRepository {
  final EmployerApiService _employerApiService;

  const EmployerRepositoryImpl(this._employerApiService);

  //Employer Configs
  @override
  Future<DataState<DataResponseModel>> employerConfigs(
      EmployerConfigsRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.getEmployerConfigs(
          acceptType: 'application/json', lastTimestamp: params.lastTimestamp);

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

  //Employer Contact Us
  @override
  Future<DataState<DataResponseModel>> employerContactUs(
      EmployerContactUsRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createEmployerContactUs(
        acceptType: 'application/json',
        defaultToken: 'Bearer ${params.token}',
        email: params.email,
        issue: params.issue,
        loginName: params.loginName,
        message: params.message,
        name: params.name,
        phone: params.phone,
        canContactViaPhone: params.canContactViaPhone,
        countryCallingCode: params.countryCallingCode,
        images: params.images,
      );

      if (httpResponse.response.statusCode == 201) {
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

  //Employer Countries
  @override
  Future<DataState<DataResponseModel>> employerCountries() async {
    try {
      final httpResponse = await _employerApiService.getEmployerCountries(
        acceptType: 'application/json',
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
  Future<DataState<DataResponseModel>> employerGenders() async {
    try {
      final httpResponse = await _employerApiService.getEmployerGenders(
        acceptType: 'application/json',
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

  //Employer Language Types
  @override
  Future<DataState<DataResponseModel>> employerLanguageTypes() async {
    try {
      final httpResponse = await _employerApiService.getEmployerLanguageTypes(
        acceptType: 'application/json',
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

  //Employer Login
  @override
  Future<DataState<DataResponseModel>> employerLogin(
      EmployerLoginRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createUserLogin(
        acceptType: 'application/json',
        path: params.path,
        email: params.email,
        countryCallingCode: params.countryCallingCode,
        phoneNumber: params.phoneNumber,
        password: params.password,
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
  Future<DataState<DataResponseModel>> employerLogout(
      EmployerLogoutRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.userLogout(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
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
  Future<DataState<DataResponseModel>> employerRegister(
      EmployerRegisterRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createUserRegister(
          acceptType: 'application/json',
          countryCallingCode: params.countryCallingCode,
          email: params.email,
          firstName: params.firstName,
          lastName: params.lastName,
          password: params.password,
          phoneNumber: params.phoneNumber,
          verifiedMethod: params.verifyMethod,
          referCode: params.referCode,
          requestId: params.requestId,
          appLocale: params.appLocale,
          preferredLanguage: params.preferredLanguage);
      if (httpResponse.response.statusCode == 201) {
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

  //Employer Religions
  @override
  Future<DataState<DataResponseModel>> employerReligions() async {
    try {
      final httpResponse = await _employerApiService.getEmployerReligions(
        acceptType: 'application/json',
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

  //Employer Social Login
  @override
  Future<DataState<DataResponseModel>> employerSocialLogin(
      EmployerSocialLoginRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createSocialLogin(
          acceptType: 'application/json',
          defaultToken: params.token,
          provider: params.provider,
          userId: params.userId);

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

  //Employer Social Register
  @override
  Future<DataState<DataResponseModel>> employerSocialRegister(
      EmployerSocialRegisterRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createSocialRegister(
          acceptType: 'application/json',
          referCode: params.referCode,
          email: params.email,
          firstName: params.firstName,
          lastName: params.lastName,
          provider: params.provider,
          userId: params.userId,
          appLocale: params.appLocale,
          preferredLanguage: params.preferredLanguage);

      if (httpResponse.response.statusCode == 201) {
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

  //Employer Profile
  @override
  Future<DataState<DataResponseModel>> employerProfile(
      EmployerRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.getEmployerProfile(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
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

  //Employer Create About
  @override
  Future<DataState<DataResponseModel>> createEmployerAbout(
      EmployerCreateAboutRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createEmployerAbout(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          countryCallingCode: params.countryCallingCode,
          countryOfResidence: params.countryOfResidence,
          dateOfBirth: params.dateOfBirth,
          email: params.email,
          expectedEmployer: params.expectEmployer,
          firstName: params.firstName,
          lastName: params.lastName,
          phoneNumber: params.phoneNumber,
          gender: params.gender,
          religion: params.religion,
          selfDesc: params.selfDesc,
          nationality: params.nationality,
          updateProgress: params.updateProgress,
          media: params.media,
          portfolios: params.portfolios,
          thumbnails: params.portfolios != null
              ? await generateThumbnails(params.portfolios!)
              : null);

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

  //Employer Create Employments
  @override
  Future<DataState<DataResponseModel>> createEmployerEmployment(
      EmployerCreateEmploymentRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createEmployerEmployment(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          userId: params.userId,
          displayOrder: 1,
          dhRelated: params.dhRelated == true ? 1 : 0,
          endDate: params.endDate,
          countryName: params.workCountryName,
          startDate: params.startDate,
          workDesc: params.workDesc);

      if (httpResponse.response.statusCode == 201) {
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

  //Employer Create Avatar
  @override
  Future<DataState<DataResponseModel>> createEmployerAvatar(
      EmployerCreateAvatarRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createEmployerAvatar(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          avatar: params.avatarFile);

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

  //Employer Delete Employment
  @override
  Future<DataState<DataResponseModel>> deleteEmployerEmployment(
      EmployerDeleteEmploymentRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.deleteEmployerEmployment(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          employmentId: params.employmentID);

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

  //Employer Delete Avatar
  @override
  Future<DataState<DataResponseModel>> deleteEmployerAvatar(
      EmployerDeleteAvatarRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.deleteEmployerAvatar(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
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

  //Employer Availability Status
  @override
  Future<DataState<DataResponseModel>> getEmployerAvailabilityStatus(
      EmployerRequestParams params) async {
    try {
      final httpResponse =
          await _employerApiService.getEmployerAvailabilityStatus(
              acceptType: 'application/json',
              token: 'Bearer ${params.token}',
              appSilo: kAppSilo);

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

  //Employer Employments
  @override
  Future<DataState<DataResponseModel>> getEmployerEmployments(
      EmployerRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.getEmployerEmployments(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
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

  //Employer Update Availability Status
  @override
  Future<DataState<DataResponseModel>> updateEmployerAvailabilityStatus(
      EmployerUpdateAvailabilityStatusRequestParams params) async {
    try {
      final httpResponse =
          await _employerApiService.updateEmployerAvailabilityStatus(
              acceptType: 'application/json',
              token: 'Bearer ${params.token}',
              status: params.status,
              userId: params.userId);

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
  Future<DataState<DataResponseModel>> updateEmployerEmployment(
      EmployerUpdateEmploymentRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.updateEmployerEmployment(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          userId: params.userId,
          dhRelated: params.dhRelated,
          employmentId: params.employmentID,
          endDate: params.endDate,
          startDate: params.startDate,
          countryName: params.workCountryName,
          workDesc: params.workDesc);

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
  Future<DataState<DataResponseModel>> updateEmployerFamilyInformation(
      EmployerUpdateFamilyStatusRequestParams params) async {
    try {
      final httpResponse =
          await _employerApiService.updateEmployerFamilyInformation(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        familyStatus: params.familyStatus,
        members: params.members,
        specialReqChildren: params.specialRequestChildren,
        specialReqElderly: params.specialRequestElderly,
        specialReqPet: params.specialRequestPet,
        updateProgress: params.updateProgress,
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
  Future<DataState<DataResponseModel>> updateEmployerLanguage(
      EmployerUpdateLanguageParams params) async {
    try {
      final httpResponse = await _employerApiService.updateEmployerLanguage(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          userId: params.userId,
          arabic: params.arabic == true ? 1 : 0,
          bahasaIndonesian: params.bahasaIndonesian == true ? 1 : 0,
          bahasaMelayu: params.bahasaMelayu == true ? 1 : 0,
          cantonese: params.cantonese == true ? 1 : 0,
          chineseMandarin: params.chineseMandarin == true ? 1 : 0,
          german: params.german == true ? 1 : 0,
          hokkien: params.hokkien == true ? 1 : 0,
          japanese: params.japanese == true ? 1 : 0,
          korean: params.korean == true ? 1 : 0,
          othersSpecify: params.othersSpecify,
          proficientEnglish: params.proficientEnglish == true ? 1 : 0,
          french: params.french == true ? 1 : 0,
          tamil: params.tamil == true ? 1 : 0,
          teochew: params.teochew == true ? 1 : 0,
          updateProgress: params.updateProgress);

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
  Future<DataState<DataResponseModel>> employerStarList(
      EmployerStarListRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.getEmployerStarsList(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
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
  Future<DataState<DataResponseModel>> employerStarListAdd(
      EmployerStarListAddRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.postEmployerStarsList(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        candidateId: params.candidateId,
      );

      if (httpResponse.response.statusCode == 201) {
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
  Future<DataState<DataResponseModel>> employerStarListRemove(
      EmployerStarListRemoveRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.removeEmployerStarsList(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        starId: params.starId,
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
  Future<DataState<DataResponseModel>> employerForgotPassword(
      EmployerForgotPasswordRequestParams params) async {
    try {
      final httpResponse =
          await _employerApiService.createEmployerForgotPassword(
        acceptType: 'application/json',
        path: params.path,
        email: params.email,
        countryCallingCode: params.countryCallingCode,
        phoneNumber: params.phoneNumber,
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
  Future<DataState<DataResponseModel>> employerResetPassword(
      EmployerResetPasswordRequestParams params) async {
    try {
      final httpResponse =
          await _employerApiService.createEmployerResetPassword(
        acceptType: 'application/json',
        path: params.path,
        email: params.email,
        countryCallingCode: params.countryCallingCode,
        phoneNumber: params.phoneNumber,
        requestId: params.requestId,
        password: params.password,
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

  //Employer Spotlights
  @override
  Future<DataState<DataResponseModel>> employerSpotlights(
      EmployerSpotlightsRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createEmployerSpotlights(
          acceptType: 'application/json', category: params.category);
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

  //Employer Working Preferences
  @override
  Future<DataState<DataResponseModel>> employerUpdateWorkingPreferences(
      EmployerUpdateWorkingPreferenceRequestParams params) async {
    try {
      final httpResponse =
          await _employerApiService.updateEmployerWorkPreference(
              acceptType: 'application/json',
              token: 'Bearer ${params.token}',
              restDayWorkPref: params.restDayWorkPref);
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

  //Employer Delete Save Search
  @override
  Future<DataState<DataResponseModel>> employerDeleteSaveSearch(
      EmployerDeleteSaveSearchRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.deleteEmployerSaveSearch(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          saveSearchId: params.saveSearchId);
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

  //Employer Save Search List
  @override
  Future<DataState<DataResponseModel>> employerSaveSearchList(
      EmployerSaveSearchRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.employerSaveSearchList(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
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

  //Employer Update FCM
  @override
  Future<DataState<DataResponseModel>> employerUpdateFCM(
      EmployerFCMRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createEmployerFCMTOken(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        fcmToken: params.fcmToken,
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

  //Employer Update Save Search
  @override
  Future<DataState<DataResponseModel>> employerUpdateSaveSearch(
      EmployerUpdateSaveSearchRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.updateEmployerSaveSearch(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          name: params.name,
          saveSearchId: params.saveSearchId);
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

  //Employer Create Big Data
  @override
  Future<DataState<DataResponseModel>> createEmployerBigData(
      EmployerCreateOfferRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createEmployerOffer(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          countryOfWork: params.countryOfWorkOffer,
          dhNationality: params.dhNationality,
          salary: params.salary,
          currency: params.currency,
          availableStartDate: params.availableStartDate,
          availableEndDate: params.availableEndDate,
          nationality: params.nationality,
          religion: params.religion,
          skillInfantCare: params.skillInfantCare,
          skillSpecialNeedsCare: params.skillSpecialNeedsCare,
          skillElderlyCare: params.skillElderlyCare,
          skillCooking: params.skillCooking,
          skillGeneralHousework: params.skillGeneralHousework,
          skillPetCare: params.skillPetCare,
          skillBedriddenCare: params.skillBedriddenCare,
          skillHandicapCare: params.skillHandicapCare,
          processFee: params.processFee,
          restDayChoice: params.restDayChoice,
          restDayWorkPref: params.restDayWorkPref,
          availabilityStatus: params.availabilityStatus);

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

  //Employer Create Review
  @override
  Future<DataState<DataResponseModel>> createEmployerReview(
      EmployerCreateReviewsRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createEmployerReviews(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          onUserId: params.onUserId,
          review: params.review,
          reviewStarRating: params.reviewStarRating);
      if (httpResponse.response.statusCode == 201) {
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

  //Employer Delete Account
  @override
  Future<DataState<DataResponseModel>> deleteEmployerAccount(
      EmployerDeleteAccountRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.deleteEmployerAccount(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
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

  //Employer Delete Big Data
  @override
  Future<DataState<DataResponseModel>> deleteEmployerBigData(
      EmployerDeleteOfferRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.deleteEmployerOffer(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
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
  Future<DataState<DataResponseModel>> deleteEmployerProfile(
      EmployerDeleteProfileRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.deleteEmployerProfile(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          employerId: params.employerId);
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
  Future<DataState<DataResponseModel>> deleteEmployerReview(
      EmployerDeleteReviewsRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.deleteEmployerReview(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          reviewId: params.reviewId);
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
  Future<DataState<DataResponseModel>> getEmployerReviews(
      EmployerReviewsRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.getEmployerReviews(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          userId: params.userId);
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
  Future<DataState<DataResponseModel>> updateVerification(
      EmployerUpdateVerificationRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createEmployerVerification(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          appSiloName: kAppSilo,
          countryCallingCode: params.countryCode,
          email: params.email,
          method: params.method,
          phoneNumber: params.phoneNumber,
          requestId: params.requestId,
          userId: params.userId);
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

  //Employer Coin History List
  @override
  Future<DataState<DataResponseModel>> employerCoinListHistory(
      EmployerListVoucherHistoryRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.employerVoucherListHistory(
          acceptType: 'application/json', token: 'Bearer ${params.token}');
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

  //Employer Coin Balance
  @override
  Future<DataState<DataResponseModel>> employerCoinBalance(
      EmployerCoinBalanceRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.employerCoinBalance(
          acceptType: 'application/json', token: 'Bearer ${params.token}');
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

  //Employer Refer Friend List
  @override
  Future<DataState<DataResponseModel>> employerReferFriendList(
      EmployerReferFriendRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.employerReferFriendList(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          userId: params.userId);
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
  Future<DataState<DataResponseModel>> updateEmployerAccount(
      EmployerUpdateAccountRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.employerAccountUpdate(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          userId: params.userId,
          avatar: params.avatar,
          firstName: params.firstName,
          lastName: params.lastName,
          email: params.email,
          countryCallingCode: params.countryCallingCode,
          phoneNumber: params.phoneNumber,
          isEmailVerified: params.isEmailVerified,
          isPhoneVerified: params.isPhoneVerified);
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
  Future<DataState<DataResponseModel>> updateEmployerSavedSearchNotify(
      EmployerNotifySaveSearchRequestParams params) async {
    try {
      final httpResponse =
          await _employerApiService.updateEmployerSaveSearchNotify(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        savedSearchId: params.savedSearchId,
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

  //Employer Update Shareable Link
  @override
  Future<DataState<DataResponseModel>> updateEmployerShareableLink(
      EmployerUpdateShareableLinkRequestParams params) async {
    try {
      final httpResponse =
          await _employerApiService.updateEmployerShareableLink(
              acceptType: 'application/json',
              token: 'Bearer ${params.token}',
              userId: params.userId,
              link: params.link);
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

  //Employer Check Verified
  @override
  Future<DataState<DataResponseModel>> getEmployerCheckVerified(
      EmployerCheckVerifiedRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.getEmployerCheckVerified(
          acceptType: 'application/json',
          countryCallingCode: params.countryCode,
          email: params.email,
          phoneNumber: params.phoneNumber,
          type: params.type);
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
  Future<DataState<DataResponseModel>> createEmployerHiring(
      EmployerHiringRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createEmployerHiring(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          countryCallingCode: params.countryCallingCode,
          phoneNumber: params.phoneNumber,
          candidateId: params.candidateID,
          currency: params.currency,
          salary: params.salary,
          expiryDate: params.expiryDate,
          fromTime: params.fromTime,
          toTime: params.toTime);

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

  //Candidate Profile Complaint
  @override
  Future<DataState<DataResponseModel>> createEmployerComplaint(
      EmployerProfileComplaintRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.createEmployerComplaint(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        userId: params.userId,
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

  //Candidate Update Configs
  @override
  Future<DataState<DataResponseModel>> updateEmployerConfigs(
      EmployerUpdateConfigsRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.updateEmployerConfigs(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          path: params.path,
          appLocale: params.appLocale,
          preferredLanguage: params.preferredLanguage);
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

  //Employer Exchange Rate
  @override
  Future<DataState<DataResponseModel>> employerExchangeRate(
      EmployerExchangeRateRequestParams params) async {
    try {
      final httpResponse = await _employerApiService.employerExchange(
        acceptType: 'application/json',
        base: params.base,
        baseAmount: params.baseAmount,
        target: params.target,
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
}
