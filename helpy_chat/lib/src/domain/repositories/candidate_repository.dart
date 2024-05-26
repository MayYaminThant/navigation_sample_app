part of 'repositories.dart';

abstract class CandidateRepository {
  //Candidate Login
  Future<DataState<DataResponseModel>> candidateLogin(
      CandidateLoginRequestParams params);

  //Candidate Logout
  Future<DataState<DataResponseModel>> candidateLogout(
      CandidateLogoutRequestParams params);

  //Candidate Social Login
  Future<DataState<DataResponseModel>> candidateSocialLogin(
      CandidateSocialLoginRequestParams params);

  //Candidate Social Register
  Future<DataState<DataResponseModel>> candidateSocialRegister(
      CandidateSocialRegisterRequestParams params);

  //Candidate Register
  Future<DataState<DataResponseModel>> candidateRegister(
      CandidateRegisterRequestParams params);

  //Candidate Contact Us
  Future<DataState<DataResponseModel>> candidateContactUs(
      CandidateContactUsRequestParams params);

  //Candidate Configs
  Future<DataState<DataResponseModel>> candidateConfigs(CandidateConfigsRequestParams params);

  //Candidate Countries
  Future<DataState<DataResponseModel>> candidateCountries();

  //Candidate Genders
  Future<DataState<DataResponseModel>> candidateGenders();

  //Candidate Language Types
  Future<DataState<DataResponseModel>> candidateLanguageTypes();

  //Candidate Religions
  Future<DataState<DataResponseModel>> candidateReligions();

  //Candidate Profile
  Future<DataState<DataResponseModel>> candidateProfile(
      CandidateRequestParams params);

  //Candidate Create Avatar
  Future<DataState<DataResponseModel>> createCandidateAvatar(
      CandidateCreateAvatarRequestParams params);

  //Candidate Delete Avatar
  Future<DataState<DataResponseModel>> deleteCandidateAvatar(
      CandidateDeleteAvatarRequestParams params);

  //Candidate Ceate About
  Future<DataState<DataResponseModel>> createCandidateAbout(
      CandidateCreateAboutRequestParams params);

  //Candidate Update Family Status
  Future<DataState<DataResponseModel>> updateCandidateFamilyInformation(
      CandidateUpdateFamilyStatusRequestParams params);

  //Candidate Update Skill And Qualification
  Future<DataState<DataResponseModel>> updateCandidateSkillAndQualification(
      CandidateUpdateSkillAndQualificationRequestParams params);

  //Candidate Employments
  Future<DataState<DataResponseModel>> getCandidateEmployments(
      CandidateRequestParams params);

  //Candidate Create Employments
  Future<DataState<DataResponseModel>> createCandidateEmployment(
      CandidateCreateEmploymentRequestParams params);

  //Candidate Update Employments
  Future<DataState<DataResponseModel>> updateCandidateEmployment(
      CandidateUpdateEmploymentRequestParams params);

  //Candidate Delete Employments
  Future<DataState<DataResponseModel>> deleteCandidateEmployment(
      CandidateDeleteEmploymentRequestParams params);

  //Candidate Availability Status
  Future<DataState<DataResponseModel>> getCandidateAvailabilityStatus(
      CandidateRequestParams params);

  //Candidate Update Availability Status
  Future<DataState<DataResponseModel>> updateCandidateAvailabilityStatus(
      CandidateUpdateAvailabilityStatusRequestParams params);

  //Candidate StarList
  Future<DataState<DataResponseModel>> candidateStarList(
      CandidateStarListRequestParams params);

  //Candidate StarList Add
  Future<DataState<DataResponseModel>> candidateStarListAdd(
      CandidateStarListAddRequestParams params);

  //Candidate StarList Remove
  Future<DataState<DataResponseModel>> candidateStarListRemove(
      CandidateStarListRemoveRequestParams params);

  //Candidate Forgot Password
  Future<DataState<DataResponseModel>> candidateForgotPassword(
      CandidateForgotPasswordRequestParams params);

  //Candidate Reset Password
  Future<DataState<DataResponseModel>> candidateResetPassword(
      CandidateResetPasswordRequestParams params);

  //Candidate Update Working Preferences
  Future<DataState<DataResponseModel>> candidateUpdateWorkingPreferences(
      CandidateUpdateWorkingPreferenceRequestParams params);

  //Candidate Spotlights
  Future<DataState<DataResponseModel>> candidateSpotlights(
      CandidateSpotlightsRequestParams params);

  //Candidate Save Search List
  Future<DataState<DataResponseModel>> candidateSaveSearchList(
      CandidateSaveSearchRequestParams params);

  //Candidate Update Save Search
  Future<DataState<DataResponseModel>> candidateUpdateSaveSearch(
      CandidateUpdateSaveSearchRequestParams params);
  
  //Candidate Delete Save Search
  Future<DataState<DataResponseModel>> candidateDeleteSaveSearch(
      CandidateDeleteSaveSearchRequestParams params);
  
  //Candidate Update FCM
  Future<DataState<DataResponseModel>> candidateUpdateFCM(
      CandidateFCMRequestParams params);
  
  //Candidate Update Verification
  Future<DataState<DataResponseModel>> updateVerification(
      CandidateUpdateVerificationRequestParams params);
  
  //Candidate Delete Account
  Future<DataState<DataResponseModel>> deleteCandidateAccount(
      CandidateDeleteAccountRequestParams params);
  
  //Candidate Delete Profile
  Future<DataState<DataResponseModel>> deleteCandidateProfile(
      CandidateDeleteProfileRequestParams params);
  
  //Candidate Create Big Data
  Future<DataState<DataResponseModel>> createCandidateBigData(
      CandidateCreateBigDataRequestParams params);

  //Candidate Delete Big Data
  Future<DataState<DataResponseModel>> deleteCandidateBigData(
      CandidateDeleteBigDataRequestParams params);
  
  //Candidate Reviews
  Future<DataState<DataResponseModel>> getCandidateReviews(
      CandidateReviewsRequestParams params);
  
  //Candidate Create Reviews
  Future<DataState<DataResponseModel>> createCandidateReview(
      CandidateCreateReviewsRequestParams params);
  
  //Candidate Delete Reviews
  Future<DataState<DataResponseModel>> deleteCandidateReview(
      CandidateDeleteReviewsRequestParams params);
  
  //Candidate Coin History
  Future<DataState<DataResponseModel>> candidateCoinListHistory(
      CandidateListCoinHistoryRequestParams params);

  //Candidate Coin History
  Future<DataState<DataResponseModel>> candidateCoinListBalance(
      CandidateListCoinBalanceRequestParams params);

  //Candidate Refer Friend List
  Future<DataState<DataResponseModel>> candidateReferFriendList(
      CandidateReferFriendRequestParams params);
  
  //Candidate Update Account
  Future<DataState<DataResponseModel>> updateCandidateAccount(
      CandidateUpdateAccountRequestParams params);

  //Candidate Employment Sort
  Future<DataState<DataResponseModel>> createCandidateEmploymentSort(
      CandidateCreateEmploymentSortRequestParams params);

  //Candidate Saved Search Notify
  Future<DataState<DataResponseModel>> updateCandidateSavedSearchNotify(
      CandidateNotifySaveSearchRequestParams params);

  //Candidate Update Shareable Link
  Future<DataState<DataResponseModel>> updateCandidateShareableLink(
      CandidateUpdateShareableLinkRequestParams params);
  
  //Candidate Check Verified
  Future<DataState<DataResponseModel>> getCandidateCheckVerified(
      CandidateCheckVerifiedRequestParams params);

  //Candidate Work Permit
  Future<DataState<DataResponseModel>> createCandidateWorkPermit(
      CandidateWorkPermitRequestParams params);
  
  //Candidate Profile Complaint
  Future<DataState<DataResponseModel>> createCandidateComplaint(
      CandidateProfileComplaintRequestParams params);

  //Candidate Update Configs
  Future<DataState<DataResponseModel>> updateCandidateConfigs(
      CandidateUpdateConfigsRequestParams params);

  //Candidate Exchange Rate
  Future<DataState<DataResponseModel>> candidateExchangeRate(
      CandidateExchangeRateRequestParams params);

  //Candidate Offer Action
  Future<DataState<DataResponseModel>> candidateOfferAction(
      CandidateOfferActionRequestParams params);

  
}

