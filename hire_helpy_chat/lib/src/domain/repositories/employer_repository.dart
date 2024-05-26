part of 'repositories.dart';

abstract class EmployerRepository {
  //Employer Login
  Future<DataState<DataResponseModel>> employerLogin(
      EmployerLoginRequestParams params);

  //Employer Logout
  Future<DataState<DataResponseModel>> employerLogout(
      EmployerLogoutRequestParams params);

  //Employer Social Login
  Future<DataState<DataResponseModel>> employerSocialLogin(
      EmployerSocialLoginRequestParams params);

  //Employer Social Register
  Future<DataState<DataResponseModel>> employerSocialRegister(
      EmployerSocialRegisterRequestParams params);

  //Employer Register
  Future<DataState<DataResponseModel>> employerRegister(
      EmployerRegisterRequestParams params);

  //Employer Contact Us
  Future<DataState<DataResponseModel>> employerContactUs(
      EmployerContactUsRequestParams params);

  //Employer Configs
  Future<DataState<DataResponseModel>> employerConfigs(
      EmployerConfigsRequestParams params);

  //Employer Countries
  Future<DataState<DataResponseModel>> employerCountries();

  //Employer Genders
  Future<DataState<DataResponseModel>> employerGenders();

  //Employer Language Types
  Future<DataState<DataResponseModel>> employerLanguageTypes();

  //Employer Religions
  Future<DataState<DataResponseModel>> employerReligions();

  //Employer Profile
  Future<DataState<DataResponseModel>> employerProfile(
      EmployerRequestParams params);

  //Employer Create Avatar
  Future<DataState<DataResponseModel>> createEmployerAvatar(
      EmployerCreateAvatarRequestParams params);

  //Employer Delete Avatar
  Future<DataState<DataResponseModel>> deleteEmployerAvatar(
      EmployerDeleteAvatarRequestParams params);

  //Employer Ceate About
  Future<DataState<DataResponseModel>> createEmployerAbout(
      EmployerCreateAboutRequestParams params);

  //Employer Update Family Status
  Future<DataState<DataResponseModel>> updateEmployerFamilyInformation(
      EmployerUpdateFamilyStatusRequestParams params);

  //Employer Update Skill And Qualification
  Future<DataState<DataResponseModel>> updateEmployerLanguage(
      EmployerUpdateLanguageParams params);

  //Employer Employments
  Future<DataState<DataResponseModel>> getEmployerEmployments(
      EmployerRequestParams params);

  //Employer Create Employments
  Future<DataState<DataResponseModel>> createEmployerEmployment(
      EmployerCreateEmploymentRequestParams params);

  //Employer Update Employments
  Future<DataState<DataResponseModel>> updateEmployerEmployment(
      EmployerUpdateEmploymentRequestParams params);

  //Employer Delete Employments
  Future<DataState<DataResponseModel>> deleteEmployerEmployment(
      EmployerDeleteEmploymentRequestParams params);

  //Employer Availability Status
  Future<DataState<DataResponseModel>> getEmployerAvailabilityStatus(
      EmployerRequestParams params);

  //Employer Update Availability Status
  Future<DataState<DataResponseModel>> updateEmployerAvailabilityStatus(
      EmployerUpdateAvailabilityStatusRequestParams params);

  //Employer StarList
  Future<DataState<DataResponseModel>> employerStarList(
      EmployerStarListRequestParams params);

  //Employer StarList Add
  Future<DataState<DataResponseModel>> employerStarListAdd(
      EmployerStarListAddRequestParams params);

  //Employer StarList Remove
  Future<DataState<DataResponseModel>> employerStarListRemove(
      EmployerStarListRemoveRequestParams params);

  //Employer Forgot Password
  Future<DataState<DataResponseModel>> employerForgotPassword(
      EmployerForgotPasswordRequestParams params);

  //Employer Reset Password
  Future<DataState<DataResponseModel>> employerResetPassword(
      EmployerResetPasswordRequestParams params);

  //Employer Update Working Preferences
  Future<DataState<DataResponseModel>> employerUpdateWorkingPreferences(
      EmployerUpdateWorkingPreferenceRequestParams params);

  //Employer Spotlights
  Future<DataState<DataResponseModel>> employerSpotlights(
      EmployerSpotlightsRequestParams params);

  //Employer Save Search List
  Future<DataState<DataResponseModel>> employerSaveSearchList(
      EmployerSaveSearchRequestParams params);

  //Employer Update Save Search
  Future<DataState<DataResponseModel>> employerUpdateSaveSearch(
      EmployerUpdateSaveSearchRequestParams params);

  //Employer Delete Save Search
  Future<DataState<DataResponseModel>> employerDeleteSaveSearch(
      EmployerDeleteSaveSearchRequestParams params);

  //Employer Update FCM
  Future<DataState<DataResponseModel>> employerUpdateFCM(
      EmployerFCMRequestParams params);

  //Employer Update Verification
  Future<DataState<DataResponseModel>> updateVerification(
      EmployerUpdateVerificationRequestParams params);

  //Employer Delete Account
  Future<DataState<DataResponseModel>> deleteEmployerAccount(
      EmployerDeleteAccountRequestParams params);

  //Employer Delete Profile
  Future<DataState<DataResponseModel>> deleteEmployerProfile(
      EmployerDeleteProfileRequestParams params);

  //Employer Create Big Data
  Future<DataState<DataResponseModel>> createEmployerBigData(
      EmployerCreateOfferRequestParams params);

  //Employer Delete Big Data
  Future<DataState<DataResponseModel>> deleteEmployerBigData(
      EmployerDeleteOfferRequestParams params);

  //Employer Reviews
  Future<DataState<DataResponseModel>> getEmployerReviews(
      EmployerReviewsRequestParams params);

  //Employer Create Reviews
  Future<DataState<DataResponseModel>> createEmployerReview(
      EmployerCreateReviewsRequestParams params);

  //Employer Delete Reviews
  Future<DataState<DataResponseModel>> deleteEmployerReview(
      EmployerDeleteReviewsRequestParams params);

  //Employer Coin History
  Future<DataState<DataResponseModel>> employerCoinListHistory(
      EmployerListVoucherHistoryRequestParams params);

  //Employer Coin Balance
  Future<DataState<DataResponseModel>> employerCoinBalance(
      EmployerCoinBalanceRequestParams params);

  //Employer Refer Friend List
  Future<DataState<DataResponseModel>> employerReferFriendList(
      EmployerReferFriendRequestParams params);

  //Employer Update Account
  Future<DataState<DataResponseModel>> updateEmployerAccount(
      EmployerUpdateAccountRequestParams params);

  //Employer Saved Search Notify
  Future<DataState<DataResponseModel>> updateEmployerSavedSearchNotify(
      EmployerNotifySaveSearchRequestParams params);

  //Employer Update Shareable Link
  Future<DataState<DataResponseModel>> updateEmployerShareableLink(
      EmployerUpdateShareableLinkRequestParams params);

  //Employer Check Verified
  Future<DataState<DataResponseModel>> getEmployerCheckVerified(
      EmployerCheckVerifiedRequestParams params);

  //Employer Hiring
  Future<DataState<DataResponseModel>> createEmployerHiring(
      EmployerHiringRequestParams params);

  //Employer Profile Complaint
  Future<DataState<DataResponseModel>> createEmployerComplaint(
      EmployerProfileComplaintRequestParams params);

  //Employer Update Configs
  Future<DataState<DataResponseModel>> updateEmployerConfigs(
      EmployerUpdateConfigsRequestParams params);

  //Employer Exchange Rate
  Future<DataState<DataResponseModel>> employerExchangeRate(
      EmployerExchangeRateRequestParams params);
}
