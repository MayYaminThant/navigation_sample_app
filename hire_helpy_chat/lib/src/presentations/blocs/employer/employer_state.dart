part of blocs;

abstract class EmployerState extends Equatable {
  const EmployerState();

  @override
  List<Object> get props => [];
}

class EmployerInitialState extends EmployerState {
  @override
  String toString() => "InitializePageState";
}

//Employer ContactUs
class EmployerContactUsLoading extends EmployerState {}

class EmployerContactUsSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerContactUsSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerContactUsFail extends EmployerState {
  final String message;
  const EmployerContactUsFail({required this.message});
}

//Employer Login
class EmployerLoginLoading extends EmployerState {}

class EmployerLoginSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerLoginSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerLoginFail extends EmployerState {
  final String message;
  const EmployerLoginFail({required this.message});
}

//Employer Register
class EmployerRegisterLoading extends EmployerState {}

class EmployerRegisterSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerRegisterSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerRegisterFail extends EmployerState {
  final String message;
  const EmployerRegisterFail({required this.message});
}

//Employer Social Login
class EmployerSocialLoginLoading extends EmployerState {}

class EmployerSocialLoginSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerSocialLoginSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerSocialLoginFail extends EmployerState {
  final String message;
  const EmployerSocialLoginFail({required this.message});
}

//Employer Social Register
class EmployerSocialRegisterLoading extends EmployerState {}

class EmployerSocialRegisterSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerSocialRegisterSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerSocialRegisterFail extends EmployerState {
  final String message;
  const EmployerSocialRegisterFail({required this.message});
}

//Employer Logout
class EmployerLogoutLoading extends EmployerState {}

class EmployerLogoutSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerLogoutSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerLogoutFail extends EmployerState {
  final String message;
  const EmployerLogoutFail({required this.message});
}

//Employer Configs
class EmployerConfigsLoading extends EmployerState {}

class EmployerConfigsSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerConfigsSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerConfigsFail extends EmployerState {
  final String message;
  const EmployerConfigsFail({required this.message});
}

//Employer Countries
class EmployerCountriesLoading extends EmployerState {}

class EmployerCountriesSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerCountriesSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerCountriesFail extends EmployerState {
  final String message;
  const EmployerCountriesFail({required this.message});
}

//Employer Genders
class EmployerGendersLoading extends EmployerState {}

class EmployerGendersSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerGendersSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerGendersFail extends EmployerState {
  final String message;
  const EmployerGendersFail({required this.message});
}

//Employer Language Types
class EmployerLanguageTypesLoading extends EmployerState {}

class EmployerLanguageTypesSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerLanguageTypesSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerLanguageTypesFail extends EmployerState {
  final String message;
  const EmployerLanguageTypesFail({required this.message});
}

//Employer Religions
class EmployerReligionsLoading extends EmployerState {}

class EmployerReligionsSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerReligionsSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerReligionsFail extends EmployerState {
  final String message;
  const EmployerReligionsFail({required this.message});
}

//Employer Family Status Type
class EmployerFamilyStatusTypeLoading extends EmployerState {}

class EmployerFamilyStatusTypeSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerFamilyStatusTypeSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerFamilyStatusTypeFail extends EmployerState {
  final String message;
  const EmployerFamilyStatusTypeFail({required this.message});
}

//Employer Academic Qualification Type
class EmployerAcademicQualificationTypeLoading extends EmployerState {}

class EmployerAcademicQualificationSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerAcademicQualificationSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerAcademicQualificationTypeFail extends EmployerState {
  final String message;
  const EmployerAcademicQualificationTypeFail({required this.message});
}

//Employer Availability Status
class EmployerAvailabilityStatusLoading extends EmployerState {}

class EmployerAvailabilityStatusSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerAvailabilityStatusSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerAvailabilityStatusFail extends EmployerState {
  final String message;
  const EmployerAvailabilityStatusFail({required this.message});
}

//Employer Update Availability Status
class EmployerUpdateAvailabilityStatusLoading extends EmployerState {}

class EmployerUpdateAvailabilityStatusSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerUpdateAvailabilityStatusSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerUpdateAvailabilityStatusFail extends EmployerState {
  final String message;
  const EmployerUpdateAvailabilityStatusFail({required this.message});
}

//Employer Employments
class EmployerEmploymentsLoading extends EmployerState {}

class EmployerEmploymentsSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerEmploymentsSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerEmploymentsFail extends EmployerState {
  final String message;
  const EmployerEmploymentsFail({required this.message});
}

//Employer Create Employment
class EmployerCreateEmploymentLoading extends EmployerState {}

class EmployerCreateEmploymentSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerCreateEmploymentSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerCreateEmploymentFail extends EmployerState {
  final String message;
  const EmployerCreateEmploymentFail({required this.message});
}

//Employer Update Employments
class EmployerUpdateEmploymentLoading extends EmployerState {}

class EmployerUpdateEmploymentSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerUpdateEmploymentSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerUpdateEmploymentFail extends EmployerState {
  final String message;
  const EmployerUpdateEmploymentFail({required this.message});
}

//Employer Delete Employments
class EmployerDeleteEmploymentLoading extends EmployerState {}

class EmployerDeleteEmploymentSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerDeleteEmploymentSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerDeleteEmploymentFail extends EmployerState {
  final String message;
  const EmployerDeleteEmploymentFail({required this.message});
}

//Employer Create Avatar(Image/Video Upload)
class EmployerCreateAvatarLoading extends EmployerState {}

class EmployerCreateAvatarSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerCreateAvatarSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerCreateAvatarFail extends EmployerState {
  final String message;
  const EmployerCreateAvatarFail({required this.message});
}

//Employer Delete Avatar
class EmployerDeleteAvatarLoading extends EmployerState {}

class EmployerDeleteAvatarSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerDeleteAvatarSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerDeleteAvatarFail extends EmployerState {
  final String message;
  const EmployerDeleteAvatarFail({required this.message});
}

//Employer Create About Step(Step 1)
class EmployerCreateAboutStepLoading extends EmployerState {}

class EmployerCreateAboutStepSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerCreateAboutStepSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerCreateAboutStepFail extends EmployerState {
  final String message;
  const EmployerCreateAboutStepFail({required this.message});
}

//Employer Profile
class EmployerProfileLoading extends EmployerState {}

class EmployerProfileSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerProfileSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerProfileFail extends EmployerState {
  final String message;
  const EmployerProfileFail({required this.message});
}

//Employer Update Family Information
class EmployerUpdateFamilyInformationLoading extends EmployerState {}

class EmployerUpdateFamilyInformationSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerUpdateFamilyInformationSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerUpdateFamilyInformationFail extends EmployerState {
  final String message;
  const EmployerUpdateFamilyInformationFail({required this.message});
}

//Employer Update Language
class EmployerUpdateLanguageLoading extends EmployerState {}

class EmployerUpdateLanguageSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerUpdateLanguageSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerUpdateLanguageFail extends EmployerState {
  final String message;
  const EmployerUpdateLanguageFail({required this.message});
}

//App Language & Locale
class EmployerUpdateAppLanguageSuccess extends EmployerState {
  final String language;
  const EmployerUpdateAppLanguageSuccess({required this.language});
}
class EmployerUpdateAppLocaleSuccess extends EmployerState {
  final String appLocale;
  const EmployerUpdateAppLocaleSuccess({required this.appLocale});
}

//Employer StarList
class EmployerStarListLoading extends EmployerState {}

class EmployerStarListSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerStarListSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerStarListFail extends EmployerState {
  final String message;
  const EmployerStarListFail({required this.message});
}

//Employer StarList ADD
class EmployerStarListAddLoading extends EmployerState {}

class EmployerStarListAddSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerStarListAddSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerStarListAddFail extends EmployerState {
  final String message;
  const EmployerStarListAddFail({required this.message});
}

//Employer StarList Remove
class EmployerStarListRemoveLoading extends EmployerState {}

class EmployerStarListRemoveSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerStarListRemoveSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerStarListRemoveFail extends EmployerState {
  final String message;
  const EmployerStarListRemoveFail({required this.message});
}

//Employer Forgot Password
class EmployerForgotPasswordLoading extends EmployerState {}

class EmployerForgotPasswordSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerForgotPasswordSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerForgotPasswordFail extends EmployerState {
  final String message;
  const EmployerForgotPasswordFail({required this.message});
}

//Employer Reset Password
class EmployerResetPasswordLoading extends EmployerState {}

class EmployerResetPasswordSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerResetPasswordSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerResetPasswordFail extends EmployerState {
  final String message;
  const EmployerResetPasswordFail({required this.message});
}

//Employer Spotlights
class EmployerCreateSpotlightsLoading extends EmployerState {}

class EmployerCreateSpotlightsSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerCreateSpotlightsSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerCreateSpotlightsFail extends EmployerState {
  final String message;
  const EmployerCreateSpotlightsFail({required this.message});
}

//Employer Working Preferences
class EmployerUpdateWorkingPreferencesLoading extends EmployerState {}

class EmployerUpdateWorkingPreferencesSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerUpdateWorkingPreferencesSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerUpdateWorkingPreferencesFail extends EmployerState {
  final String message;
  const EmployerUpdateWorkingPreferencesFail({required this.message});
}

//Employer Update FCM
class EmployerUpdateFCMLoading extends EmployerState {}

class EmployerUpdateFCMSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerUpdateFCMSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerUpdateFCMFail extends EmployerState {
  final String message;
  const EmployerUpdateFCMFail({required this.message});
}

//Employer Save Search List
class EmployerSaveSearchListLoading extends EmployerState {}

class EmployerSaveSearchListSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerSaveSearchListSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerSaveSearchListFail extends EmployerState {
  final String message;
  const EmployerSaveSearchListFail({required this.message});
}

//Employer Update Save Search
class EmployerUpdateSaveSearchLoading extends EmployerState {}

class EmployerUpdateSaveSearchSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerUpdateSaveSearchSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerUpdateSaveSearchFail extends EmployerState {
  final String message;
  const EmployerUpdateSaveSearchFail({required this.message});
}

//Employer Delete Save Search
class EmployerDeleteSaveSearchLoading extends EmployerState {}

class EmployerDeleteSaveSearchSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerDeleteSaveSearchSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerDeleteSaveSearchFail extends EmployerState {
  final String message;
  const EmployerDeleteSaveSearchFail({required this.message});
}

//Employer Create Offer
class EmployerCreatOfferLoading extends EmployerState {}

class EmployerCreateOfferSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerCreateOfferSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerCreateOfferFail extends EmployerState {
  final String message;
  const EmployerCreateOfferFail({required this.message});
}

//Employer Delete Offer
class EmployerDeleteOfferLoading extends EmployerState {}

class EmployerDeleteOfferSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerDeleteOfferSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerDeleteOfferFail extends EmployerState {
  final String message;
  const EmployerDeleteOfferFail({required this.message});
}

//Employer Create Verification
class EmployerCreateVerificationLoading extends EmployerState {}

class EmployerCreateVerificationSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerCreateVerificationSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerCreateVerificationFail extends EmployerState {
  final String message;
  const EmployerCreateVerificationFail({required this.message});
}

//Employer Delete Account
class EmployerDeleteAccountLoading extends EmployerState {}

class EmployerDeleteAccountSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerDeleteAccountSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerDeleteAccountFail extends EmployerState {
  final String message;
  const EmployerDeleteAccountFail({required this.message});
}

//Employer Delete Profile
class EmployerDeleteProfileLoading extends EmployerState {}

class EmployerDeleteProfileSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerDeleteProfileSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerDeleteProfileFail extends EmployerState {
  final String message;
  const EmployerDeleteProfileFail({required this.message});
}

//Employer Reviews
class EmployerReviewsLoading extends EmployerState {}

class EmployerReviewsSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerReviewsSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerReviewsFail extends EmployerState {
  final String message;
  const EmployerReviewsFail({required this.message});
}

//Employer Create Review
class EmployerCreateReviewLoading extends EmployerState {}

class EmployerCreateReviewSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerCreateReviewSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerCreateReviewFail extends EmployerState {
  final String message;
  const EmployerCreateReviewFail({required this.message});
}

//Employer Delete Review
class EmployerDeleteReviewLoading extends EmployerState {}

class EmployerDeleteReviewSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerDeleteReviewSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerDeleteReviewFail extends EmployerState {
  final String message;
  const EmployerDeleteReviewFail({required this.message});
}

//Employer Coin History
class EmployerCoinHistoryListLoading extends EmployerState {}

class EmployerCoinHistoryListSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerCoinHistoryListSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class EmployerCoinHistoryListFail extends EmployerState {
  final String message;
  const EmployerCoinHistoryListFail({required this.message});
}

//Employer Coin Balance
class EmployerCoinBalanceLoading extends EmployerState {}

class EmployerCoinBalanceSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerCoinBalanceSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class EmployerCoinBalanceFail extends EmployerState {
  final String message;
  const EmployerCoinBalanceFail({required this.message});
}

//Employer Refer Friend List
class EmployerReferFriendListLoading extends EmployerState {}

class EmployerReferFriendListSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerReferFriendListSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class EmployerReferFriendListFail extends EmployerState {
  final String message;
  const EmployerReferFriendListFail({required this.message});
}

//Employer Update Account
class EmployerUpdateAccountLoading extends EmployerState {}

class EmployerUpdateAccountSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerUpdateAccountSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class EmployerUpdateAccountFail extends EmployerState {
  final String message;
  const EmployerUpdateAccountFail({required this.message});
}

//Employer Create Employment Sort
class EmployerEmploymentSortLoading extends EmployerState {}

class EmployerEmploymentSortSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerEmploymentSortSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class EmployerEmploymentSortFail extends EmployerState {
  final String message;
  const EmployerEmploymentSortFail({required this.message});
}

//Employer Notify Save Search
class EmployerNotifySaveSearchLoading extends EmployerState {}

class EmployerNotifySaveSearchSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerNotifySaveSearchSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class EmployerNotifySaveSearchFail extends EmployerState {
  final String message;
  const EmployerNotifySaveSearchFail({required this.message});
}

//Employer Update Shareable Link
class EmployerUpdateShareableLinkLoading extends EmployerState {}

class EmployerUpdateShareableLinkSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerUpdateShareableLinkSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class EmployerUpdateShareableLinkFail extends EmployerState {
  final String message;
  const EmployerUpdateShareableLinkFail({required this.message});
}

//Employer Check Verified
class EmployerCheckVerifiedLoading extends EmployerState {}

class EmployerCheckVerifiedSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerCheckVerifiedSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class EmployerCheckVerifiedFail extends EmployerState {
  final String message;
  const EmployerCheckVerifiedFail({required this.message});
}

//Employer Hiring
class EmployerHiringLoading extends EmployerState {}

class EmployerHiringSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerHiringSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class EmployerHiringFail extends EmployerState {
  final String message;
  const EmployerHiringFail({required this.message});
}

//Employer Profile Complaint
class EmployerProfileComplaintLoading extends EmployerState {}

class EmployerProfileComplaintSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerProfileComplaintSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class EmployerProfileComplaintFail extends EmployerState {
  final String message;
  const EmployerProfileComplaintFail({required this.message});
}

//Employer Update Configs
class EmployerUpdateConfigsLoading extends EmployerState {}

class EmployerUpdateConfigsSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerUpdateConfigsSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class EmployerUpdateConfigsFail extends EmployerState {
  final String message;
  const EmployerUpdateConfigsFail({required this.message});
}

//Employer Exchange Rate
class EmployerExchangeRateLoading extends EmployerState {}

class EmployerExchangeRateSuccess extends EmployerState {
  final DataResponseModel data;

  const EmployerExchangeRateSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class EmployerExchangeRateFail extends EmployerState {
  final String message;
  const EmployerExchangeRateFail({required this.message});
}

//Salary Range Exchange
class EmployerPHCSalaryRangeExchangeLoading extends EmployerState {}
class EmployerPHCSalaryRangeExchangeSuccess extends EmployerState {
  final ConvertedSalaryRangeModel convertedSalaryRange;
  const EmployerPHCSalaryRangeExchangeSuccess({required this.convertedSalaryRange});
  @override
  List<Object> get props => [convertedSalaryRange];
}
class EmployerPHCSalaryRangeExchangeFail extends EmployerState {
  final String message;
  const EmployerPHCSalaryRangeExchangeFail({required this.message});
}