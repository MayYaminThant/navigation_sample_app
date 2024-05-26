part of blocs;

abstract class CandidateEvent extends Equatable {
  const CandidateEvent();

  @override
  List<Object> get props => [];
}

class InitializeCandidateEvent extends CandidateEvent {
  @override
  String toString() => "InitializePageEvent";
}

//Save Work Permit Photos
class WorkPermitPhotoTaken extends CandidateEvent {}

//Candidate Login
class CandidateLoginRequested extends CandidateEvent {
  final CandidateLoginRequestParams? params;

  const CandidateLoginRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Register
class CandidateRegisterRequested extends CandidateEvent {
  final CandidateRegisterRequestParams? params;

  const CandidateRegisterRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Social Login
class CandidateSocialLoginRequested extends CandidateEvent {
  final CandidateSocialLoginRequestParams? params;

  const CandidateSocialLoginRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Social Register
class CandidateSocialRegisterRequested extends CandidateEvent {
  final CandidateSocialRegisterRequestParams? params;

  const CandidateSocialRegisterRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Logout
class CandidateLogoutRequested extends CandidateEvent {
  final CandidateLogoutRequestParams? params;

  const CandidateLogoutRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Contact Us
class CandidateContactUsRequested extends CandidateEvent {
  final CandidateContactUsRequestParams? params;

  const CandidateContactUsRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Configs
class CandidateConfigsRequested extends CandidateEvent {
  final CandidateConfigsRequestParams? params;

  const CandidateConfigsRequested({this.params});

  @override
  List<Object> get props => [];
}

//Candidate Countries
class CandidateCountriesRequested extends CandidateEvent {
  const CandidateCountriesRequested();

  @override
  List<Object> get props => [];
}

//Candidate Genders
class CandidateGendersRequested extends CandidateEvent {
  const CandidateGendersRequested();

  @override
  List<Object> get props => [];
}

//Candidate Language Types
class CandidateLanguageTypesRequested extends CandidateEvent {
  const CandidateLanguageTypesRequested();

  @override
  List<Object> get props => [];
}

//Candidate Religions

class CandidateReligionsRequested extends CandidateEvent {
  const CandidateReligionsRequested();

  @override
  List<Object> get props => [];
}

//Candidate Family Types
class CandidateFamilyTypesRequested extends CandidateEvent {
  const CandidateFamilyTypesRequested();

  @override
  List<Object> get props => [];
}

//Candidate Academic Qualification Type
class CandidateAcademicQualificationTypeRequested extends CandidateEvent {
  const CandidateAcademicQualificationTypeRequested();

  @override
  List<Object> get props => [];
}

//Candidate Availability Status
class CandidateAvailabilityStatusRequested extends CandidateEvent {
  const CandidateAvailabilityStatusRequested();

  @override
  List<Object> get props => [];
}

//Candidate Update Availability Status
class CandidateUpdateAvailabilityStatusRequested extends CandidateEvent {
  final CandidateLogoutRequestParams? params;

  const CandidateUpdateAvailabilityStatusRequested({this.params});

  @override
  List<Object> get props => [params!];
}

//Candidate Create About
class CandidateCreateAboutRequested extends CandidateEvent {
  final CandidateCreateAboutRequestParams? params;

  const CandidateCreateAboutRequested({this.params});

  @override
  List<Object> get props => [params!];
}

//Candidate Create Employment
class CandidateCreateEmploymentRequested extends CandidateEvent {
  final CandidateCreateEmploymentRequestParams? params;

  const CandidateCreateEmploymentRequested({this.params});

  @override
  List<Object> get props => [params!];
}

//Candidate Create Avatar
class CandidateCreateAvatarRequested extends CandidateEvent {
  final CandidateCreateAvatarRequestParams? params;

  const CandidateCreateAvatarRequested({this.params});

  @override
  List<Object> get props => [params!];
}

//Candidate Delete Employment
class CandidateDeleteEmploymentRequested extends CandidateEvent {
  final CandidateDeleteEmploymentRequestParams? params;

  const CandidateDeleteEmploymentRequested({this.params});

  @override
  List<Object> get props => [params!];
}

//Candidate Delete Avatar
class CandidateDeleteAvatarRequested extends CandidateEvent {
  final CandidateDeleteAvatarRequestParams? params;

  const CandidateDeleteAvatarRequested({this.params});

  @override
  List<Object> get props => [params!];
}

//Candidate Availability
class CandidateAvailabilityRequested extends CandidateEvent {
  final CandidateRequestParams? params;

  const CandidateAvailabilityRequested({this.params});

  @override
  List<Object> get props => [params!];
}

//Candidate Employment
class CandidateEmploymentRequested extends CandidateEvent {
  final CandidateRequestParams? params;

  const CandidateEmploymentRequested({this.params});

  @override
  List<Object> get props => [params!];
}

//Candidate Profile
class CandidateProfileRequested extends CandidateEvent {
  final CandidateRequestParams? params;

  const CandidateProfileRequested({this.params});

  @override
  List<Object> get props => [params!];
}

//Candidate Update Availability Status
class CandidateUpdateAvailabilityRequested extends CandidateEvent {
  final CandidateUpdateAvailabilityStatusRequestParams? params;

  const CandidateUpdateAvailabilityRequested({this.params});

  @override
  List<Object> get props => [params!];
}

//Candidate Update Emlpoyment
class CandidateUpdateEmlpoymentRequested extends CandidateEvent {
  final CandidateUpdateEmploymentRequestParams? params;

  const CandidateUpdateEmlpoymentRequested({this.params});

  @override
  List<Object> get props => [params!];
}

//Candidate Update Family Information
class CandidateUpdateFamilyInformationRequested extends CandidateEvent {
  final CandidateUpdateFamilyStatusRequestParams? params;

  const CandidateUpdateFamilyInformationRequested({this.params});

  @override
  List<Object> get props => [params!];
}

//Candidate Update Skill And Qualification
class CandidateUpdateSkillAndQualificationRequested extends CandidateEvent {
  final CandidateUpdateSkillAndQualificationRequestParams? params;

  const CandidateUpdateSkillAndQualificationRequested({this.params});

  @override
  List<Object> get props => [params!];
}

//Employer Update App Language & Locale
class CandidateUpdateAppLanguage extends CandidateEvent {
  final String language;

  const CandidateUpdateAppLanguage({required this.language});
}

class CandidateUpdateAppLocale extends CandidateEvent {
  final String appLocale;

  const CandidateUpdateAppLocale({required this.appLocale});
}

//Candidate StarList
class CandidateStarListRequested extends CandidateEvent {
  final CandidateStarListRequestParams? params;

  const CandidateStarListRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate StarList Add
class CandidateStarListAddRequested extends CandidateEvent {
  final CandidateStarListAddRequestParams? params;

  const CandidateStarListAddRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate StarList Remove
class CandidateStarListRemoveRequested extends CandidateEvent {
  final CandidateStarListRemoveRequestParams? params;

  const CandidateStarListRemoveRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Forgot Password
class CandidateForgotPasswordRequested extends CandidateEvent {
  final CandidateForgotPasswordRequestParams? params;

  const CandidateForgotPasswordRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Reset Password
class CandidateResetPasswordRequested extends CandidateEvent {
  final CandidateResetPasswordRequestParams? params;

  const CandidateResetPasswordRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Spotlights
class CandidateSpotlightsRequested extends CandidateEvent {
  final CandidateSpotlightsRequestParams? params;

  const CandidateSpotlightsRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Working Preferences
class CandidateUpdateWorkingPreferencesRequested extends CandidateEvent {
  final CandidateUpdateWorkingPreferenceRequestParams? params;

  const CandidateUpdateWorkingPreferencesRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate FCM
class CandidateUpdateFCMRequested extends CandidateEvent {
  final CandidateFCMRequestParams? params;

  const CandidateUpdateFCMRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Save Search List
class CandidateSaveSearchListRequested extends CandidateEvent {
  final CandidateSaveSearchRequestParams? params;

  const CandidateSaveSearchListRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Update Save Search
class CandidateUpdateSaveSearchRequested extends CandidateEvent {
  final CandidateUpdateSaveSearchRequestParams? params;

  const CandidateUpdateSaveSearchRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Delete Save Search
class CandidateDeleteSaveSearchRequested extends CandidateEvent {
  final CandidateDeleteSaveSearchRequestParams? params;

  const CandidateDeleteSaveSearchRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Delete Big Data
class CandidateCreateBigDataRequested extends CandidateEvent {
  final CandidateCreateBigDataRequestParams? params;

  const CandidateCreateBigDataRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Delete Big Data
class CandidateDeleteBigDataRequested extends CandidateEvent {
  final CandidateDeleteBigDataRequestParams? params;

  const CandidateDeleteBigDataRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Delete Account
class CandidateDeleteAccountRequested extends CandidateEvent {
  final CandidateDeleteAccountRequestParams? params;

  const CandidateDeleteAccountRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Delete Profile
class CandidateDeleteProfileRequested extends CandidateEvent {
  final CandidateDeleteProfileRequestParams? params;

  const CandidateDeleteProfileRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Create Verification
class CandidateCreateVerificationRequested extends CandidateEvent {
  final CandidateUpdateVerificationRequestParams? params;

  const CandidateCreateVerificationRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Get Reviews
class CandidateReviewsRequested extends CandidateEvent {
  final CandidateReviewsRequestParams? params;

  const CandidateReviewsRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Create Review
class CandidateCreateReviewRequested extends CandidateEvent {
  final CandidateCreateReviewsRequestParams? params;

  const CandidateCreateReviewRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Delete Review
class CandidateDeleteReviewRequested extends CandidateEvent {
  final CandidateDeleteReviewsRequestParams? params;

  const CandidateDeleteReviewRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Coin History
class CandidateCoinHistoryListRequested extends CandidateEvent {
  final CandidateListCoinHistoryRequestParams? params;

  const CandidateCoinHistoryListRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Coin Balance
class CandidateCoinBalanceListRequested extends CandidateEvent {
  final CandidateListCoinBalanceRequestParams? params;

  const CandidateCoinBalanceListRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Refer Friend List
class CandidateReferFriendListRequested extends CandidateEvent {
  final CandidateReferFriendRequestParams? params;

  const CandidateReferFriendListRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Update Account
class CandidateUpdateAccountRequested extends CandidateEvent {
  final CandidateUpdateAccountRequestParams? params;

  const CandidateUpdateAccountRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Employment Sort
class CandidateEmploymentSortRequested extends CandidateEvent {
  final CandidateCreateEmploymentSortRequestParams? params;

  const CandidateEmploymentSortRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Save Search Notify
class CandidateNotifySaveSearchRequested extends CandidateEvent {
  final CandidateNotifySaveSearchRequestParams? params;

  const CandidateNotifySaveSearchRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Update Shareable Link
class CandidateUpdateShareableLinkRequested extends CandidateEvent {
  final CandidateUpdateShareableLinkRequestParams? params;

  const CandidateUpdateShareableLinkRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Check Verified
class CandidateCheckVerifiedRequested extends CandidateEvent {
  final CandidateCheckVerifiedRequestParams? params;

  const CandidateCheckVerifiedRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Work Permit
class CandidateWorkPermitRequested extends CandidateEvent {
  final CandidateWorkPermitRequestParams? params;

  const CandidateWorkPermitRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Profile Complaint
class CandidateProfileComplaintRequested extends CandidateEvent {
  final CandidateProfileComplaintRequestParams? params;

  const CandidateProfileComplaintRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Update Configs
class CandidateUpdateConfigsRequested extends CandidateEvent {
  final CandidateUpdateConfigsRequestParams? params;

  const CandidateUpdateConfigsRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Candidate Exchange Rate
class CandidateExchangeRateRequested extends CandidateEvent {
  final CandidateExchangeRateRequestParams? params;

  const CandidateExchangeRateRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}

//Salary Range Exchange
class CandidatePHCSalaryRangeExchangeRequested extends CandidateEvent {
  final CandidatePHCSalaryRangeExchangeRequestParams params;

  const CandidatePHCSalaryRangeExchangeRequested({required this.params});

  @override
  List<Object> get props => [
    params,
  ];
}


//Candidate Offer Action
class CandidateOfferActionRequested extends CandidateEvent {
  final CandidateOfferActionRequestParams? params;

  const CandidateOfferActionRequested({this.params});

  @override
  List<Object> get props => [
        params!,
      ];
}
