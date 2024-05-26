part of 'repositories_impl.dart';

class CandidateRepositoryImpl implements CandidateRepository {
  final CandidateApiService _candidateApiService;

  const CandidateRepositoryImpl(this._candidateApiService);

  //Candidate Configs
  @override
  Future<DataState<DataResponseModel>> candidateConfigs(
      CandidateConfigsRequestParams params) async {
    try {
      final httpResponse = params.lastTimestamp == null
          ? await _candidateApiService.getCandidateConfigs(
              acceptType: 'application/json')
          : await _candidateApiService.getCandidateConfigs(
              acceptType: 'application/json',
              lastTimestamp: params.lastTimestamp);
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

  //Candidate Contact Us
  @override
  Future<DataState<DataResponseModel>> candidateContactUs(
      CandidateContactUsRequestParams params) async {
    try {
      List<File> images = params.images ?? [];
      List<File> thumbnails =
          params.images != null ? await generateThumbnails(params.images!) : [];
      final httpResponse = await _candidateApiService.createCandidateContactUs(
          acceptType: 'application/json',
          defaultToken: 'Bearer ${params.token}',
          email: params.email,
          issue: params.issue,
          loginName: params.loginName,
          message: params.message,
          name: params.name,
          phone: params.phone,
          countryCallingCode: params.countryCallingCode,
          canContactViaPhone: params.canContactViaPhone,
          images: images,
          thumbnails: thumbnails);
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

  //Candidate Countries
  @override
  Future<DataState<DataResponseModel>> candidateCountries() async {
    try {
      final httpResponse = await _candidateApiService.getCandidateCountries(
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
  Future<DataState<DataResponseModel>> candidateGenders() async {
    try {
      final httpResponse = await _candidateApiService.getCandidateGenders(
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

  //Candidate Language Types
  @override
  Future<DataState<DataResponseModel>> candidateLanguageTypes() async {
    try {
      final httpResponse = await _candidateApiService.getCandidateLanguageTypes(
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

  //Candidate Login
  @override
  Future<DataState<DataResponseModel>> candidateLogin(
      CandidateLoginRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.createUserLogin(
          acceptType: 'application/json',
          path: params.path,
          email: params.email,
          countryCallingCode: params.countryCallingCode,
          phoneNumber: params.phoneNumber,
          password: params.password,
          fcmToken: params.fcmToken);

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
  Future<DataState<DataResponseModel>> candidateLogout(
      CandidateLogoutRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.userLogout(
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
  Future<DataState<DataResponseModel>> candidateRegister(
      CandidateRegisterRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.createUserRegister(
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

  //Candidate Religions
  @override
  Future<DataState<DataResponseModel>> candidateReligions() async {
    try {
      final httpResponse = await _candidateApiService.getCandidateReligions(
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

  //Candidate Social Login
  @override
  Future<DataState<DataResponseModel>> candidateSocialLogin(
      CandidateSocialLoginRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.createSocialLogin(
          acceptType: 'application/json',
          provider: params.provider,
          userId: params.userId,
          fcmToken: params.fcmToken);

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

  //Candidate Social Register
  @override
  Future<DataState<DataResponseModel>> candidateSocialRegister(
      CandidateSocialRegisterRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.createSocialRegister(
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

  //Candidate Profile
  @override
  Future<DataState<DataResponseModel>> candidateProfile(
      CandidateRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.getCandidateProfile(
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

  //Candidate Create About
  @override
  Future<DataState<DataResponseModel>> createCandidateAbout(
      CandidateCreateAboutRequestParams params) async {
    try {
      List<File> portfolios = params.portfolios ?? [];
      List<File> thumbnails = params.portfolios != null
          ? await generateThumbnails(params.portfolios!)
          : [];
      final httpResponse = await _candidateApiService.createCandidateAbout(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          arabic: params.arabic == true ? 1 : 0,
          bahasaIndonesian: params.bahasaIndonesian == true ? 1 : 0,
          bahasaMelayu: params.bahasaMelayu == true ? 1 : 0,
          cantonese: params.cantonese == true ? 1 : 0,
          chineseMandarin: params.chineseMandarin == true ? 1 : 0,
          countryCallingCode: params.countryCallingCode,
          countryOfResidence: params.countryOfResidence,
          dateOfBirth: params.dateOfBirth,
          email: params.email,
          expectedEmployer: params.expectEmployer,
          firstName: params.firstName,
          lastName: params.lastName,
          french: params.french == true ? 1 : 0,
          gender: params.gender,
          german: params.german == true ? 1 : 0,
          height: params.height,
          hokkien: params.hokkien == true ? 1 : 0,
          japanese: params.japanese == true ? 1 : 0,
          korean: params.korean == true ? 1 : 0,
          nationality: params.nationality,
          othersSpecify: params.othersSpecify,
          phoneNumber: params.phoneNumber,
          proficientEnglish: params.proficientEnglish == true ? 1 : 0,
          religion: params.religion,
          selfDesc: params.selfDesc,
          tamil: params.tamil == true ? 1 : 0,
          teochew: params.teochew == true ? 1 : 0,
          weight: params.weight,
          updateProgress: params.updateProgress,
          media: params.media,
          isEmailVerified: params.isEmailVerified,
          isPhoneVerified: params.isPhoneVerified,);
        for (int i = 0; i < portfolios.length; i++) {
          final httpResponseUpload =
              await _candidateApiService.singleFileUploadProfile(
                  acceptType: 'application/json',
                  token: 'Bearer ${params.token}',
                  portfolio: portfolios[i],
                  thumbnail: thumbnails[i]);
          superPrint(httpResponseUpload.data.data);
        }

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

  //Candidate Create Employments
  @override
  Future<DataState<DataResponseModel>> createCandidateEmployment(
      CandidateCreateEmploymentRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.createCandidateEmployment(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        displayOrder: params.displayOrder,
        dhRelated: params.dhRelated,
        endDate: params.endDate,
        countryName: params.workCountryName,
        startDate: params.startDate,
        workDesc: params.workDesc,
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

  //Candidate Create Avatar
  @override
  Future<DataState<DataResponseModel>> createCandidateAvatar(
      CandidateCreateAvatarRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.createCandidateAvatar(
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

  //Candidate Delete Employment
  @override
  Future<DataState<DataResponseModel>> deleteCandidateEmployment(
      CandidateDeleteEmploymentRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.deleteCandidateEmployment(
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

  //Candidate Delete Avatar
  @override
  Future<DataState<DataResponseModel>> deleteCandidateAvatar(
      CandidateDeleteAvatarRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.deleteCandidateAvatar(
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

  //Candidate Availability Status
  @override
  Future<DataState<DataResponseModel>> getCandidateAvailabilityStatus(
      CandidateRequestParams params) async {
    try {
      final httpResponse =
          await _candidateApiService.getCandidateAvailabilityStatus(
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

  //Candidate Employments
  @override
  Future<DataState<DataResponseModel>> getCandidateEmployments(
      CandidateRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.getCandidateEmployments(
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

  //Candidate Update Availability Status
  @override
  Future<DataState<DataResponseModel>> updateCandidateAvailabilityStatus(
      CandidateUpdateAvailabilityStatusRequestParams params) async {
    try {
      final httpResponse =
          await _candidateApiService.updateCandidateAvailabilityStatus(
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
  Future<DataState<DataResponseModel>> updateCandidateEmployment(
      CandidateUpdateEmploymentRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.updateCandidateEmployment(
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
  Future<DataState<DataResponseModel>> updateCandidateFamilyInformation(
      CandidateUpdateFamilyStatusRequestParams params) async {
    try {
      final httpResponse =
          await _candidateApiService.updateCandidateFamilyInformation(
              acceptType: 'application/json',
              token: 'Bearer ${params.token}',
              familyStatus: params.familyStatus,
              numOfSiblings: params.numOfSiblings,
              members: params.members,
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
  Future<DataState<DataResponseModel>> updateCandidateSkillAndQualification(
      CandidateUpdateSkillAndQualificationRequestParams params) async {
    try {
      final httpResponse =
          await _candidateApiService.updateCandidateSkillAndQualification(
              acceptType: 'application/json',
              token: 'Bearer ${params.token}',
              educationJourneyDesc: params.educationJourneyDesc,
              highestQualification: params.highestQualification,
              skillBedriddenCare: params.skillBedriddenCare == true ? 1 : 0,
              skillCooking: params.skillCooking == true ? 1 : 0,
              skillInfantCare: params.skillInfantCare == true ? 1 : 0,
              skillElderlyCare: params.skillElderlyCare == true ? 1 : 0,
              skillGeneralHousework:
                  params.skillGeneralHousework == true ? 1 : 0,
              skillHandicapCare: params.skillHandicapCare == true ? 1 : 0,
              skillPetCare: params.skillPetCare == true ? 1 : 0,
              skillSpecialNeedsCare:
                  params.skillSpecialNeedsCare == true ? 1 : 0,
              skillOthersSpecify: params.skillOthersSpecify,
              workPermitFinNumberHash: params.workPermitFinNumberHash,
              workPermitIssueCountryName: params.workPermitIssueCountryName,
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
  Future<DataState<DataResponseModel>> candidateStarList(
      CandidateStarListRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.getCandidateStarsList(
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
  Future<DataState<DataResponseModel>> candidateStarListAdd(
      CandidateStarListAddRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.postCandidateStarsList(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        employerId: params.employerId,
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
  Future<DataState<DataResponseModel>> candidateStarListRemove(
      CandidateStarListRemoveRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.removeCandidateStarsList(
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
  Future<DataState<DataResponseModel>> candidateForgotPassword(
      CandidateForgotPasswordRequestParams params) async {
    try {
      final httpResponse =
          await _candidateApiService.createCandidateForgotPassword(
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
  Future<DataState<DataResponseModel>> candidateResetPassword(
      CandidateResetPasswordRequestParams params) async {
    try {
      final httpResponse =
          await _candidateApiService.createCandidateResetPassword(
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

  //Candidate Spotlights
  @override
  Future<DataState<DataResponseModel>> candidateSpotlights(
      CandidateSpotlightsRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.createCandidateSpotlights(
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

  //Candidate Working Preferences
  @override
  Future<DataState<DataResponseModel>> candidateUpdateWorkingPreferences(
      CandidateUpdateWorkingPreferenceRequestParams params) async {
    try {
      final httpResponse =
          await _candidateApiService.updateCandidateWorkPreference(
              acceptType: 'application/json',
              token: 'Bearer ${params.token}',
              restDayChoice: params.restDayChoice,
              restDayWorkPref: params.restDayWorkPref,
              foodAllergy: params.drugAllergy,
              additionalWorkPref: params.additionalWorkPref,
              tasks: params.tasks,
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

  //Candidate Delete Save Search
  @override
  Future<DataState<DataResponseModel>> candidateDeleteSaveSearch(
      CandidateDeleteSaveSearchRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.deleteCandidateSaveSearch(
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

  //Candidate Save Search List
  @override
  Future<DataState<DataResponseModel>> candidateSaveSearchList(
      CandidateSaveSearchRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.candidateSaveSearchList(
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

  //Candidate Update FCM
  @override
  Future<DataState<DataResponseModel>> candidateUpdateFCM(
      CandidateFCMRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.createCandidateFCMTOken(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          fcmToken: params.fcmToken,
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

  //Candidate Update Save Search
  @override
  Future<DataState<DataResponseModel>> candidateUpdateSaveSearch(
      CandidateUpdateSaveSearchRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.updateCandidateSaveSearch(
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

  //Candidate Create Big Data
  @override
  Future<DataState<DataResponseModel>> createCandidateBigData(
      CandidateCreateBigDataRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.createCandidateBId(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          countryOfWork: params.countryOfWork,
          salary: params.salary,
          currency: params.currency,
          availableStartDate: params.availableStartDate,
          availableEndDate: params.availableEndDate,
          //nationality: params.nationality,
          religion: params.religion,
          skillInfantCare: params.skillInfantCare,
          skillSpecialNeedsCare: params.skillSpecialNeedsCare,
          skillElderlyCare: params.skillElderlyCare,
          skillCooking: params.skillCooking,
          skillGeneralHousework: params.skillGeneralHousework,
          skillPetCare: params.skillPetCare,
          skillBedriddenCare: params.skillBedriddenCare,
          skillHandicapCare: params.skillHandicapCare,
          // proficientEnglish: params.languageProficientEnglish,
          // chineseMandarin: params.languageChineseMandarin,
          // bahasaMelayu: params.languageBahasaMelayu,
          // tamil: params.languageTamil,
          // hokkien: params.languageHokkien,
          // teochew: params.languageTeochew,
          // cantonese: params.languageCantonese,
          // bahasaIndonesian: params.languageBahasaIndonesian,
          // japanese: params.languageJapanese,
          // korean: params.languageKorean,
          // french: params.languageFrench,
          // german: params.languageGerman,
          // arabic: params.languageArabic,
          // agentFee: params.agentFee,
          // countryOfResidence: params.countryOfResidence,
          age: params.age,
          availabilityStatus: params.availabilityStatus,
          restDayChoice: params.restDayChoice,
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

  //Candidate Create Review
  @override
  Future<DataState<DataResponseModel>> createCandidateReview(
      CandidateCreateReviewsRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.createCandidateReviews(
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

  //Candidate Delete Account
  @override
  Future<DataState<DataResponseModel>> deleteCandidateAccount(
      CandidateDeleteAccountRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.deleteCandidateAccount(
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

  //Candidate Delete Big Data
  @override
  Future<DataState<DataResponseModel>> deleteCandidateBigData(
      CandidateDeleteBigDataRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.deleteCandidateBId(
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
  Future<DataState<DataResponseModel>> deleteCandidateProfile(
      CandidateDeleteProfileRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.deleteCandidateProfile(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          candidateId: params.candidateId);
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
  Future<DataState<DataResponseModel>> deleteCandidateReview(
      CandidateDeleteReviewsRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.deleteCandidateReview(
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
  Future<DataState<DataResponseModel>> getCandidateReviews(
      CandidateReviewsRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.getCandidateReviews(
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
      CandidateUpdateVerificationRequestParams params) async {
    try {
      final httpResponse =
          await _candidateApiService.createCandidateVerification(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        countryCallingCode: params.countryCode,
        email: params.email,
        method: params.method,
        phoneNumber: params.phoneNumber,
        requestId: params.requestId,
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

  //Candidate Coin History List
  @override
  Future<DataState<DataResponseModel>> candidateCoinListHistory(
      CandidateListCoinHistoryRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.candidateCoinListHistory(
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

  //Candidate Coin Balance List
  @override
  Future<DataState<DataResponseModel>> candidateCoinListBalance(
      CandidateListCoinBalanceRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.candidateCoinListBalance(
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

  //Candidate Refer Friend List
  @override
  Future<DataState<DataResponseModel>> candidateReferFriendList(
      CandidateReferFriendRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.candidateReferFriendList(
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
  Future<DataState<DataResponseModel>> updateCandidateAccount(
      CandidateUpdateAccountRequestParams params) async {
    final httpResponse = await _candidateApiService.candidateAccountUpdate(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
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
    // try {

    // } on DioError catch (e) {
    //   return DataFailed(e);
    // }
  }

  @override
  Future<DataState<DataResponseModel>> createCandidateEmploymentSort(
      CandidateCreateEmploymentSortRequestParams params) async {
    try {
      final httpResponse =
          await _candidateApiService.candidateCreateEmploymentSort(
              acceptType: 'application/json',
              token: 'Bearer ${params.token}',
              employments: params.employments);
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
  Future<DataState<DataResponseModel>> updateCandidateSavedSearchNotify(
      CandidateNotifySaveSearchRequestParams params) async {
    try {
      final httpResponse =
          await _candidateApiService.updateCandidateSaveSearchNotify(
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

  //Candidate Update Shareable Link
  @override
  Future<DataState<DataResponseModel>> updateCandidateShareableLink(
      CandidateUpdateShareableLinkRequestParams params) async {
    try {
      final httpResponse =
          await _candidateApiService.updateCandidateShareableLink(
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

  //Candidate Check Verified
  @override
  Future<DataState<DataResponseModel>> getCandidateCheckVerified(
      CandidateCheckVerifiedRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.getCandidateCheckVerified(
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

  //Candidate Profile Complaint
  @override
  Future<DataState<DataResponseModel>> createCandidateComplaint(
      CandidateProfileComplaintRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.createCandidateComplaint(
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

  @override
  Future<DataState<DataResponseModel>> createCandidateWorkPermit(
      CandidateWorkPermitRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.createCandidateWorkPermit(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          country: params.country,
          dob: params.dob,
          fin: params.fin,
          workPermitFrontFile: params.workPermitFrontFile,
          workPermitBackFile: params.workPermitBackFile);
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
  Future<DataState<DataResponseModel>> updateCandidateConfigs(
      CandidateUpdateConfigsRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.updateCandidateConfigs(
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

  //Candidate Exchange Rate
  @override
  Future<DataState<DataResponseModel>> candidateExchangeRate(
      CandidateExchangeRateRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.candidateExchange(
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

  @override
  Future<DataState<DataResponseModel>> candidateOfferAction(
      CandidateOfferActionRequestParams params) async {
    try {
      final httpResponse = await _candidateApiService.candidateOfferAction(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          action: params.action,
          employerId: params.employerId,
          notificationId: params.notificationId);

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
