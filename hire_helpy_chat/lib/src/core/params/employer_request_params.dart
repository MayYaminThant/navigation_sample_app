part of 'params.dart';

//Employer Login
class EmployerLoginRequestParams {
  final String? token;
  final String? path;
  final String? email;
  final int? countryCallingCode;
  final int? phoneNumber;
  final String? password;

  EmployerLoginRequestParams(
      {this.token,
      this.path,
      this.email,
      this.countryCallingCode,
      this.phoneNumber,
      this.password});
}

//Employer Logout
class EmployerLogoutRequestParams {
  final String? token;

  EmployerLogoutRequestParams({this.token});
}

//Employer Social Login
class EmployerSocialLoginRequestParams {
  final String? token;
  final String? provider;
  final String? userId;

  EmployerSocialLoginRequestParams({this.token, this.provider, this.userId});
}

//Employer Social Register
class EmployerSocialRegisterRequestParams {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? referCode;
  final String? provider;
  final String? userId;
  final String? appLocale;
  final String? preferredLanguage;

  EmployerSocialRegisterRequestParams(
      {this.firstName,
      this.lastName,
      this.email,
      this.referCode,
      this.provider,
      this.userId,
      this.appLocale,
      this.preferredLanguage});
}

//Employer Register
class EmployerRegisterRequestParams {
  final String? token;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? confrimPassword;
  final String? countryCallingCode;
  final int? phoneNumber;
  final String? verifyMethod;
  final String? referCode;
  final String? requestId;
  final String? appLocale;
  final String? preferredLanguage;

  EmployerRegisterRequestParams(
      {this.token,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.confrimPassword,
      this.countryCallingCode,
      this.phoneNumber,
      this.verifyMethod,
      this.referCode,
      this.requestId,
      this.appLocale,
      this.preferredLanguage});
}

//Employer Contact Us
class EmployerContactUsRequestParams {
  final String? token;
  final String? name;
  final String? email;
  final String? issue;
  final String? message;
  final String? phone;
  final String? loginName;
  final int? canContactViaPhone;
  final int? countryCallingCode;
  final List<File>? images;

  EmployerContactUsRequestParams(
      {this.token,
      this.name,
      this.email,
      this.issue,
      this.message,
      this.phone,
      this.loginName,
      this.canContactViaPhone,
      this.countryCallingCode,
      this.images});
}

//Employer Request Params
class EmployerRequestParams {
  final String? token;
  final int? userId;

  EmployerRequestParams({this.token, this.userId});
}

//Employer Update Availability Status
class EmployerUpdateAvailabilityStatusRequestParams {
  final String? status;
  final String? token;
  final int? userId;

  EmployerUpdateAvailabilityStatusRequestParams(
      {this.status, this.token, this.userId});
}

//Employer Create Avatar(Image/Video Upload)
class EmployerCreateAvatarRequestParams {
  final String? token;
  final File? avatarFile;

  EmployerCreateAvatarRequestParams({this.token, this.avatarFile});
}

//Employer Delete Avatar
class EmployerDeleteAvatarRequestParams {
  final String? token;
  final int? userId;

  EmployerDeleteAvatarRequestParams({this.token, this.userId});
}

//Employer Create About Step(Step 1)
class EmployerCreateAboutRequestParams {
  final String? token;
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? selfDesc;
  final String? expectEmployer;
  final String? countryCallingCode;
  final String? dateOfBirth;
  final String? religion;
  final String? nationality;
  final String? countryOfResidence;
  final String? gender;
  final List<File>? portfolios;
  final String? media;
  final int? updateProgress;
  final int? isEmailVerified;
  final int? isPhoneVerified;

  EmployerCreateAboutRequestParams(
      {this.token,
      this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.selfDesc,
      this.expectEmployer,
      this.countryCallingCode,
      this.dateOfBirth,
      this.religion,
      this.nationality,
      this.countryOfResidence,
      this.gender,
      this.portfolios,
      this.media,
      this.updateProgress,
      this.isEmailVerified,
      this.isPhoneVerified});
}

//Employer Update Family Status
class EmployerUpdateFamilyStatusRequestParams {
  final String? token;
  final String? familyStatus;
  final List<dynamic>? members;
  final String? specialRequestChildren;
  final String? specialRequestElderly;
  final int? updateProgress;
  final String? specialRequestPet;

  EmployerUpdateFamilyStatusRequestParams(
      {this.token,
      this.familyStatus,
      this.members,
      this.specialRequestChildren,
      this.specialRequestElderly,
      this.specialRequestPet,
      this.updateProgress});
}

//Employer Update Skill And Qualification
class EmployerUpdateLanguageParams {
  final String? token;
  final int? userId;
  final bool? proficientEnglish;
  final bool? chineseMandarin;
  final bool? bahasaMelayu;
  final bool? tamil;
  final bool? hokkien;
  final bool? teochew;
  final bool? cantonese;
  final bool? bahasaIndonesian;
  final bool? japanese;
  final bool? korean;
  final bool? french;
  final bool? german;
  final bool? arabic;
  final String? othersSpecify;
  final int? updateProgress;

  EmployerUpdateLanguageParams(
      {this.token,
      this.userId,
      this.proficientEnglish,
      this.chineseMandarin,
      this.bahasaMelayu,
      this.tamil,
      this.hokkien,
      this.teochew,
      this.cantonese,
      this.bahasaIndonesian,
      this.japanese,
      this.korean,
      this.french,
      this.german,
      this.arabic,
      this.othersSpecify,
      this.updateProgress});
}

//Employer Create Employment
class EmployerCreateEmploymentRequestParams {
  final String? token;
  final int? userId;
  final String? workCountryName;
  final String? startDate;
  final String? endDate;
  final bool? dhRelated;
  final String? workDesc;

  EmployerCreateEmploymentRequestParams(
      {this.token,
      this.userId,
      this.workCountryName,
      this.startDate,
      this.endDate,
      this.dhRelated,
      this.workDesc});
}

//Employer Update Employment
class EmployerUpdateEmploymentRequestParams {
  final String? token;
  final int? userId;
  final int? employmentID;
  final String? workCountryName;
  final String? startDate;
  final String? endDate;
  final bool? dhRelated;
  final String? workDesc;

  EmployerUpdateEmploymentRequestParams(
      {this.token,
      this.userId,
      this.employmentID,
      this.workCountryName,
      this.startDate,
      this.endDate,
      this.dhRelated,
      this.workDesc});
}

//Employer Delete Employment
class EmployerDeleteEmploymentRequestParams {
  final String? token;
  final int? employmentID;

  EmployerDeleteEmploymentRequestParams({
    this.token,
    this.employmentID,
  });
}

//Employer StarList
class EmployerStarListRequestParams {
  final String? token;

  EmployerStarListRequestParams({this.token});
}

//Employer Add StarList
class EmployerStarListAddRequestParams {
  final String? token;
  final int? userId;
  final int? candidateId;

  EmployerStarListAddRequestParams({this.token, this.userId, this.candidateId});
}

//Employer Remove StarList
class EmployerStarListRemoveRequestParams {
  final String? token;
  final int? starId;

  EmployerStarListRemoveRequestParams({this.token, this.starId});
}

//Employer Forgot Password
class EmployerForgotPasswordRequestParams {
  final String? path;
  final String? email;
  final int? countryCallingCode;
  final int? phoneNumber;
  EmployerForgotPasswordRequestParams(
      {this.path, this.email, this.countryCallingCode, this.phoneNumber});
}

//Employer Reset Password
class EmployerResetPasswordRequestParams {
  final String? requestId;
  final String? path;
  final String? email;
  final int? countryCallingCode;
  final int? phoneNumber;
  final String? password;
  final String? passwordConfirmation;
  EmployerResetPasswordRequestParams(
      {this.requestId,
      this.path,
      this.email,
      this.countryCallingCode,
      this.phoneNumber,
      this.password,
      this.passwordConfirmation});
}

//Employer Update Working Preferences
class EmployerUpdateWorkingPreferenceRequestParams {
  final String? token;
  final int? restDayWorkPref;
  EmployerUpdateWorkingPreferenceRequestParams(
      {this.token, this.restDayWorkPref});
}

//Employer Spotlights
class EmployerSpotlightsRequestParams {
  final String? category;
  EmployerSpotlightsRequestParams({this.category});
}

//Employer Save Search List
class EmployerSaveSearchRequestParams {
  final String? token;
  final int? userId;
  EmployerSaveSearchRequestParams({this.token, this.userId});
}

//Employer Rename Save Search
class EmployerUpdateSaveSearchRequestParams {
  final String? token;
  final int? saveSearchId;
  final String? name;
  EmployerUpdateSaveSearchRequestParams(
      {this.token, this.saveSearchId, this.name});
}

//Employer Delete Save Search
class EmployerDeleteSaveSearchRequestParams {
  final String? token;
  final int? saveSearchId;
  EmployerDeleteSaveSearchRequestParams({this.token, this.saveSearchId});
}

//Employer FCM
class EmployerFCMRequestParams {
  final String? token;
  final String? fcmToken;
  final int? userId;
  EmployerFCMRequestParams({this.token, this.fcmToken, this.userId});
}

//Canditate List Voucher History
class EmployerListVoucherHistoryRequestParams {
  final String? token;
  final int? userId;
  EmployerListVoucherHistoryRequestParams({this.token, this.userId});
}

//Employer Coin Balance
class EmployerCoinBalanceRequestParams {
  final String? token;
  final int? userId;
  EmployerCoinBalanceRequestParams({this.token, this.userId});
}

//Employer Update Verification
class EmployerUpdateVerificationRequestParams {
  final String? token;
  final String? requestId;
  final int? userId;
  final String? method;
  final String? email;
  final int? countryCode;
  final int? phoneNumber;

  EmployerUpdateVerificationRequestParams(
      {this.token,
      this.requestId,
      this.userId,
      this.method,
      this.email,
      this.countryCode,
      this.phoneNumber});
}

//Employer Delete Account
class EmployerDeleteAccountRequestParams {
  final String? token;
  final int? userId;
  EmployerDeleteAccountRequestParams({this.token, this.userId});
}

//Employer Delete Profile
class EmployerDeleteProfileRequestParams {
  final String? token;
  final int? employerId;
  EmployerDeleteProfileRequestParams({this.token, this.employerId});
}

//Employer Offer
class EmployerCreateOfferRequestParams {
  final String? token;
  final int? userId;
  final String? countryOfWorkOffer;
  final String? dhNationality;
  final int? salary;
  final String? currency;
  final String? availableStartDate;
  final String? availableEndDate;
  final String? nationality;
  final String? religion;
  final int? skillInfantCare;
  final int? skillSpecialNeedsCare;
  final int? skillElderlyCare;
  final int? skillCooking;
  final int? skillGeneralHousework;
  final int? skillPetCare;
  final int? skillHandicapCare;
  final int? skillBedriddenCare;
  final int? processFee;
  final int? restDayChoice;
  final int? restDayWorkPref;
  final String? availabilityStatus;

  EmployerCreateOfferRequestParams(
      {this.token,
      this.userId,
      this.countryOfWorkOffer,
      this.dhNationality,
      this.salary,
      this.currency,
      this.availableStartDate,
      this.availableEndDate,
      this.nationality,
      this.religion,
      this.skillInfantCare,
      this.skillSpecialNeedsCare,
      this.skillElderlyCare,
      this.skillCooking,
      this.skillGeneralHousework,
      this.skillPetCare,
      this.skillHandicapCare,
      this.skillBedriddenCare,
      this.processFee,
      this.restDayChoice,
      this.restDayWorkPref,
      this.availabilityStatus});
}

//Employer Delete Offer
class EmployerDeleteOfferRequestParams {
  final String? token;
  final int? userId;
  EmployerDeleteOfferRequestParams({this.token, this.userId});
}

//Employer Reviews
class EmployerReviewsRequestParams {
  final String? token;
  final int? userId;
  EmployerReviewsRequestParams({this.token, this.userId});
}

//Employer Create Reviews
class EmployerCreateReviewsRequestParams {
  final String? token;
  final int? onUserId;
  final int? byUserId;
  final String? review;
  final int? reviewStarRating;

  EmployerCreateReviewsRequestParams(
      {this.token,
      this.onUserId,
      this.byUserId,
      this.review,
      this.reviewStarRating});
}

//Employer Delete Reviews
class EmployerDeleteReviewsRequestParams {
  final String? token;
  final int? reviewId;

  EmployerDeleteReviewsRequestParams({this.token, this.reviewId});
}

//Employer Refer Friend List
class EmployerReferFriendRequestParams {
  final String? token;
  final int? userId;
  EmployerReferFriendRequestParams({this.token, this.userId});
}

//Employer Account Update
class EmployerUpdateAccountRequestParams {
  final String? token;
  final int? userId;
  final File? avatar;
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? countryCallingCode;
  final int? phoneNumber;
  final int? isEmailVerified;
  final int? isPhoneVerified;

  EmployerUpdateAccountRequestParams(
      {this.token,
      this.userId,
      this.avatar,
      this.firstName,
      this.lastName,
      this.email,
      this.countryCallingCode,
      this.phoneNumber,
      this.isEmailVerified,
      this.isPhoneVerified});
}

//Employer Create Employment Sorting
class EmployerCreateEmploymentSortRequestParams {
  final String? token;
  final List<int>? employments;

  EmployerCreateEmploymentSortRequestParams({this.token, this.employments});
}

//Employer Notify Save Search
class EmployerNotifySaveSearchRequestParams {
  final String? token;
  final int? savedSearchId;
  final int? userId;

  EmployerNotifySaveSearchRequestParams(
      {this.token, this.savedSearchId, this.userId});
}

//Employer Update Shareable Link
class EmployerUpdateShareableLinkRequestParams {
  final String? token;
  final int? userId;
  final String? link;

  EmployerUpdateShareableLinkRequestParams(
      {this.token, this.userId, this.link});
}

//Employer Check Verified
class EmployerCheckVerifiedRequestParams {
  final String? type;
  final String? email;
  final int? countryCode;
  final int? phoneNumber;

  EmployerCheckVerifiedRequestParams(
      {this.type, this.email, this.countryCode, this.phoneNumber});
}

//Employer Hiring
class EmployerHiringRequestParams {
  final String? token;
  final int? countryCallingCode;
  final int? phoneNumber;
  final String? fromTime;
  final String? toTime;
  final String? currency;
  final int? salary;
  final String? expiryDate;
  final int? candidateID;

  EmployerHiringRequestParams(
      {this.token,
      this.countryCallingCode,
      this.phoneNumber,
      this.fromTime,
      this.toTime,
      this.currency,
      this.salary,
      this.expiryDate,
      this.candidateID});
}

//Employer Profile Complaint
class EmployerProfileComplaintRequestParams {
  final String? token;
  final int? userId;

  EmployerProfileComplaintRequestParams({this.token, this.userId});
}

//Employer Update Configs
class EmployerUpdateConfigsRequestParams {
  final String? token;
  final String? path;
  final String? appLocale;
  final String? preferredLanguage;

  EmployerUpdateConfigsRequestParams(
      {this.token, this.path, this.appLocale, this.preferredLanguage});
}

//Employer Configs
class EmployerConfigsRequestParams {
  final String? lastTimestamp;

  EmployerConfigsRequestParams({this.lastTimestamp});
}

//Exchange
class EmployerExchangeRateRequestParams {
  final String? base;
  final String? target;
  final double? baseAmount;

  EmployerExchangeRateRequestParams({this.base, this.target, this.baseAmount});
}

//Salary Range Exchange
class EmployerPHCSalaryRangeExchangeRequestParams {
  final String targetCurrency;
  final double phcSalaryMin;
  final double phcSalaryMax;
  EmployerPHCSalaryRangeExchangeRequestParams(
      {required this.targetCurrency,
        required this.phcSalaryMax,
        required this.phcSalaryMin});
}
