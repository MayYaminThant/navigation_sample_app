part of blocs;

abstract class EmployerEvent extends Equatable {
  const EmployerEvent();

  @override
  List<Object> get props => [];
}

class InitializeEmployerEvent extends EmployerEvent {
  @override
  String toString() => "InitializePageEvent";
}

//Employer Login
class EmployerLoginRequested extends EmployerEvent {
  final EmployerLoginRequestParams? params;

  const EmployerLoginRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Register
class EmployerRegisterRequested extends EmployerEvent {
  final EmployerRegisterRequestParams? params;

  const EmployerRegisterRequested({this.params});
  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Social Login
class EmployerSocialLoginRequested extends EmployerEvent {
  final EmployerSocialLoginRequestParams? params;

  const EmployerSocialLoginRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Social Register
class EmployerSocialRegisterRequested extends EmployerEvent {
  final EmployerSocialRegisterRequestParams? params;

  const EmployerSocialRegisterRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Logout
class EmployerLogoutRequested extends EmployerEvent {
  final EmployerLogoutRequestParams? params;

  const EmployerLogoutRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Contact Us
class EmployerContactUsRequested extends EmployerEvent {
  final EmployerContactUsRequestParams? params;

  const EmployerContactUsRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Configs
class EmployerConfigsRequested extends EmployerEvent {
  final EmployerConfigsRequestParams? params;
  const EmployerConfigsRequested({this.params});

  @override
  List<Object> get props => [];
}

//Employer Countries
class EmployerCountriesRequested extends EmployerEvent {
  const EmployerCountriesRequested();

  @override
  List<Object> get props => [];
}

//Employer Genders
class EmployerGendersRequested extends EmployerEvent {
  const EmployerGendersRequested();

  @override
  List<Object> get props => [];
}

//Employer Language Types
class EmployerLanguageTypesRequested extends EmployerEvent {
  const EmployerLanguageTypesRequested();

  @override
  List<Object> get props => [];
}

//Employer Religions

class EmployerReligionsRequested extends EmployerEvent {
  const EmployerReligionsRequested();

  @override
  List<Object> get props => [];
}

//Employer Family Types
class EmployerFamilyTypesRequested extends EmployerEvent {
  const EmployerFamilyTypesRequested();
  @override
  List<Object> get props => [];
}

//Employer Academic Qualification Type
class EmployerAcademicQualificationTypeRequested extends EmployerEvent {
  const EmployerAcademicQualificationTypeRequested();
  @override
  List<Object> get props => [];
}

//Employer Availability Status
class EmployerAvailabilityStatusRequested extends EmployerEvent {
  const EmployerAvailabilityStatusRequested();
  @override
  List<Object> get props => [];
}

//Employer Update Availability Status
class EmployerUpdateAvailabilityStatusRequested extends EmployerEvent {
  final EmployerLogoutRequestParams? params;
  const EmployerUpdateAvailabilityStatusRequested({this.params});
  @override
  List<Object> get props => [params!];
}

//Employer Create About
class EmployerCreateAboutRequested extends EmployerEvent {
  final EmployerCreateAboutRequestParams? params;
  const EmployerCreateAboutRequested({this.params});
  @override
  List<Object> get props => [params!];
}

//Employer Create Employment
class EmployerCreateEmploymentRequested extends EmployerEvent {
  final EmployerCreateEmploymentRequestParams? params;
  const EmployerCreateEmploymentRequested({this.params});
  @override
  List<Object> get props => [params!];
}

//Employer Create Avatar
class EmployerCreateAvatarRequested extends EmployerEvent {
  final EmployerCreateAvatarRequestParams? params;
  const EmployerCreateAvatarRequested({this.params});
  @override
  List<Object> get props => [params!];
}

//Employer Delete Employment
class EmployerDeleteEmploymentRequested extends EmployerEvent {
  final EmployerDeleteEmploymentRequestParams? params;
  const EmployerDeleteEmploymentRequested({this.params});
  @override
  List<Object> get props => [params!];
}

//Employer Delete Avatar
class EmployerDeleteAvatarRequested extends EmployerEvent {
  final EmployerDeleteAvatarRequestParams? params;
  const EmployerDeleteAvatarRequested({this.params});
  @override
  List<Object> get props => [params!];
}

//Employer Availability
class EmployerAvailabilityRequested extends EmployerEvent {
  final EmployerRequestParams? params;
  const EmployerAvailabilityRequested({this.params});
  @override
  List<Object> get props => [params!];
}

//Employer Employment
class EmployerEmploymentRequested extends EmployerEvent {
  final EmployerRequestParams? params;
  const EmployerEmploymentRequested({this.params});
  @override
  List<Object> get props => [params!];
}

//Employer Profile
class EmployerProfileRequested extends EmployerEvent {
  final EmployerRequestParams? params;
  const EmployerProfileRequested({this.params});
  @override
  List<Object> get props => [params!];
}

//Employer Update Availability Status
class EmployerUpdateAvailabilityRequested extends EmployerEvent {
  final EmployerUpdateAvailabilityStatusRequestParams? params;
  const EmployerUpdateAvailabilityRequested({this.params});
  @override
  List<Object> get props => [params!];
}

//Employer Update Emlpoyment
class EmployerUpdateEmlpoymentRequested extends EmployerEvent {
  final EmployerUpdateEmploymentRequestParams? params;
  const EmployerUpdateEmlpoymentRequested({this.params});
  @override
  List<Object> get props => [params!];
}

//Employer Update Family Information
class EmployerUpdateFamilyInformationRequested extends EmployerEvent {
  final EmployerUpdateFamilyStatusRequestParams? params;
  const EmployerUpdateFamilyInformationRequested({this.params});
  @override
  List<Object> get props => [params!];
}

//Employer Update Language
class EmployerUpdateLanguageRequested extends EmployerEvent {
  final EmployerUpdateLanguageParams? params;
  const EmployerUpdateLanguageRequested({this.params});
  @override
  List<Object> get props => [params!];
}

//Employer Update App Language & Locale
class EmployerUpdateAppLanguage extends EmployerEvent {
  final String language;
  const EmployerUpdateAppLanguage({required this.language});
}

class EmployerUpdateAppLocale extends EmployerEvent {
  final String appLocale;
  const EmployerUpdateAppLocale({required this.appLocale});
}

//Employer StarList
class EmployerStarListRequested extends EmployerEvent {
  final EmployerStarListRequestParams? params;

  const EmployerStarListRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer StarList Add
class EmployerStarListAddRequested extends EmployerEvent {
  final EmployerStarListAddRequestParams? params;

  const EmployerStarListAddRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer StarList Remove
class EmployerStarListRemoveRequested extends EmployerEvent {
  final EmployerStarListRemoveRequestParams? params;

  const EmployerStarListRemoveRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Forgot Password
class EmployerForgotPasswordRequested extends EmployerEvent {
  final EmployerForgotPasswordRequestParams? params;

  const EmployerForgotPasswordRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Reset Password
class EmployerResetPasswordRequested extends EmployerEvent {
  final EmployerResetPasswordRequestParams? params;

  const EmployerResetPasswordRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Spotlights
class EmployerSpotlightsRequested extends EmployerEvent {
  final EmployerSpotlightsRequestParams? params;

  const EmployerSpotlightsRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Working Preferences
class EmployerUpdateWorkingPreferencesRequested extends EmployerEvent {
  final EmployerUpdateWorkingPreferenceRequestParams? params;

  const EmployerUpdateWorkingPreferencesRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer FCM
class EmployerUpdateFCMRequested extends EmployerEvent {
  final EmployerFCMRequestParams? params;

  const EmployerUpdateFCMRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Save Search List
class EmployerSaveSearchListRequested extends EmployerEvent {
  final EmployerSaveSearchRequestParams? params;

  const EmployerSaveSearchListRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Update Save Search
class EmployerUpdateSaveSearchRequested extends EmployerEvent {
  final EmployerUpdateSaveSearchRequestParams? params;

  const EmployerUpdateSaveSearchRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Delete Save Search
class EmployerDeleteSaveSearchRequested extends EmployerEvent {
  final EmployerDeleteSaveSearchRequestParams? params;

  const EmployerDeleteSaveSearchRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Creaate Offer
class EmployerCreateOfferRequested extends EmployerEvent {
  final EmployerCreateOfferRequestParams? params;

  const EmployerCreateOfferRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Delete Offer
class EmployerDeleteOfferRequested extends EmployerEvent {
  final EmployerDeleteOfferRequestParams? params;

  const EmployerDeleteOfferRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Delete Account
class EmployerDeleteAccountRequested extends EmployerEvent {
  final EmployerDeleteAccountRequestParams? params;

  const EmployerDeleteAccountRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Delete Profile
class EmployerDeleteProfileRequested extends EmployerEvent {
  final EmployerDeleteProfileRequestParams? params;

  const EmployerDeleteProfileRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Create Verification
class EmployerCreateVerificationRequested extends EmployerEvent {
  final EmployerUpdateVerificationRequestParams? params;

  const EmployerCreateVerificationRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Get Reviews
class EmployerReviewsRequested extends EmployerEvent {
  final EmployerReviewsRequestParams? params;

  const EmployerReviewsRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Create Review
class EmployerCreateReviewRequested extends EmployerEvent {
  final EmployerCreateReviewsRequestParams? params;

  const EmployerCreateReviewRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Delete Review
class EmployerDeleteReviewRequested extends EmployerEvent {
  final EmployerDeleteReviewsRequestParams? params;

  const EmployerDeleteReviewRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Voucher History
class EmployerVoucherHistoryListRequested extends EmployerEvent {
  final EmployerListVoucherHistoryRequestParams? params;

  const EmployerVoucherHistoryListRequested({this.params});
  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Coin Balance
class EmployerCoinBalanceRequested extends EmployerEvent {
  final EmployerCoinBalanceRequestParams? params;

  const EmployerCoinBalanceRequested({this.params});
  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Refer Friend List
class EmployerReferFriendListRequested extends EmployerEvent {
  final EmployerReferFriendRequestParams? params;

  const EmployerReferFriendListRequested({this.params});
  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Update Account
class EmployerUpdateAccountRequested extends EmployerEvent {
  final EmployerUpdateAccountRequestParams? params;

  const EmployerUpdateAccountRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Employment Sort
class EmployerEmploymentSortRequested extends EmployerEvent {
  final EmployerCreateEmploymentSortRequestParams? params;

  const EmployerEmploymentSortRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Save Search Notify
class EmployerNotifySaveSearchRequested extends EmployerEvent {
  final EmployerNotifySaveSearchRequestParams? params;

  const EmployerNotifySaveSearchRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Update Shareable Link
class EmployerUpdateShareableLinkRequested extends EmployerEvent {
  final EmployerUpdateShareableLinkRequestParams? params;

  const EmployerUpdateShareableLinkRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Check Verified
class EmployerCheckVerifiedRequested extends EmployerEvent {
  final EmployerCheckVerifiedRequestParams? params;

  const EmployerCheckVerifiedRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Hiring
class EmployerHiringRequested extends EmployerEvent {
  final EmployerHiringRequestParams? params;

  const EmployerHiringRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Profile Complaint
class EmployerProfileComplaintRequested extends EmployerEvent {
  final EmployerProfileComplaintRequestParams? params;

  const EmployerProfileComplaintRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Update Configs
class EmployerUpdateConfigsRequested extends EmployerEvent {
  final EmployerUpdateConfigsRequestParams? params;

  const EmployerUpdateConfigsRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Empliyer Exchange Rate
class EmployerExchangeRateRequested extends EmployerEvent {
  final EmployerExchangeRateRequestParams? params;

  const EmployerExchangeRateRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}


//Salary Range Exchange
class EmployerPHCSalaryRangeExchangeRequested extends EmployerEvent {
  final EmployerPHCSalaryRangeExchangeRequestParams params;
  const EmployerPHCSalaryRangeExchangeRequested({required this.params});
  @override
  List<Object> get props => [
    params,
  ];
}