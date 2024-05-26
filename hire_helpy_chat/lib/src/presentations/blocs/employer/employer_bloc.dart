part of blocs;

class EmployerBloc extends BlocWithState<EmployerEvent, EmployerState> {
  // ignore: non_constant_identifier_names
  final CreateEmployerLoginUseCase _createEmployerLoginUseCase;
  final CreateEmployerContactUsUseCase _createEmployerContactUsCase;
  final CreateEmployerRegisterUseCase _createEmployerRegisterUseCase;
  final CreateEmployerSocialLoginUseCase _createEmployerSocialLoginUseCase;
  final CreateEmployerSocialRegisterUseCase
      _createEmployerSocialRegisterUseCase;
  final GetEmployerLoginOutUseCase _getEmployerLoginOutUseCase;
  final GetEmployerConfigsUseCase _getEmployerConfigsUseCase;
  final GetEmployerStarListUseCase _getEmployerStarListUseCase;
  final CreateEmployerStarListUseCase _createEmployerStarListUseCase;
  final RemoveEmployerStarListUseCase _removeEmployerStarListUseCase;
  final CreateEmployerAboutUseCase _createEmployerAboutUseCase;
  final CreateEmployerAvatarUseCase _createEmployerAvatarUseCase;
  final DeleteEmployerAvatarUseCase _deleteEmployerAvatarUseCase;
  final GetEmployerAvailabilityUseCase _getEmployerAvailabilityUseCase;
  final GetEmployerProfileUseCase _getEmployerProfileUseCase;
  final UpdateEmployerAvailabilityUseCase _updateEmployerAvailabilityUseCase;
  final UpdateEmployerFamilyInformationUseCase
      _updateEmployerFamilyInformationUseCase;
  final UpdateEmployerLanguageUseCase _updateEmployerLanguageUseCase;
  final CreateEmployerWorkingPreferenceUseCase
      _createEmployerWorkingPreferenceUseCase;
  final CreateEmployerForgotPasswordUseCase
      _createEmployerForgotPasswordUseCase;
  final CreateEmployerResetPasswordUseCase _createEmployerResetPasswordUseCase;
  final CreateEmployerSpotlightsUseCase _createEmployerSpotlightsUseCase;
  final UpdateEmployerFCMUseCase _updateEmployerFCMUseCase;
  final GetEmployerSaveSearchUseCase _getEmployerSaveSearchUseCase;
  final UpdateEmployerSaveSearchUseCase _updateEmployerSaveSearchUseCase;
  final DeleteEmployerSaveSearchUseCase _deleteEmployerSaveSearchUseCase;
  final CreateEmployerOfferUseCase _createEmployerOfferUseCase;
  final DeleteEmployerOfferUseCase _deleteEmployerOfferUseCase;
  final CreateEmployerVerificationUseCase _createEmployerVerificationUseCase;
  final DeleteEmployerAccountUseCase _deleteEmployerAccountUseCase;
  final DeleteEmployerProfileUseCase _deleteEmployerProfileUseCase;
  final GetEmployerReviewsUseCase _getEmployerReviewUseCase;
  final CreateEmployerReviewsUseCase _createEmployerReviewUseCase;
  final DeleteEmployerReviewsUseCase _deleteEmployerReviewUseCase;
  final GetEmployerCoinHistoryUseCase _getEmployerCoinHistoryUseCase;
  final GetEmployerCoinBalanceUseCase _getEmployerCoinBalanceUseCase;
  final GetEmployerReferFriendUseCase _getEmployerReferFriendUseCase;
  final UpdateEmployerAccountUseCase _updateEmployerAccountUseCase;
  final UpdateEmployerSaveSearchNotifyUseCase
      _updateEmployerSaveSearchNotifyUseCase;
  final UpdateEmployerShareableLinkUseCase _updateEmployerShareableLinkUseCase;
  final GetEmployerCheckVerifiedUseCase _getEmployerCheckVerifiedUseCase;
  final CreateEmployerHiringUseCase _createEmployerHiringUseCase;
  final CreateEmployerComplaintUseCase _createEmployerComplaintUseCase;
  final UpdateEmployerConfigsUseCase _updateEmployerConfigsUseCase;
  final CreateEmployerExchangeUseCase _createEmployerExchangeUseCase;

  EmployerBloc(
      this._createEmployerLoginUseCase,
      this._createEmployerContactUsCase,
      this._createEmployerRegisterUseCase,
      this._createEmployerSocialLoginUseCase,
      this._createEmployerSocialRegisterUseCase,
      this._getEmployerLoginOutUseCase,
      this._getEmployerConfigsUseCase,
      this._getEmployerStarListUseCase,
      this._createEmployerStarListUseCase,
      this._removeEmployerStarListUseCase,
      this._createEmployerAboutUseCase,
      this._createEmployerAvatarUseCase,
      this._deleteEmployerAvatarUseCase,
      this._getEmployerAvailabilityUseCase,
      this._getEmployerProfileUseCase,
      this._updateEmployerAvailabilityUseCase,
      this._updateEmployerFamilyInformationUseCase,
      this._updateEmployerLanguageUseCase,
      this._createEmployerForgotPasswordUseCase,
      this._createEmployerResetPasswordUseCase,
      this._createEmployerSpotlightsUseCase,
      this._createEmployerWorkingPreferenceUseCase,
      this._updateEmployerFCMUseCase,
      this._getEmployerSaveSearchUseCase,
      this._deleteEmployerSaveSearchUseCase,
      this._updateEmployerSaveSearchUseCase,
      this._createEmployerOfferUseCase,
      this._deleteEmployerOfferUseCase,
      this._createEmployerVerificationUseCase,
      this._deleteEmployerAccountUseCase,
      this._deleteEmployerProfileUseCase,
      this._getEmployerReviewUseCase,
      this._createEmployerReviewUseCase,
      this._deleteEmployerReviewUseCase,
      this._getEmployerCoinHistoryUseCase,
      this._getEmployerCoinBalanceUseCase,
      this._getEmployerReferFriendUseCase,
      this._updateEmployerAccountUseCase,
      this._updateEmployerSaveSearchNotifyUseCase,
      this._updateEmployerShareableLinkUseCase,
      this._getEmployerCheckVerifiedUseCase,
      this._createEmployerHiringUseCase,
      this._createEmployerComplaintUseCase,
      this._updateEmployerConfigsUseCase,
      this._createEmployerExchangeUseCase)
      : super(EmployerInitialState());

  @override
  Stream<EmployerState> mapEventToState(EmployerEvent event) async* {
    if (event is InitializeEmployerEvent) {
      yield* _getInitializeEmployer(event);
    }

    if (event is EmployerLoginRequested) yield* _employerLogin(event);

    if (event is EmployerRegisterRequested) yield* _employerRegister(event);

    if (event is EmployerSocialLoginRequested) {
      yield* _employerSocialLogin(event);
    }

    if (event is EmployerSocialRegisterRequested) {
      yield* _employerSocialRegister(event);
    }

    if (event is EmployerLogoutRequested) yield* _employerLogout(event);

    if (event is EmployerConfigsRequested) yield* _employerConfigs(event);

    if (event is EmployerStarListRequested) yield* _employerStarList(event);

    if (event is EmployerStarListAddRequested) {
      yield* _employerStarListAdd(event);
    }

    if (event is EmployerStarListRemoveRequested) {
      yield* _employerStarListRemove(event);
    }

    if (event is EmployerContactUsRequested) yield* _employerContactUs(event);

    if (event is EmployerCreateAboutRequested) {
      yield* _employerCreateAbout(event);
    }

    if (event is EmployerCreateAvatarRequested) {
      yield* _employerCreateAvatar(event);
    }
    if (event is EmployerDeleteAvatarRequested) {
      yield* _employerDeleteAvatar(event);
    }

    if (event is EmployerAvailabilityRequested) {
      yield* _employerAvailabilty(event);
    }
    if (event is EmployerProfileRequested) yield* _employerProfile(event);

    if (event is EmployerUpdateAvailabilityRequested) {
      yield* _employerUpdateAvailability(event);
    }

    if (event is EmployerUpdateFamilyInformationRequested) {
      yield* _employerUpdateFamilyInformation(event);
    }

    if (event is EmployerUpdateLanguageRequested) {
      yield* _employerUpdateLanguage(event);
    }

    if (event is EmployerUpdateAppLanguage) {
      yield* _employerUpdateAppLanguage(event);
    }

    if (event is EmployerUpdateAppLocale) {
      yield* _employerUpdateAppLocale(event);
    }

    if (event is EmployerResetPasswordRequested) {
      yield* _employerResetPassword(event);
    }
    if (event is EmployerForgotPasswordRequested) {
      yield* _employerForgotPassword(event);
    }

    if (event is EmployerUpdateWorkingPreferencesRequested) {
      yield* _employerWorkingPreferences(event);
    }

    if (event is EmployerSpotlightsRequested) {
      yield* _employerCreateSpotlights(event);
    }

    if (event is EmployerUpdateFCMRequested) {
      yield* _employerUpdateFCM(event);
    }

    if (event is EmployerSaveSearchListRequested) {
      yield* _employerSaveSearchList(event);
    }

    if (event is EmployerUpdateSaveSearchRequested) {
      yield* _employerUpdateSaveSearch(event);
    }

    if (event is EmployerDeleteSaveSearchRequested) {
      yield* _employerDeleteSaveSearch(event);
    }

    if (event is EmployerCreateOfferRequested) {
      yield* _employerCreateOffer(event);
    }

    if (event is EmployerDeleteOfferRequested) {
      yield* _employerDeleteOffer(event);
    }

    if (event is EmployerCreateVerificationRequested) {
      yield* _employerCreateVerification(event);
    }

    if (event is EmployerDeleteAccountRequested) {
      yield* _employerDeleteAccount(event);
    }

    if (event is EmployerDeleteProfileRequested) {
      yield* _employerDeleteProfile(event);
    }

    if (event is EmployerReviewsRequested) {
      yield* _employerReviews(event);
    }

    if (event is EmployerCreateReviewRequested) {
      yield* _employerCreateReview(event);
    }

    if (event is EmployerDeleteReviewRequested) {
      yield* _employerDeleteReview(event);
    }

    if (event is EmployerVoucherHistoryListRequested) {
      yield* _employerCoinHistoryList(event);
    }

    if (event is EmployerCoinBalanceRequested) {
      yield* _employerCoinBalance(event);
    }

    if (event is EmployerReferFriendListRequested) {
      yield* _employerReferFriendList(event);
    }

    if (event is EmployerUpdateAccountRequested) {
      yield* _employerUpdateAccount(event);
    }

    if (event is EmployerNotifySaveSearchRequested) {
      yield* _employerNotifySaveSearch(event);
    }

    if (event is EmployerUpdateShareableLinkRequested) {
      yield* _employerUpdateShareableLink(event);
    }

    if (event is EmployerCheckVerifiedRequested) {
      yield* _employerCheckVerified(event);
    }

    if (event is EmployerHiringRequested) {
      yield* _employerHiring(event);
    }

    if (event is EmployerProfileComplaintRequested) {
      yield* _employerProfileComplaint(event);
    }

    if (event is EmployerUpdateConfigsRequested) {
      yield* _employerUpdateConfigs(event);
    }

    if (event is EmployerExchangeRateRequested) {
      yield* _employerExchangeRate(event);
    }

    if (event is EmployerPHCSalaryRangeExchangeRequested) {
      yield* _employerPHCSalaryRangeExchange(event);
    }
  }

  Stream<EmployerState> _getInitializeEmployer(
      InitializeEmployerEvent event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerInitialState();
    });
  }

  //Employer ContactUs
  Stream<EmployerState> _employerContactUs(
      EmployerContactUsRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerContactUsLoading();
      final dataState = await _createEmployerContactUsCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerContactUsSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerContactUsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerContactUsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Login
  Stream<EmployerState> _employerLogin(EmployerLoginRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerLoginLoading();
      final dataState = await _createEmployerLoginUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerLoginSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response!.statusCode! == 401) {
          yield EmployerLoginFail(
              message: json
                  .encode(dataState.error!.response!.data['errors']['status']));
        } else if (dataState.error!.response == null) {
          yield const EmployerLoginFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerLoginFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Register
  Stream<EmployerState> _employerRegister(
      EmployerRegisterRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerRegisterLoading();
      final dataState = await _createEmployerRegisterUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerRegisterSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerRegisterFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerRegisterFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Social Login
  Stream<EmployerState> _employerSocialLogin(
      EmployerSocialLoginRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerSocialLoginLoading();
      final dataState = await _createEmployerSocialLoginUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerSocialLoginSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response!.statusCode! == 401) {
          yield EmployerSocialLoginFail(
              message: json.encode(dataState.error!.response!.data));
        } else if (dataState.error!.response == null) {
          yield const EmployerSocialLoginFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerSocialLoginFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Social Register
  Stream<EmployerState> _employerSocialRegister(
      EmployerSocialRegisterRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerSocialRegisterLoading();
      final dataState = await _createEmployerSocialRegisterUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerSocialRegisterSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerSocialRegisterFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerSocialRegisterFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Logout
  Stream<EmployerState> _employerLogout(EmployerLogoutRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerLogoutLoading();
      final dataState = await _getEmployerLoginOutUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerLogoutSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerLogoutFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerLogoutFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Configs
  Stream<EmployerState> _employerConfigs(
      EmployerConfigsRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerConfigsLoading();
      final dataState = await _getEmployerConfigsUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerConfigsSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerConfigsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerConfigsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer StarList
  Stream<EmployerState> _employerStarList(
      EmployerStarListRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerStarListLoading();
      final dataState = await _getEmployerStarListUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerStarListSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerStarListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerStarListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer StarListADD
  Stream<EmployerState> _employerStarListAdd(
      EmployerStarListAddRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerStarListAddLoading();
      final dataState = await _createEmployerStarListUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerStarListAddSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerStarListAddFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerStarListAddFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer StarList Remove
  Stream<EmployerState> _employerStarListRemove(
      EmployerStarListRemoveRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerStarListAddLoading();
      final dataState = await _removeEmployerStarListUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerStarListRemoveSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerStarListRemoveFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerStarListRemoveFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Create About
  Stream<EmployerState> _employerCreateAbout(
      EmployerCreateAboutRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerCreateAboutStepLoading();
      final dataState = await _createEmployerAboutUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerCreateAboutStepSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerCreateAboutStepFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerCreateAboutStepFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Create Avatar
  Stream<EmployerState> _employerCreateAvatar(
      EmployerCreateAvatarRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerCreateAvatarLoading();
      final dataState =
          await _createEmployerAvatarUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerCreateAvatarSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerCreateAvatarFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerCreateAvatarFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Availabilty
  Stream<EmployerState> _employerAvailabilty(
      EmployerAvailabilityRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerAvailabilityStatusLoading();
      final dataState =
          await _getEmployerAvailabilityUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerAvailabilityStatusSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerAvailabilityStatusFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerAvailabilityStatusFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Profile
  Stream<EmployerState> _employerProfile(
      EmployerProfileRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerProfileLoading();
      final dataState = await _getEmployerProfileUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerProfileSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerProfileFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerProfileFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Update Availability
  Stream<EmployerState> _employerUpdateAvailability(
      EmployerUpdateAvailabilityRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerUpdateAvailabilityStatusLoading();
      final dataState =
          await _updateEmployerAvailabilityUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerUpdateAvailabilityStatusSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerProfileFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerUpdateAvailabilityStatusFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Update Family Information
  Stream<EmployerState> _employerUpdateFamilyInformation(
      EmployerUpdateFamilyInformationRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerUpdateFamilyInformationLoading();
      final dataState =
          await _updateEmployerFamilyInformationUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerUpdateFamilyInformationSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerUpdateFamilyInformationFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerUpdateFamilyInformationFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  Stream<EmployerState> _employerUpdateLanguage(
      EmployerUpdateLanguageRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerUpdateLanguageLoading();
      final dataState =
          await _updateEmployerLanguageUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerUpdateLanguageSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerUpdateLanguageFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerUpdateLanguageFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  Stream<EmployerState> _employerUpdateAppLanguage(
      EmployerUpdateAppLanguage event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerUpdateAppLanguageSuccess(language: event.language);
    });
  }

  Stream<EmployerState> _employerUpdateAppLocale(
      EmployerUpdateAppLocale event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerUpdateAppLocaleSuccess(appLocale: event.appLocale);
    });
  }

  //Employer Delete Avatar
  Stream<EmployerState> _employerDeleteAvatar(
      EmployerDeleteAvatarRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerDeleteAvatarLoading();
      final dataState =
          await _deleteEmployerAvatarUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerDeleteAvatarSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerDeleteAvatarFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerDeleteAvatarFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Forgot Password
  Stream<EmployerState> _employerForgotPassword(
      EmployerForgotPasswordRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerForgotPasswordLoading();
      final dataState =
          await _createEmployerForgotPasswordUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerForgotPasswordSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerForgotPasswordFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerForgotPasswordFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Reset Password
  Stream<EmployerState> _employerResetPassword(
      EmployerResetPasswordRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerResetPasswordLoading();
      final dataState =
          await _createEmployerResetPasswordUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerResetPasswordSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerResetPasswordFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerResetPasswordFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Working Preferences
  Stream<EmployerState> _employerWorkingPreferences(
      EmployerUpdateWorkingPreferencesRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerUpdateWorkingPreferencesLoading();
      final dataState =
          await _createEmployerWorkingPreferenceUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerUpdateWorkingPreferencesSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerUpdateWorkingPreferencesFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerUpdateWorkingPreferencesFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Spotlights
  Stream<EmployerState> _employerCreateSpotlights(
      EmployerSpotlightsRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerCreateSpotlightsLoading();
      final dataState =
          await _createEmployerSpotlightsUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerCreateSpotlightsSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerCreateSpotlightsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerCreateSpotlightsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer FCM
  Stream<EmployerState> _employerUpdateFCM(
      EmployerUpdateFCMRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerUpdateFCMLoading();
      final dataState = await _updateEmployerFCMUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerUpdateFCMSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerUpdateFCMFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerUpdateFCMFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Save Search List
  Stream<EmployerState> _employerSaveSearchList(
      EmployerSaveSearchListRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerSaveSearchListLoading();
      final dataState =
          await _getEmployerSaveSearchUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerSaveSearchListSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerSaveSearchListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerSaveSearchListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Update Save Search
  Stream<EmployerState> _employerUpdateSaveSearch(
      EmployerUpdateSaveSearchRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerUpdateSaveSearchLoading();
      final dataState =
          await _updateEmployerSaveSearchUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerUpdateSaveSearchSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerUpdateSaveSearchFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerUpdateSaveSearchFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Delete Save Search
  Stream<EmployerState> _employerDeleteSaveSearch(
      EmployerDeleteSaveSearchRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerDeleteSaveSearchLoading();
      final dataState =
          await _deleteEmployerSaveSearchUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerDeleteSaveSearchSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerDeleteSaveSearchFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerDeleteSaveSearchFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Create Offer
  Stream<EmployerState> _employerCreateOffer(
      EmployerCreateOfferRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerCreatOfferLoading();
      final dataState = await _createEmployerOfferUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerCreateOfferSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerCreateOfferFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerCreateOfferFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Delete Offer
  Stream<EmployerState> _employerDeleteOffer(
      EmployerDeleteOfferRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerDeleteOfferLoading();
      final dataState = await _deleteEmployerOfferUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerDeleteOfferSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerDeleteOfferFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerDeleteOfferFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Create Verification
  Stream<EmployerState> _employerCreateVerification(
      EmployerCreateVerificationRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerCreateVerificationLoading();
      final dataState =
          await _createEmployerVerificationUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerCreateVerificationSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerCreateVerificationFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerCreateVerificationFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Delete Account
  Stream<EmployerState> _employerDeleteAccount(
      EmployerDeleteAccountRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerDeleteAccountLoading();
      final dataState =
          await _deleteEmployerAccountUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerDeleteAccountSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerDeleteAccountFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerDeleteAccountFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Delete Profile
  Stream<EmployerState> _employerDeleteProfile(
      EmployerDeleteProfileRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerDeleteProfileLoading();
      final dataState =
          await _deleteEmployerProfileUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerDeleteProfileSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerDeleteProfileFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerDeleteProfileFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Reviews
  Stream<EmployerState> _employerReviews(
      EmployerReviewsRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerReviewsLoading();
      final dataState = await _getEmployerReviewUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerReviewsSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerReviewsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerReviewsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Reviews
  Stream<EmployerState> _employerCreateReview(
      EmployerCreateReviewRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerCreateReviewLoading();
      final dataState =
          await _createEmployerReviewUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerCreateReviewSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerCreateReviewFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerCreateReviewFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Reviews
  Stream<EmployerState> _employerDeleteReview(
      EmployerDeleteReviewRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerDeleteReviewLoading();
      final dataState =
          await _deleteEmployerReviewUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerDeleteReviewSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerDeleteReviewFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerDeleteReviewFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Coin History
  Stream<EmployerState> _employerCoinHistoryList(
      EmployerVoucherHistoryListRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerCoinHistoryListLoading();
      final dataState =
          await _getEmployerCoinHistoryUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerCoinHistoryListSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerCoinHistoryListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerCoinHistoryListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Coin balance
  Stream<EmployerState> _employerCoinBalance(
      EmployerCoinBalanceRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerCoinBalanceLoading();
      final dataState =
          await _getEmployerCoinBalanceUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerCoinBalanceSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerCoinBalanceFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerCoinBalanceFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Refer Friend List
  Stream<EmployerState> _employerReferFriendList(
      EmployerReferFriendListRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerReferFriendListLoading();
      final dataState =
          await _getEmployerReferFriendUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerReferFriendListSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerReferFriendListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerReferFriendListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Update Account
  Stream<EmployerState> _employerUpdateAccount(
      EmployerUpdateAccountRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerUpdateAccountLoading();
      final dataState =
          await _updateEmployerAccountUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerUpdateAccountSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerUpdateAccountFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerUpdateAccountFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Notify Save Search
  Stream<EmployerState> _employerNotifySaveSearch(
      EmployerNotifySaveSearchRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerNotifySaveSearchLoading();
      final dataState =
          await _updateEmployerSaveSearchNotifyUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerNotifySaveSearchSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerNotifySaveSearchFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerNotifySaveSearchFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Update Shareable Link
  Stream<EmployerState> _employerUpdateShareableLink(
      EmployerUpdateShareableLinkRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerUpdateShareableLinkLoading();
      final dataState =
          await _updateEmployerShareableLinkUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerUpdateShareableLinkSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerUpdateShareableLinkFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerUpdateShareableLinkFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Check Verified
  Stream<EmployerState> _employerCheckVerified(
      EmployerCheckVerifiedRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerCheckVerifiedLoading();
      final dataState =
          await _getEmployerCheckVerifiedUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerCheckVerifiedSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerCheckVerifiedFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerCheckVerifiedFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Hiring
  Stream<EmployerState> _employerHiring(EmployerHiringRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerHiringLoading();
      final dataState =
          await _createEmployerHiringUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerHiringSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerHiringFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerHiringFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Profile Complaint
  Stream<EmployerState> _employerProfileComplaint(
      EmployerProfileComplaintRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerProfileComplaintLoading();
      final dataState =
          await _createEmployerComplaintUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerProfileComplaintSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerProfileComplaintFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerProfileComplaintFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Update Configs
  Stream<EmployerState> _employerUpdateConfigs(
      EmployerUpdateConfigsRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerUpdateConfigsLoading();
      final dataState =
          await _updateEmployerConfigsUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerUpdateConfigsSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerUpdateConfigsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerUpdateConfigsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Exchange Rate
  Stream<EmployerState> _employerExchangeRate(
      EmployerExchangeRateRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerExchangeRateLoading();
      final dataState =
          await _createEmployerExchangeUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield EmployerExchangeRateSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerExchangeRateFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerExchangeRateFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Salary Range Exchange
  Stream<EmployerState> _employerPHCSalaryRangeExchange(
      EmployerPHCSalaryRangeExchangeRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerPHCSalaryRangeExchangeLoading();
      final EmployerExchangeRateRequestParams minSalaryRequestParams =
          EmployerExchangeRateRequestParams(
              base: 'PHC',
              target: event.params.targetCurrency,
              baseAmount: event.params.phcSalaryMin);
      final EmployerExchangeRateRequestParams maxSalaryRequestParams =
          EmployerExchangeRateRequestParams(
              base: 'PHC',
              target: event.params.targetCurrency,
              baseAmount: event.params.phcSalaryMax);

      final dataStates = await Future.wait([
        _createEmployerExchangeUseCase(params: minSalaryRequestParams),
        _createEmployerExchangeUseCase(params: maxSalaryRequestParams)
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
        yield EmployerPHCSalaryRangeExchangeSuccess(
            convertedSalaryRange: convertedSalaryRange);
      } else if (dataStates.any((dataState) => dataState is DataFailed)) {
        final errorDataState =
            dataStates.firstWhere((dataState) => dataState is DataFailed);
        if (errorDataState.error!.response == null) {
          yield const EmployerPHCSalaryRangeExchangeFail(message: 'retry');
        } else if (errorDataState.error!.response!.statusCode! > 399) {
          yield EmployerPHCSalaryRangeExchangeFail(
              message:
                  errorDataState.error!.response!.data['message'].toString());
        }
      }
    });
  }
}
