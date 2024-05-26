part of blocs;

class CandidateBloc extends BlocWithState<CandidateEvent, CandidateState> {
  // ignore: non_constant_identifier_names
  final CreateCandidateLoginUseCase _createCandidateLoginUseCase;
  final CreateCandidateContactUsUseCase _createCandidateContactUsCase;
  final CreateCandidateRegisterUseCase _createCandidateRegisterUseCase;
  final CreateCandidateSocialLoginUseCase _createCandidateSocialLoginUseCase;
  final CreateCandidateSocialRegisterUseCase
      _createCandidateSocialRegisterUseCase;
  final GetCandidateLoginOutUseCase _getCandidateLoginOutUseCase;
  final GetCandidateConfigsUseCase _getCandidateConfigsUseCase;
  final GetCandidateCountriesUseCase _getCandidateCountriesUseCase;
  final GetCandidateGendersUseCase _getCandidateGendersUseCase;
  final GetCandidateLanguageTypesUseCase _getCandidateLanguageTypesUseCase;
  final GetCandidateReligionsUseCase _getCandidateReligionsUseCase;
  final GetCandidateStarListUseCase _getCandidateStarListUseCase;
  final CreateCandidateStarListUseCase _createCandidateStarListUseCase;
  final RemoveCandidateStarListUseCase _removeCandidateStarListUseCase;
  final CreateCandidateAboutUseCase _createCandidateAboutUseCase;
  final CreateCandidateEmploymentUseCase _createCandidateEmploymentUseCase;
  final CreateCandidateAvatarUseCase _createCandidateAvatarUseCase;
  final DeleteCandidateEmploymentUseCase _deleteCandidateEmploymentUseCase;
  final DeleteCandidateAvatarUseCase _deleteCandidateAvatarUseCase;
  final GetCandidateAvailabilityUseCase _getCandidateAvailabilityUseCase;
  final GetCandidateEmploymentsUseCase _getCandidateEmploymentsUseCase;
  final GetCandidateProfileUseCase _getCandidateProfileUseCase;
  final UpdateCandidateAvailabilityUseCase _updateCandidateAvailabilityUseCase;
  final UpdateCandidateEmploymentUseCase _updateCandidateEmploymentUseCase;
  final UpdateCandidateFamilyInformationUseCase
      _updateCandidateFamilyInformationUseCase;
  final UpdateCandidateSkillQualificationUseCase
      _updateCandidateSkillQualificationUseCase;
  final CreateCandidateWorkingPreferenceUseCase
      _createCandidateWorkingPreferenceUseCase;
  final CreateCandidateForgotPasswordUseCase
      _createCandidateForgotPasswordUseCase;
  final CreateCandidateResetPasswordUseCase
      _createCandidateResetPasswordUseCase;
  final CreateCandidateSpotlightsUseCase _createCandidateSpotlightsUseCase;
  final UpdateCandidateFCMUseCase _updateCandidateFCMUseCase;
  final GetCandidateSaveSearchUseCase _getCandidateSaveSearchUseCase;
  final UpdateCandidateSaveSearchUseCase _updateCandidateSaveSearchUseCase;
  final DeleteCandidateSaveSearchUseCase _deleteCandidateSaveSearchUseCase;
  final CreateCandidateBigDataUseCase _createCandidateBigDataUseCase;
  final DeleteCandidateBigDataUseCase _deleteCandidateBigDataUseCase;
  final CreateCandidateVerificationUseCase _createCandidateVerificationUseCase;
  final DeleteCandidateAccountUseCase _deleteCandidateAccountUseCase;
  final DeleteCandidateProfileUseCase _deleteCandidateProfileUseCase;
  final GetCandidateReviewUseCase _getCandidateReviewUseCase;
  final CreateCandidateReviewUseCase _createCandidateReviewUseCase;
  final DeleteCandidateReviewUseCase _deleteCandidateReviewUseCase;
  final GetCandidateCoinHistoryUseCase _getCandidateCoinHistoryUseCase;
  final GetCandidateCoinBalanceUseCase _getCandidateCoinBalanceUseCase;
  final GetCandidateReferFriendUseCase _getCandidateReferFriendUseCase;
  final UpdateCandidateAccountUseCase _updateCandidateAccountUseCase;
  final CreateCandidateEmploymentSortUseCase
      _createCandidateEmploymentSortUseCase;
  final UpdateCandidateSaveSearchNotifyUseCase
      _updateCandidateSaveSearchNotifyUseCase;
  final UpdateCandidateShareableLinkUseCase
      _updateCandidateShareableLinkUseCase;
  final GetCandidateCheckVerifiedUseCase _getCandidateCheckVerifiedUseCase;
  final CreateCandidateWorkPermitUseCase _createCandidateWorkPermitUseCase;
  final CreateCandidateComplaintUseCase _createCandidateComplaintUseCase;
  final UpdateCandidateConfigsUseCase _updateCandidateConfigsUseCase;
  final CreateCandidateExchangeUseCase _createCandidateExchangeUseCase;
  final CreateCandidateOfferActionUseCase _createCandidateOfferActionUseCase;

  CandidateBloc(
    this._createCandidateLoginUseCase,
    this._createCandidateContactUsCase,
    this._createCandidateRegisterUseCase,
    this._createCandidateSocialLoginUseCase,
    this._createCandidateSocialRegisterUseCase,
    this._getCandidateLoginOutUseCase,
    this._getCandidateConfigsUseCase,
    this._getCandidateCountriesUseCase,
    this._getCandidateGendersUseCase,
    this._getCandidateLanguageTypesUseCase,
    this._getCandidateReligionsUseCase,
    this._getCandidateStarListUseCase,
    this._createCandidateStarListUseCase,
    this._removeCandidateStarListUseCase,
    this._createCandidateAboutUseCase,
    this._createCandidateEmploymentUseCase,
    this._createCandidateAvatarUseCase,
    this._deleteCandidateEmploymentUseCase,
    this._deleteCandidateAvatarUseCase,
    this._getCandidateAvailabilityUseCase,
    this._getCandidateEmploymentsUseCase,
    this._getCandidateProfileUseCase,
    this._updateCandidateAvailabilityUseCase,
    this._updateCandidateEmploymentUseCase,
    this._updateCandidateFamilyInformationUseCase,
    this._updateCandidateSkillQualificationUseCase,
    this._createCandidateForgotPasswordUseCase,
    this._createCandidateResetPasswordUseCase,
    this._createCandidateSpotlightsUseCase,
    this._createCandidateWorkingPreferenceUseCase,
    this._updateCandidateFCMUseCase,
    this._getCandidateSaveSearchUseCase,
    this._deleteCandidateSaveSearchUseCase,
    this._updateCandidateSaveSearchUseCase,
    this._createCandidateBigDataUseCase,
    this._deleteCandidateBigDataUseCase,
    this._createCandidateVerificationUseCase,
    this._deleteCandidateAccountUseCase,
    this._deleteCandidateProfileUseCase,
    this._getCandidateReviewUseCase,
    this._createCandidateReviewUseCase,
    this._deleteCandidateReviewUseCase,
    this._getCandidateCoinHistoryUseCase,
    this._getCandidateCoinBalanceUseCase,
    this._getCandidateReferFriendUseCase,
    this._updateCandidateAccountUseCase,
    this._createCandidateEmploymentSortUseCase,
    this._updateCandidateSaveSearchNotifyUseCase,
    this._updateCandidateShareableLinkUseCase,
    this._getCandidateCheckVerifiedUseCase,
    this._createCandidateWorkPermitUseCase,
    this._createCandidateComplaintUseCase,
    this._updateCandidateConfigsUseCase,
    this._createCandidateExchangeUseCase,
    this._createCandidateOfferActionUseCase,
  ) : super(CandidateInitialState());

  @override
  Stream<CandidateState> mapEventToState(CandidateEvent event) async* {
    if (event is InitializeCandidateEvent) {
      yield* _getInitializeCandidate(event);
    }

    if (event is WorkPermitPhotoTaken) yield* _workPermitPhotoTaken(event);

    if (event is CandidateLoginRequested) yield* _candidateLogin(event);

    if (event is CandidateContactUsRequested) yield* _candidateContactUs(event);

    if (event is CandidateRegisterRequested) yield* _candidateRegister(event);

    if (event is CandidateSocialLoginRequested) {
      yield* _candidateSocialLogin(event);
    }

    if (event is CandidateSocialRegisterRequested) {
      yield* _candidateSocialRegister(event);
    }

    if (event is CandidateLogoutRequested) yield* _candidateLogout(event);

    if (event is CandidateConfigsRequested) yield* _candidateConfigs(event);

    if (event is CandidateCountriesRequested) yield* _candidateCountries(event);

    if (event is CandidateGendersRequested) yield* _candidateGenders(event);

    if (event is CandidateLanguageTypesRequested) {
      yield* _candidateLanguageTypes(event);
    }

    if (event is CandidateReligionsRequested) yield* _candidateReligions(event);

    if (event is CandidateUpdateAppLanguage) {
      yield* _candidateUpdateAppLanguage(event);
    }

    if (event is CandidateUpdateAppLocale) {
      yield* _candidateUpdateAppLocale(event);
    }

    if (event is CandidateStarListRequested) yield* _candidateStarList(event);

    if (event is CandidateStarListAddRequested) {
      yield* _candidateStarListAdd(event);
    }

    if (event is CandidateStarListRemoveRequested) {
      yield* _candidateStarListRemove(event);
    }

    if (event is CandidateCreateAboutRequested) {
      yield* _candidateCreateAbout(event);
    }

    if (event is CandidateCreateEmploymentRequested) {
      yield* _candidateCreateEmployment(event);
    }

    if (event is CandidateCreateAvatarRequested) {
      yield* _candidateCreateAvatar(event);
    }

    if (event is CandidateDeleteEmploymentRequested) {
      yield* _candidateDeleteEmployment(event);
    }

    if (event is CandidateDeleteAvatarRequested) {
      yield* _candidateDeleteAvatar(event);
    }

    if (event is CandidateAvailabilityRequested) {
      yield* _candidateAvailabilty(event);
    }

    if (event is CandidateEmploymentRequested) {
      yield* _candidateEmployment(event);
    }

    if (event is CandidateProfileRequested) yield* _candidateProfile(event);

    if (event is CandidateUpdateAvailabilityRequested) {
      yield* _candidateUpdateAvailability(event);
    }

    if (event is CandidateUpdateEmlpoymentRequested) {
      yield* _candidateUpdateEmployment(event);
    }

    if (event is CandidateUpdateFamilyInformationRequested) {
      yield* _candidateUpdateFamilyInformation(event);
    }

    if (event is CandidateUpdateSkillAndQualificationRequested) {
      yield* _candidateUpdateSkill(event);
    }

    if (event is CandidateResetPasswordRequested) {
      yield* _candidateResetPassword(event);
    }
    if (event is CandidateForgotPasswordRequested) {
      yield* _candidateForgotPassword(event);
    }

    if (event is CandidateUpdateWorkingPreferencesRequested) {
      yield* _candidateWorkingPreferences(event);
    }

    if (event is CandidateSpotlightsRequested) {
      yield* _candidateCreateSpotlights(event);
    }

    if (event is CandidateUpdateFCMRequested) {
      yield* _candidateUpdateFCM(event);
    }

    if (event is CandidateSaveSearchListRequested) {
      yield* _candidateSaveSearchList(event);
    }

    if (event is CandidateUpdateSaveSearchRequested) {
      yield* _candidateUpdateSaveSearch(event);
    }

    if (event is CandidateDeleteSaveSearchRequested) {
      yield* _candidateDeleteSaveSearch(event);
    }

    if (event is CandidateCreateBigDataRequested) {
      yield* _candidateCreateBigData(event);
    }

    if (event is CandidateDeleteBigDataRequested) {
      yield* _candidateDeleteBigData(event);
    }

    if (event is CandidateCreateVerificationRequested) {
      yield* _candidateCreateVerification(event);
    }

    if (event is CandidateDeleteAccountRequested) {
      yield* _candidateDeleteAccount(event);
    }

    if (event is CandidateDeleteProfileRequested) {
      yield* _candidateDeleteProfile(event);
    }

    if (event is CandidateReviewsRequested) {
      yield* _candidateReviews(event);
    }

    if (event is CandidateCreateReviewRequested) {
      yield* _candidateCreateReview(event);
    }

    if (event is CandidateDeleteReviewRequested) {
      yield* _candidateDeleteReview(event);
    }
    if (event is CandidateCoinHistoryListRequested) {
      yield* _candidateCoinHistoryList(event);
    }

    if (event is CandidateCoinBalanceListRequested) {
      yield* _candidateCoinBalanceList(event);
    }

    if (event is CandidateReferFriendListRequested) {
      yield* _candidateReferFriendList(event);
    }

    if (event is CandidateUpdateAccountRequested) {
      yield* _candidateUpdateAccount(event);
    }

    if (event is CandidateEmploymentSortRequested) {
      yield* _candidateEmploymentSort(event);
    }

    if (event is CandidateNotifySaveSearchRequested) {
      yield* _candidateNotifySaveSearch(event);
    }

    if (event is CandidateUpdateShareableLinkRequested) {
      yield* _candidateUpdateShareableLink(event);
    }

    if (event is CandidateCheckVerifiedRequested) {
      yield* _candidateCheckVerified(event);
    }

    if (event is CandidateWorkPermitRequested) {
      yield* _candidateWorkPermit(event);
    }

    if (event is CandidateProfileComplaintRequested) {
      yield* _candidateProfileComplaint(event);
    }

    if (event is CandidateUpdateConfigsRequested) {
      yield* _candidateUpdateConfigs(event);
    }

    if (event is CandidateExchangeRateRequested) {
      yield* _candidateExchangeRate(event);
    }

    if (event is CandidatePHCSalaryRangeExchangeRequested) {
      yield* _candidatePHCSalaryRangeExchange(event);
    }

    if (event is CandidateOfferActionRequested) {
      yield* _candidateOfferAction(event);
    }
  }

  // Work Permit
  WorkPermitDetails? workPermit;

  void resetWorkPermit() {
    workPermit = null;
  }

  void mergeNewWorkPermit(WorkPermitDetails workPermitDetails,
      {required bool isFront}) {
    if (workPermit == null) {
      workPermit = workPermitDetails;
      return;
    }
    workPermit!.mergeOtherDetails(workPermitDetails, isFront: isFront);
  }

  Stream<CandidateState> _workPermitPhotoTaken(
      WorkPermitPhotoTaken event) async* {
    yield* runBlocProcess(() async* {
      yield WorkPermitPhotoUpdated(workPermitDetails: workPermit!);
    });
  }

  String? route = '';
  String? title = "";
  String? description = "";
  String? fileString = "";
  String? language = "";
  bool? preview = false;
  String? type = 'assets';
  String? path = "";
  String? tempFiles;
  Set<String>? tempFilesSet;
  bool? isOnlyPhoto;

  Stream<CandidateState> _getInitializeCandidate(
      InitializeCandidateEvent event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateInitialState();
    });
  }

  //Candidate ContactUs
  Stream<CandidateState> _candidateContactUs(
      CandidateContactUsRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateContactUsLoading();
      final dataState = await _createCandidateContactUsCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateContactUsSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateContactUsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateContactUsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Login
  Stream<CandidateState> _candidateLogin(CandidateLoginRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateLoginLoading();
      final dataState = await _createCandidateLoginUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateLoginSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response!.statusCode! == 401) {
          yield CandidateLoginFail(
              message: json.encode(dataState.error!.response!.data));
        } else if (dataState.error!.response == null) {
          yield const CandidateLoginFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateLoginFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Register
  Stream<CandidateState> _candidateRegister(
      CandidateRegisterRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateRegisterLoading();
      final dataState = await _createCandidateRegisterUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateRegisterSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateRegisterFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateRegisterFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Social Login
  Stream<CandidateState> _candidateSocialLogin(
      CandidateSocialLoginRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateSocialLoginLoading();
      final dataState = await _createCandidateSocialLoginUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateSocialLoginSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response!.statusCode! == 401) {
          yield CandidateSocialLoginFail(
              message: json.encode(dataState.error!.response!.data));
        } else if (dataState.error!.response == null) {
          yield const CandidateSocialLoginFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateSocialLoginFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Social Register
  Stream<CandidateState> _candidateSocialRegister(
      CandidateSocialRegisterRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateSocialRegisterLoading();
      final dataState = await _createCandidateSocialRegisterUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateSocialRegisterSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateSocialRegisterFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateSocialRegisterFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Logout
  Stream<CandidateState> _candidateLogout(
      CandidateLogoutRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateLogoutLoading();
      final dataState = await _getCandidateLoginOutUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateLogoutSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateLogoutFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateLogoutFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Configs
  Stream<CandidateState> _candidateConfigs(
      CandidateConfigsRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateConfigsLoading();
      final dataState = await _getCandidateConfigsUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateConfigsSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateConfigsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          superPrint(dataState.error!.response!.data);
          yield CandidateConfigsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Countries
  Stream<CandidateState> _candidateCountries(
      CandidateCountriesRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateCountriesLoading();
      final dataState = await _getCandidateCountriesUseCase();

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateCountriesSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateCountriesFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateCountriesFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Genders
  Stream<CandidateState> _candidateGenders(
      CandidateGendersRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateGendersLoading();
      final dataState = await _getCandidateGendersUseCase();

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateGendersSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateGendersFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateGendersFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Language Types
  Stream<CandidateState> _candidateLanguageTypes(
      CandidateLanguageTypesRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateLanguageTypesLoading();
      final dataState = await _getCandidateLanguageTypesUseCase();

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateLanguageTypesSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateLanguageTypesFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateLanguageTypesFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Religions
  Stream<CandidateState> _candidateReligions(
      CandidateReligionsRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateReligionsLoading();
      final dataState = await _getCandidateReligionsUseCase();

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateReligionsSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateReligionsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateReligionsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  Stream<CandidateState> _candidateUpdateAppLanguage(
      CandidateUpdateAppLanguage event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateUpdateAppLanguageSuccess(language: event.language);
    });
  }

  Stream<CandidateState> _candidateUpdateAppLocale(
      CandidateUpdateAppLocale event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateUpdateAppLocaleSuccess(appLocale: event.appLocale);
    });
  }

  //Candidate StarList
  Stream<CandidateState> _candidateStarList(
      CandidateStarListRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateStarListLoading();
      final dataState = await _getCandidateStarListUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateStarListSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateStarListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateStarListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate StarListADD
  Stream<CandidateState> _candidateStarListAdd(
      CandidateStarListAddRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateStarListAddLoading();
      final dataState = await _createCandidateStarListUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateStarListAddSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateStarListAddFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateStarListAddFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate StarList Remove
  Stream<CandidateState> _candidateStarListRemove(
      CandidateStarListRemoveRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateStarListAddLoading();
      final dataState = await _removeCandidateStarListUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateStarListRemoveSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateStarListRemoveFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateStarListRemoveFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Create About
  Stream<CandidateState> _candidateCreateAbout(
      CandidateCreateAboutRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateCreateAboutStepLoading();
      final dataState =
          await _createCandidateAboutUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateCreateAboutStepSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateCreateAboutStepFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateCreateAboutStepFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Create Employment
  Stream<CandidateState> _candidateCreateEmployment(
      CandidateCreateEmploymentRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateCreateEmploymentLoading();
      final dataState =
          await _createCandidateEmploymentUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateCreateEmploymentSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateCreateEmploymentFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateCreateEmploymentFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Create Avatar
  Stream<CandidateState> _candidateCreateAvatar(
      CandidateCreateAvatarRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateCreateAvatarLoading();
      final dataState =
          await _createCandidateAvatarUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateCreateAvatarSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateCreateAvatarFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateCreateAvatarFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Availabilty
  Stream<CandidateState> _candidateAvailabilty(
      CandidateAvailabilityRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateAvailabilityStatusLoading();
      final dataState =
          await _getCandidateAvailabilityUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateAvailabilityStatusSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateAvailabilityStatusFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateAvailabilityStatusFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Employment
  Stream<CandidateState> _candidateEmployment(
      CandidateEmploymentRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateEmploymentsLoading();
      final dataState =
          await _getCandidateEmploymentsUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateEmploymentsSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateEmploymentsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateEmploymentsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Profile
  Stream<CandidateState> _candidateProfile(
      CandidateProfileRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateProfileLoading();
      final dataState = await _getCandidateProfileUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateProfileSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateProfileFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          final message = dataState.error!.response!.data['message'].toString();

          /// If record not found, return empty message to avoid showing error message
          if (message.toLowerCase() == 'record not found.') {
            yield const CandidateProfileFail(message: '');
          } else {
            yield CandidateProfileFail(message: message);
          }
        }
      }
    });
  }

  //Candidate Update Availability
  Stream<CandidateState> _candidateUpdateAvailability(
      CandidateUpdateAvailabilityRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateUpdateAvailabilityStatusLoading();
      final dataState =
          await _updateCandidateAvailabilityUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateUpdateAvailabilityStatusSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateUpdateAvailabilityStatusFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateUpdateAvailabilityStatusFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Update Employment
  Stream<CandidateState> _candidateUpdateEmployment(
      CandidateUpdateEmlpoymentRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateUpdateEmploymentLoading();
      final dataState =
          await _updateCandidateEmploymentUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateUpdateEmploymentSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateUpdateEmploymentFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateUpdateEmploymentFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Update Family Information
  Stream<CandidateState> _candidateUpdateFamilyInformation(
      CandidateUpdateFamilyInformationRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateUpdateFamilyInformationLoading();
      final dataState =
          await _updateCandidateFamilyInformationUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateUpdateFamilyInformationSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateUpdateFamilyInformationFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateUpdateFamilyInformationFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Update Skill
  Stream<CandidateState> _candidateUpdateSkill(
      CandidateUpdateSkillAndQualificationRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateUpdateSkillQualificationLoading();
      final dataState =
          await _updateCandidateSkillQualificationUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateUpdateSkillQualificationSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateUpdateSkillQualificationFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateUpdateSkillQualificationFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Delete Employment
  Stream<CandidateState> _candidateDeleteEmployment(
      CandidateDeleteEmploymentRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateDeleteEmploymentLoading();
      final dataState =
          await _deleteCandidateEmploymentUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateDeleteEmploymentSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateDeleteEmploymentFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateDeleteEmploymentFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Delete Avatar
  Stream<CandidateState> _candidateDeleteAvatar(
      CandidateDeleteAvatarRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateDeleteAvatarLoading();
      final dataState =
          await _deleteCandidateAvatarUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateDeleteAvatarSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateDeleteAvatarFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateDeleteAvatarFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Forgot Password
  Stream<CandidateState> _candidateForgotPassword(
      CandidateForgotPasswordRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateForgotPasswordLoading();
      final dataState =
          await _createCandidateForgotPasswordUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateForgotPasswordSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateForgotPasswordFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateForgotPasswordFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Reset Password
  Stream<CandidateState> _candidateResetPassword(
      CandidateResetPasswordRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateResetPasswordLoading();
      final dataState =
          await _createCandidateResetPasswordUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateResetPasswordSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateResetPasswordFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateResetPasswordFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Working Preferences
  Stream<CandidateState> _candidateWorkingPreferences(
      CandidateUpdateWorkingPreferencesRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateUpdateWorkingPreferencesLoading();
      final dataState =
          await _createCandidateWorkingPreferenceUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateUpdateWorkingPreferencesSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateUpdateWorkingPreferencesFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateUpdateWorkingPreferencesFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Spotlights
  Stream<CandidateState> _candidateCreateSpotlights(
      CandidateSpotlightsRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateCreateSpotlightsLoading();
      final dataState =
          await _createCandidateSpotlightsUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateCreateSpotlightsSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateCreateSpotlightsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateCreateSpotlightsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate FCM
  Stream<CandidateState> _candidateUpdateFCM(
      CandidateUpdateFCMRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateUpdateFCMLoading();
      final dataState = await _updateCandidateFCMUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateUpdateFCMSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateUpdateFCMFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateUpdateFCMFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Save Search List
  Stream<CandidateState> _candidateSaveSearchList(
      CandidateSaveSearchListRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateSaveSearchListLoading();
      final dataState =
          await _getCandidateSaveSearchUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateSaveSearchListSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateSaveSearchListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateSaveSearchListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Update Save Search
  Stream<CandidateState> _candidateUpdateSaveSearch(
      CandidateUpdateSaveSearchRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateUpdateSaveSearchLoading();
      final dataState =
          await _updateCandidateSaveSearchUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateUpdateSaveSearchSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateUpdateSaveSearchFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateUpdateSaveSearchFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Delete Save Search
  Stream<CandidateState> _candidateDeleteSaveSearch(
      CandidateDeleteSaveSearchRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateDeleteSaveSearchLoading();
      final dataState =
          await _deleteCandidateSaveSearchUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateDeleteSaveSearchSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateDeleteSaveSearchFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateDeleteSaveSearchFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Create Big Data
  Stream<CandidateState> _candidateCreateBigData(
      CandidateCreateBigDataRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateCreateBigDataLoading();
      final dataState =
          await _createCandidateBigDataUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateCreateBigDataSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateCreateBigDataFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateCreateBigDataFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Delete Big Data
  Stream<CandidateState> _candidateDeleteBigData(
      CandidateDeleteBigDataRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateDeleteBigDataLoading();
      final dataState =
          await _deleteCandidateBigDataUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateDeleteBigDataSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateDeleteBigDataFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateDeleteBigDataFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Create Verification
  Stream<CandidateState> _candidateCreateVerification(
      CandidateCreateVerificationRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateCreateVerificationLoading();
      final dataState =
          await _createCandidateVerificationUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateCreateVerificationSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateCreateVerificationFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateCreateVerificationFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Delete Account
  Stream<CandidateState> _candidateDeleteAccount(
      CandidateDeleteAccountRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateDeleteAccountLoading();
      final dataState =
          await _deleteCandidateAccountUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateDeleteAccountSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateDeleteAccountFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateDeleteAccountFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Delete Profile
  Stream<CandidateState> _candidateDeleteProfile(
      CandidateDeleteProfileRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateDeleteProfileLoading();
      final dataState =
          await _deleteCandidateProfileUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateDeleteProfileSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateDeleteProfileFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateDeleteProfileFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Reviews
  Stream<CandidateState> _candidateReviews(
      CandidateReviewsRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateReviewsLoading();
      final dataState = await _getCandidateReviewUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateReviewsSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateReviewsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateReviewsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Reviews
  Stream<CandidateState> _candidateCreateReview(
      CandidateCreateReviewRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateCreateReviewLoading();
      final dataState =
          await _createCandidateReviewUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateCreateReviewSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateCreateReviewFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateCreateReviewFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Reviews
  Stream<CandidateState> _candidateDeleteReview(
      CandidateDeleteReviewRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateDeleteReviewLoading();
      final dataState =
          await _deleteCandidateReviewUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateDeleteReviewSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateDeleteReviewFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateDeleteReviewFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Coin History
  Stream<CandidateState> _candidateCoinHistoryList(
      CandidateCoinHistoryListRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateCoinHistoryListLoading();
      final dataState =
          await _getCandidateCoinHistoryUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateCoinHistoryListSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateCoinHistoryListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateCoinHistoryListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

//Candidate Coin Balance
  Stream<CandidateState> _candidateCoinBalanceList(
      CandidateCoinBalanceListRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateCoinBalanceListLoading();
      final dataState =
          await _getCandidateCoinBalanceUseCase(params: event.params);
      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        if (getData != null) {
          if (getData.data != null) {
            Box box = await Hive.openBox(DBUtils.dbName);
            Map<dynamic, dynamic>? candidateData =
                box.get(DBUtils.candidateTableName);
            Map<String, dynamic> newCandidateData = {};
            if (candidateData != null) {
              for (var element in candidateData.entries) {
                newCandidateData[element.key.toString()] = element.value;
              }
              newCandidateData['p_coin'] =
                  CoinBalanceModel.fromMap(getData.data!).data;
              DBUtils.saveNewData(
                  {'data': newCandidateData}, DBUtils.candidateTableName);
            }
          }
        }
        yield CandidateCoinBalanceListSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateCoinBalanceListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateCoinBalanceListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Refer Friend List
  Stream<CandidateState> _candidateReferFriendList(
      CandidateReferFriendListRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateReferFriendListLoading();
      final dataState =
          await _getCandidateReferFriendUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateReferFriendListSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateReferFriendListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateReferFriendListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Update Account
  Stream<CandidateState> _candidateUpdateAccount(
      CandidateUpdateAccountRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateUpdateAccountLoading();
      final dataState =
          await _updateCandidateAccountUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateUpdateAccountSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateUpdateAccountFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateUpdateAccountFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Employment Sort
  Stream<CandidateState> _candidateEmploymentSort(
      CandidateEmploymentSortRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateEmploymentSortLoading();
      final dataState =
          await _createCandidateEmploymentSortUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateEmploymentSortSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateEmploymentSortFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateEmploymentSortFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Notify Save Search
  Stream<CandidateState> _candidateNotifySaveSearch(
      CandidateNotifySaveSearchRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateNotifySaveSearchLoading();
      final dataState =
          await _updateCandidateSaveSearchNotifyUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateNotifySaveSearchSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateNotifySaveSearchFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateNotifySaveSearchFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Update Shareable Link
  Stream<CandidateState> _candidateUpdateShareableLink(
      CandidateUpdateShareableLinkRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateUpdateShareableLinkLoading();
      final dataState =
          await _updateCandidateShareableLinkUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateUpdateShareableLinkSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateUpdateShareableLinkFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateUpdateShareableLinkFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Check Verified
  Stream<CandidateState> _candidateCheckVerified(
      CandidateCheckVerifiedRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateCheckVerifiedLoading();
      final dataState =
          await _getCandidateCheckVerifiedUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateCheckVerifiedSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateCheckVerifiedFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateCheckVerifiedFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Work Permit
  Stream<CandidateState> _candidateWorkPermit(
      CandidateWorkPermitRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateWorkPermitLoading();
      final dataState =
          await _createCandidateWorkPermitUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        if (getData != null) {
          superPrint(getData.data);
        }
        yield CandidateWorkPermitSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateWorkPermitFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateWorkPermitFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Profile Complaint
  Stream<CandidateState> _candidateProfileComplaint(
      CandidateProfileComplaintRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateProfileComplaintLoading();
      final dataState =
          await _createCandidateComplaintUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateProfileComplaintSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateProfileComplaintFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateProfileComplaintFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Update Configs
  Stream<CandidateState> _candidateUpdateConfigs(
      CandidateUpdateConfigsRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateUpdateConfigsLoading();
      final dataState =
          await _updateCandidateConfigsUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateUpdateConfigsSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateUpdateConfigsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateUpdateConfigsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Exchange Rate
  Stream<CandidateState> _candidateExchangeRate(
      CandidateExchangeRateRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateExchangeRateLoading();
      final dataState =
          await _createCandidateExchangeUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateExchangeRateSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateExchangeRateFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateExchangeRateFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Salary Range Exchange
  Stream<CandidateState> _candidatePHCSalaryRangeExchange(
      CandidatePHCSalaryRangeExchangeRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidatePHCSalaryRangeExchangeLoading();
      final CandidateExchangeRateRequestParams minSalaryRequestParams =
          CandidateExchangeRateRequestParams(
              base: 'PHC',
              target: event.params.targetCurrency,
              baseAmount: event.params.phcSalaryMin);
      final CandidateExchangeRateRequestParams maxSalaryRequestParams =
          CandidateExchangeRateRequestParams(
              base: 'PHC',
              target: event.params.targetCurrency,
              baseAmount: event.params.phcSalaryMax);

      final dataStates = await Future.wait([
        _createCandidateExchangeUseCase(params: minSalaryRequestParams),
        _createCandidateExchangeUseCase(params: maxSalaryRequestParams)
      ]);

      if (dataStates.every((dataState) => dataState is DataSuccess)) {
        final ConvertedSalaryRangeModel convertedSalaryRange =
            ConvertedSalaryRangeModel(
                resultCurrency: event.params.targetCurrency,
                convertedMin: double.parse(dataStates[0]
                        .data!
                        .data!['data']['converted_amount']
                        .toString())
                    .ceil(),
                convertedMax: double.parse(dataStates[1]
                        .data!
                        .data!['data']['converted_amount']
                        .toString())
                    .ceil());
        yield CandidatePHCSalaryRangeExchangeSuccess(
            convertedSalaryRange: convertedSalaryRange);
      } else if (dataStates.any((dataState) => dataState is DataFailed)) {
        final errorDataState =
            dataStates.firstWhere((dataState) => dataState is DataFailed);
        if (errorDataState.error!.response == null) {
          yield const CandidatePHCSalaryRangeExchangeFail(message: 'retry');
        } else if (errorDataState.error!.response!.statusCode! > 399) {
          yield CandidatePHCSalaryRangeExchangeFail(
              message:
                  errorDataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Offer Action
  Stream<CandidateState> _candidateOfferAction(
      CandidateOfferActionRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateOfferActionLoading();
      final dataState =
          await _createCandidateOfferActionUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield CandidateOfferActionSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateOfferActionFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateOfferActionFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }
}
