part of blocs;

abstract class CandidateState extends Equatable {
  const CandidateState();

  @override
  List<Object> get props => [];
}

class CandidateInitialState extends CandidateState {
  @override
  String toString() => "InitializePageState";
}

class WorkPermitPhotoUpdated extends CandidateState {
  final WorkPermitDetails workPermitDetails;
  const WorkPermitPhotoUpdated({required this.workPermitDetails});
}

//Candidate ContactUs
class CandidateContactUsLoading extends CandidateState {}

class CandidateContactUsSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateContactUsSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateContactUsFail extends CandidateState {
  final String message;

  const CandidateContactUsFail({required this.message});
}

//Candidate Login
class CandidateLoginLoading extends CandidateState {}

class CandidateLoginSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateLoginSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateLoginFail extends CandidateState {
  final String message;

  const CandidateLoginFail({required this.message});
}

//Candidate Register
class CandidateRegisterLoading extends CandidateState {}

class CandidateRegisterSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateRegisterSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateRegisterFail extends CandidateState {
  final String message;

  const CandidateRegisterFail({required this.message});
}

//Candidate Social Login
class CandidateSocialLoginLoading extends CandidateState {}

class CandidateSocialLoginSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateSocialLoginSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateSocialLoginFail extends CandidateState {
  final String message;

  const CandidateSocialLoginFail({required this.message});
}

//Candidate Social Register
class CandidateSocialRegisterLoading extends CandidateState {}

class CandidateSocialRegisterSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateSocialRegisterSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateSocialRegisterFail extends CandidateState {
  final String message;

  const CandidateSocialRegisterFail({required this.message});
}

//Candidate Logout
class CandidateLogoutLoading extends CandidateState {}

class CandidateLogoutSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateLogoutSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateLogoutFail extends CandidateState {
  final String message;

  const CandidateLogoutFail({required this.message});
}

//Candidate Configs
class CandidateConfigsLoading extends CandidateState {}

class CandidateConfigsSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateConfigsSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateConfigsFail extends CandidateState {
  final String message;

  const CandidateConfigsFail({required this.message});
}

//Candidate Countries
class CandidateCountriesLoading extends CandidateState {}

class CandidateCountriesSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateCountriesSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateCountriesFail extends CandidateState {
  final String message;

  const CandidateCountriesFail({required this.message});
}

//Candidate Genders
class CandidateGendersLoading extends CandidateState {}

class CandidateGendersSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateGendersSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateGendersFail extends CandidateState {
  final String message;

  const CandidateGendersFail({required this.message});
}

//Candidate Language Types
class CandidateLanguageTypesLoading extends CandidateState {}

class CandidateLanguageTypesSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateLanguageTypesSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateLanguageTypesFail extends CandidateState {
  final String message;

  const CandidateLanguageTypesFail({required this.message});
}

//Candidate Religions
class CandidateReligionsLoading extends CandidateState {}

class CandidateReligionsSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateReligionsSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateReligionsFail extends CandidateState {
  final String message;

  const CandidateReligionsFail({required this.message});
}

//Candidate Family Status Type
class CandidateFamilyStatusTypeLoading extends CandidateState {}

class CandidateFamilyStatusTypeSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateFamilyStatusTypeSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateFamilyStatusTypeFail extends CandidateState {
  final String message;

  const CandidateFamilyStatusTypeFail({required this.message});
}

//Candidate Academic Qualification Type
class CandidateAcademicQualificationTypeLoading extends CandidateState {}

class CandidateAcademicQualificationSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateAcademicQualificationSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateAcademicQualificationTypeFail extends CandidateState {
  final String message;

  const CandidateAcademicQualificationTypeFail({required this.message});
}

//Candidate Availability Status
class CandidateAvailabilityStatusLoading extends CandidateState {}

class CandidateAvailabilityStatusSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateAvailabilityStatusSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateAvailabilityStatusFail extends CandidateState {
  final String message;

  const CandidateAvailabilityStatusFail({required this.message});
}

//Candidate Update Availability Status
class CandidateUpdateAvailabilityStatusLoading extends CandidateState {}

class CandidateUpdateAvailabilityStatusSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateUpdateAvailabilityStatusSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateUpdateAvailabilityStatusFail extends CandidateState {
  final String message;

  const CandidateUpdateAvailabilityStatusFail({required this.message});
}

//Candidate Employments
class CandidateEmploymentsLoading extends CandidateState {}

class CandidateEmploymentsSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateEmploymentsSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateEmploymentsFail extends CandidateState {
  final String message;

  const CandidateEmploymentsFail({required this.message});
}

//Candidate Create Employment
class CandidateCreateEmploymentLoading extends CandidateState {}

class CandidateCreateEmploymentSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateCreateEmploymentSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateCreateEmploymentFail extends CandidateState {
  final String message;

  const CandidateCreateEmploymentFail({required this.message});
}

//Candidate Update Employments
class CandidateUpdateEmploymentLoading extends CandidateState {}

class CandidateUpdateEmploymentSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateUpdateEmploymentSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateUpdateEmploymentFail extends CandidateState {
  final String message;

  const CandidateUpdateEmploymentFail({required this.message});
}

//Candidate Delete Employments
class CandidateDeleteEmploymentLoading extends CandidateState {}

class CandidateDeleteEmploymentSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateDeleteEmploymentSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateDeleteEmploymentFail extends CandidateState {
  final String message;

  const CandidateDeleteEmploymentFail({required this.message});
}

//Candidate Create Avatar(Image/Video Upload)
class CandidateCreateAvatarLoading extends CandidateState {}

class CandidateCreateAvatarSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateCreateAvatarSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateCreateAvatarFail extends CandidateState {
  final String message;

  const CandidateCreateAvatarFail({required this.message});
}

//Candidate Delete Avatar
class CandidateDeleteAvatarLoading extends CandidateState {}

class CandidateDeleteAvatarSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateDeleteAvatarSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateDeleteAvatarFail extends CandidateState {
  final String message;

  const CandidateDeleteAvatarFail({required this.message});
}

//Candidate Create About Step(Step 1)
class CandidateCreateAboutStepLoading extends CandidateState {}

class CandidateCreateAboutStepSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateCreateAboutStepSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateCreateAboutStepFail extends CandidateState {
  final String message;

  const CandidateCreateAboutStepFail({required this.message});
}

//Candidate Profile
class CandidateProfileLoading extends CandidateState {}

class CandidateProfileSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateProfileSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateProfileFail extends CandidateState {
  final String message;

  const CandidateProfileFail({required this.message});
}

//Candidate Update Family Information
class CandidateUpdateFamilyInformationLoading extends CandidateState {}

class CandidateUpdateFamilyInformationSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateUpdateFamilyInformationSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateUpdateFamilyInformationFail extends CandidateState {
  final String message;

  const CandidateUpdateFamilyInformationFail({required this.message});
}

//Candidate Update Skill And Qualification
class CandidateUpdateSkillQualificationLoading extends CandidateState {}

class CandidateUpdateSkillQualificationSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateUpdateSkillQualificationSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateUpdateSkillQualificationFail extends CandidateState {
  final String message;

  const CandidateUpdateSkillQualificationFail({required this.message});
}

//App Language & Locale
class CandidateUpdateAppLanguageSuccess extends CandidateState {
  final String language;

  const CandidateUpdateAppLanguageSuccess({required this.language});
}

class CandidateUpdateAppLocaleSuccess extends CandidateState {
  final String appLocale;

  const CandidateUpdateAppLocaleSuccess({required this.appLocale});
}

//Candidate StarList
class CandidateStarListLoading extends CandidateState {}

class CandidateStarListSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateStarListSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateStarListFail extends CandidateState {
  final String message;

  const CandidateStarListFail({required this.message});
}

//Candidate StarList ADD
class CandidateStarListAddLoading extends CandidateState {}

class CandidateStarListAddSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateStarListAddSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateStarListAddFail extends CandidateState {
  final String message;

  const CandidateStarListAddFail({required this.message});
}

//Candidate StarList Remove
class CandidateStarListRemoveLoading extends CandidateState {}

class CandidateStarListRemoveSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateStarListRemoveSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateStarListRemoveFail extends CandidateState {
  final String message;

  const CandidateStarListRemoveFail({required this.message});
}

//Candidate Forgot Password
class CandidateForgotPasswordLoading extends CandidateState {}

class CandidateForgotPasswordSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateForgotPasswordSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateForgotPasswordFail extends CandidateState {
  final String message;

  const CandidateForgotPasswordFail({required this.message});
}

//Candidate Reset Password
class CandidateResetPasswordLoading extends CandidateState {}

class CandidateResetPasswordSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateResetPasswordSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateResetPasswordFail extends CandidateState {
  final String message;

  const CandidateResetPasswordFail({required this.message});
}

//Candidate Spotlights
class CandidateCreateSpotlightsLoading extends CandidateState {}

class CandidateCreateSpotlightsSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateCreateSpotlightsSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateCreateSpotlightsFail extends CandidateState {
  final String message;

  const CandidateCreateSpotlightsFail({required this.message});
}

//Candidate Working Preferences
class CandidateUpdateWorkingPreferencesLoading extends CandidateState {}

class CandidateUpdateWorkingPreferencesSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateUpdateWorkingPreferencesSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateUpdateWorkingPreferencesFail extends CandidateState {
  final String message;

  const CandidateUpdateWorkingPreferencesFail({required this.message});
}

//Candidate Update FCM
class CandidateUpdateFCMLoading extends CandidateState {}

class CandidateUpdateFCMSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateUpdateFCMSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateUpdateFCMFail extends CandidateState {
  final String message;

  const CandidateUpdateFCMFail({required this.message});
}

//Candidate Save Search List
class CandidateSaveSearchListLoading extends CandidateState {}

class CandidateSaveSearchListSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateSaveSearchListSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateSaveSearchListFail extends CandidateState {
  final String message;

  const CandidateSaveSearchListFail({required this.message});
}

//Candidate Update Save Search
class CandidateUpdateSaveSearchLoading extends CandidateState {}

class CandidateUpdateSaveSearchSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateUpdateSaveSearchSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateUpdateSaveSearchFail extends CandidateState {
  final String message;

  const CandidateUpdateSaveSearchFail({required this.message});
}

//Candidate Delete Save Search
class CandidateDeleteSaveSearchLoading extends CandidateState {}

class CandidateDeleteSaveSearchSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateDeleteSaveSearchSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateDeleteSaveSearchFail extends CandidateState {
  final String message;

  const CandidateDeleteSaveSearchFail({required this.message});
}

//Candidate Create Big Data
class CandidateCreateBigDataLoading extends CandidateState {}

class CandidateCreateBigDataSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateCreateBigDataSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateCreateBigDataFail extends CandidateState {
  final String message;

  const CandidateCreateBigDataFail({required this.message});
}

//Candidate Delete Big Data
class CandidateDeleteBigDataLoading extends CandidateState {}

class CandidateDeleteBigDataSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateDeleteBigDataSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateDeleteBigDataFail extends CandidateState {
  final String message;

  const CandidateDeleteBigDataFail({required this.message});
}

//Candidate Create Verification
class CandidateCreateVerificationLoading extends CandidateState {}

class CandidateCreateVerificationSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateCreateVerificationSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateCreateVerificationFail extends CandidateState {
  final String message;

  const CandidateCreateVerificationFail({required this.message});
}

//Candidate Delete Account
class CandidateDeleteAccountLoading extends CandidateState {}

class CandidateDeleteAccountSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateDeleteAccountSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateDeleteAccountFail extends CandidateState {
  final String message;

  const CandidateDeleteAccountFail({required this.message});
}

//Candidate Delete Profile
class CandidateDeleteProfileLoading extends CandidateState {}

class CandidateDeleteProfileSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateDeleteProfileSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateDeleteProfileFail extends CandidateState {
  final String message;

  const CandidateDeleteProfileFail({required this.message});
}

//Candidate Reviews
class CandidateReviewsLoading extends CandidateState {}

class CandidateReviewsSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateReviewsSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateReviewsFail extends CandidateState {
  final String message;

  const CandidateReviewsFail({required this.message});
}

//Candidate Create Review
class CandidateCreateReviewLoading extends CandidateState {}

class CandidateCreateReviewSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateCreateReviewSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateCreateReviewFail extends CandidateState {
  final String message;

  const CandidateCreateReviewFail({required this.message});
}

//Candidate Delete Review
class CandidateDeleteReviewLoading extends CandidateState {}

class CandidateDeleteReviewSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateDeleteReviewSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateDeleteReviewFail extends CandidateState {
  final String message;

  const CandidateDeleteReviewFail({required this.message});
}

//Candidate Coin History
class CandidateCoinHistoryListLoading extends CandidateState {}

class CandidateCoinHistoryListSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateCoinHistoryListSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateCoinHistoryListFail extends CandidateState {
  final String message;

  const CandidateCoinHistoryListFail({required this.message});
}

//Candidate Coin Balance
class CandidateCoinBalanceListLoading extends CandidateState {}

class CandidateCoinBalanceListSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateCoinBalanceListSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateCoinBalanceListFail extends CandidateState {
  final String message;

  const CandidateCoinBalanceListFail({required this.message});
}

//Candidate Refer Friend List
class CandidateReferFriendListLoading extends CandidateState {}

class CandidateReferFriendListSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateReferFriendListSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateReferFriendListFail extends CandidateState {
  final String message;

  const CandidateReferFriendListFail({required this.message});
}

//Candidate Update Account
class CandidateUpdateAccountLoading extends CandidateState {}

class CandidateUpdateAccountSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateUpdateAccountSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateUpdateAccountFail extends CandidateState {
  final String message;

  const CandidateUpdateAccountFail({required this.message});
}

//Candidate Create Employment Sort
class CandidateEmploymentSortLoading extends CandidateState {}

class CandidateEmploymentSortSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateEmploymentSortSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateEmploymentSortFail extends CandidateState {
  final String message;

  const CandidateEmploymentSortFail({required this.message});
}

//Candidate Notify Save Search
class CandidateNotifySaveSearchLoading extends CandidateState {}

class CandidateNotifySaveSearchSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateNotifySaveSearchSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateNotifySaveSearchFail extends CandidateState {
  final String message;

  const CandidateNotifySaveSearchFail({required this.message});
}

//Candidate Update Shareable Link
class CandidateUpdateShareableLinkLoading extends CandidateState {}

class CandidateUpdateShareableLinkSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateUpdateShareableLinkSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateUpdateShareableLinkFail extends CandidateState {
  final String message;

  const CandidateUpdateShareableLinkFail({required this.message});
}

//Candidate Check Verified
class CandidateCheckVerifiedLoading extends CandidateState {}

class CandidateCheckVerifiedSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateCheckVerifiedSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateCheckVerifiedFail extends CandidateState {
  final String message;

  const CandidateCheckVerifiedFail({required this.message});
}

//Candidate Work Permit
class CandidateWorkPermitLoading extends CandidateState {}

class CandidateWorkPermitSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateWorkPermitSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateWorkPermitFail extends CandidateState {
  final String message;

  const CandidateWorkPermitFail({required this.message});
}

//Candidate Profile Complaint
class CandidateProfileComplaintLoading extends CandidateState {}

class CandidateProfileComplaintSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateProfileComplaintSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateProfileComplaintFail extends CandidateState {
  final String message;

  const CandidateProfileComplaintFail({required this.message});
}

//Candidate Update Configs
class CandidateUpdateConfigsLoading extends CandidateState {}

class CandidateUpdateConfigsSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateUpdateConfigsSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateUpdateConfigsFail extends CandidateState {
  final String message;

  const CandidateUpdateConfigsFail({required this.message});
}

//Candidate Exchange Rate
class CandidateExchangeRateLoading extends CandidateState {}

class CandidateExchangeRateSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateExchangeRateSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateExchangeRateFail extends CandidateState {
  final String message;

  const CandidateExchangeRateFail({required this.message});
}

//Salary Range Exchange
class CandidatePHCSalaryRangeExchangeLoading extends CandidateState {}

class CandidatePHCSalaryRangeExchangeSuccess extends CandidateState {
  final ConvertedSalaryRangeModel convertedSalaryRange;

  const CandidatePHCSalaryRangeExchangeSuccess({required this.convertedSalaryRange});

  @override
  List<Object> get props => [convertedSalaryRange];
}

class CandidatePHCSalaryRangeExchangeFail extends CandidateState {
  final String message;

  const CandidatePHCSalaryRangeExchangeFail({required this.message});
}

//Candidate Offer Action
class CandidateOfferActionLoading extends CandidateState {}

class CandidateOfferActionSuccess extends CandidateState {
  final DataResponseModel data;

  const CandidateOfferActionSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CandidateOfferActionFail extends CandidateState {
  final String message;

  const CandidateOfferActionFail({required this.message});
}
