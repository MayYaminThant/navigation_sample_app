part of 'params.dart';

//Candidate Login
class CandidateLoginRequestParams {
  final String? token;
  final String? path;
  final String? email;
  final int? countryCallingCode;
  final int? phoneNumber;
  final String? password;
  final String? fcmToken;

  CandidateLoginRequestParams(
      {this.token,
      this.path,
      this.email,
      this.countryCallingCode,
      this.phoneNumber,
      this.password,
      this.fcmToken});
}

//Candidate Logout
class CandidateLogoutRequestParams {
  final String? token;

  CandidateLogoutRequestParams({this.token});
}

//Candidate Social Login
class CandidateSocialLoginRequestParams {
  final String? token;
  final String? provider;
  final String? userId;
  final String? fcmToken;

  CandidateSocialLoginRequestParams(
      {this.token, this.provider, this.userId, this.fcmToken});
}

//Candidate Social Register
class CandidateSocialRegisterRequestParams {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? referCode;
  final String? provider;
  final String? userId;
  final String? appLocale;
  final String? preferredLanguage;

  CandidateSocialRegisterRequestParams(
      {this.firstName,
      this.lastName,
      this.email,
      this.referCode,
      this.provider,
      this.userId,
      this.appLocale,
      this.preferredLanguage});
}

//Candidate Register
class CandidateRegisterRequestParams {
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

  CandidateRegisterRequestParams(
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

//Candidate Contact Us
class CandidateContactUsRequestParams {
  final String? token;
  final String? name;
  final String? email;
  final String? issue;
  final String? message;
  final String? phone;
  final int? countryCallingCode;
  final String? loginName;
  final int? canContactViaPhone;
  final List<File>? images;
  final List<File>? thumbnails;

  CandidateContactUsRequestParams(
      {this.token,
      this.name,
      this.email,
      this.issue,
      this.message,
      this.phone,
      this.countryCallingCode,
      this.loginName,
      this.canContactViaPhone,
      this.images,
      this.thumbnails});
}

//Candidate Request Params
class CandidateRequestParams {
  final String? token;
  final int? userId;

  CandidateRequestParams({this.token, this.userId});
}

//Candidate Update Availability Status
class CandidateUpdateAvailabilityStatusRequestParams {
  final String? status;
  final String? token;
  final int? userId;

  CandidateUpdateAvailabilityStatusRequestParams(
      {this.status, this.token, this.userId});
}

//Candidate Create Avatar(Image/Video Upload)
class CandidateCreateAvatarRequestParams {
  final String? token;
  final File? avatarFile;

  CandidateCreateAvatarRequestParams({this.token, this.avatarFile});
}

//Candidate Delete Avatar
class CandidateDeleteAvatarRequestParams {
  final String? token;
  final int? userId;

  CandidateDeleteAvatarRequestParams({this.token, this.userId});
}

//Candidate Create About Step(Step 1)
class CandidateCreateAboutRequestParams {
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
  final double? height;
  final double? weight;
  final String? religion;
  final String? nationality;
  final String? countryOfResidence;
  final String? gender;
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
  final List<File>? portfolios;
  final List<File>? thumbnails;
  final String? media;
  final int? updateProgress;
  final int? isEmailVerified;
  final int? isPhoneVerified;

  CandidateCreateAboutRequestParams({
    this.token,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.selfDesc,
    this.expectEmployer,
    this.countryCallingCode,
    this.dateOfBirth,
    this.height,
    this.weight,
    this.religion,
    this.nationality,
    this.countryOfResidence,
    this.gender,
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
    this.portfolios,
    this.media,
    this.updateProgress,
    this.isEmailVerified,
    this.isPhoneVerified,
    this.thumbnails,
  });
}

//Candidate Update Family Status
class CandidateUpdateFamilyStatusRequestParams {
  final String? token;
  final int? userId;
  final String? familyStatus;
  final int? numOfSiblings;
  final List<dynamic>? members;
  final int? updateProgress;

  CandidateUpdateFamilyStatusRequestParams(
      {this.token,
      this.userId,
      this.familyStatus,
      this.numOfSiblings,
      this.members,
      this.updateProgress});
}

//Candidate Update Skill And Qualification
class CandidateUpdateSkillAndQualificationRequestParams {
  final String? token;
  final int? userId;
  final String? highestQualification;
  final String? educationJourneyDesc;
  final bool? skillInfantCare;
  final bool? skillSpecialNeedsCare;
  final bool? skillElderlyCare;
  final bool? skillCooking;
  final bool? skillGeneralHousework;
  final bool? skillPetCare;
  final bool? skillHandicapCare;
  final bool? skillBedriddenCare;
  final String? skillOthersSpecify;
  final int? updateProgress;
  final String? workPermitFinNumberHash;
  final String? workPermitIssueCountryName;

  CandidateUpdateSkillAndQualificationRequestParams(
      {this.token,
      this.userId,
      this.highestQualification,
      this.educationJourneyDesc,
      this.skillInfantCare,
      this.skillSpecialNeedsCare,
      this.skillElderlyCare,
      this.skillCooking,
      this.skillGeneralHousework,
      this.skillPetCare,
      this.skillHandicapCare,
      this.skillBedriddenCare,
      this.skillOthersSpecify,
      this.updateProgress,
      this.workPermitFinNumberHash,
      this.workPermitIssueCountryName});
}

//Candidate Create Employment
class CandidateCreateEmploymentRequestParams {
  final String? token;
  final int? userId;
  final String? workCountryName;
  final String? startDate;
  final String? endDate;
  final int? dhRelated;
  final String? workDesc;
  final int? displayOrder;

  CandidateCreateEmploymentRequestParams(
      {this.token,
      this.userId,
      this.workCountryName,
      this.startDate,
      this.endDate,
      this.dhRelated,
      this.workDesc,
      this.displayOrder});
}

//Candidate Update Employment
class CandidateUpdateEmploymentRequestParams {
  final String? token;
  final int? userId;
  final int? employmentID;
  final String? workCountryName;
  final String? startDate;
  final String? endDate;
  final int? dhRelated;
  final String? workDesc;

  CandidateUpdateEmploymentRequestParams(
      {this.token,
      this.userId,
      this.employmentID,
      this.workCountryName,
      this.startDate,
      this.endDate,
      this.dhRelated,
      this.workDesc});
}

//Candidate Delete Employment
class CandidateDeleteEmploymentRequestParams {
  final String? token;
  final int? employmentID;

  CandidateDeleteEmploymentRequestParams({
    this.token,
    this.employmentID,
  });
}

//Candidate StarList
class CandidateStarListRequestParams {
  final String? token;

  CandidateStarListRequestParams({this.token});
}

//Candidate Add StarList
class CandidateStarListAddRequestParams {
  final String? token;
  final int? userId;
  final int? employerId;

  CandidateStarListAddRequestParams({this.token, this.userId, this.employerId});
}

//Candidate Remove StarList
class CandidateStarListRemoveRequestParams {
  final String? token;
  final int? starId;

  CandidateStarListRemoveRequestParams({this.token, this.starId});
}

//Candidate Forgot Password
class CandidateForgotPasswordRequestParams {
  final String? path;
  final String? email;
  final int? countryCallingCode;
  final int? phoneNumber;

  CandidateForgotPasswordRequestParams(
      {this.path, this.email, this.countryCallingCode, this.phoneNumber});
}

//Candidate Reset Password
class CandidateResetPasswordRequestParams {
  final String? requestId;
  final String? path;
  final String? email;
  final int? countryCallingCode;
  final int? phoneNumber;
  final String? password;
  final String? passwordConfirmation;

  CandidateResetPasswordRequestParams(
      {this.requestId,
      this.path,
      this.email,
      this.countryCallingCode,
      this.phoneNumber,
      this.password,
      this.passwordConfirmation});
}

//Candidate Update Working Preferences
class CandidateUpdateWorkingPreferenceRequestParams {
  final String? token;
  final int? userId;
  final int? restDayChoice;
  final int? restDayWorkPref;
  final String? foodAllergy;
  final String? drugAllergy;
  final String? additionalWorkPref;
  final List<dynamic>? tasks;
  final int? updateProgress;

  CandidateUpdateWorkingPreferenceRequestParams(
      {this.token,
      this.userId,
      this.restDayChoice,
      this.restDayWorkPref,
      this.foodAllergy,
      this.drugAllergy,
      this.additionalWorkPref,
      this.tasks,
      this.updateProgress});
}

//Candidate Spotlights
class CandidateSpotlightsRequestParams {
  final String? category;

  CandidateSpotlightsRequestParams({this.category});
}

//Candidate Save Search List
class CandidateSaveSearchRequestParams {
  final String? token;
  final int? userId;

  CandidateSaveSearchRequestParams({this.token, this.userId});
}

//Candidate Rename Save Search
class CandidateUpdateSaveSearchRequestParams {
  final String? token;
  final int? saveSearchId;
  final String? name;

  CandidateUpdateSaveSearchRequestParams(
      {this.token, this.saveSearchId, this.name});
}

//Candidate Delete Save Search
class CandidateDeleteSaveSearchRequestParams {
  final String? token;
  final int? saveSearchId;

  CandidateDeleteSaveSearchRequestParams({this.token, this.saveSearchId});
}

//Candidate FCM
class CandidateFCMRequestParams {
  final String? token;
  final String? fcmToken;
  final int? userId;

  CandidateFCMRequestParams({this.token, this.fcmToken, this.userId});
}

//Canditate List Coin History
class CandidateListCoinHistoryRequestParams {
  final String? token;
  final int? userId;

  CandidateListCoinHistoryRequestParams({this.token, this.userId});
}

//Canditate List Coin Balance
class CandidateListCoinBalanceRequestParams {
  final String? token;

  CandidateListCoinBalanceRequestParams({this.token});
}

//Candidate Update Verification
class CandidateUpdateVerificationRequestParams {
  final String? token;
  final String? requestId;
  final int? userId;
  final String? method;
  final String? email;
  final int? countryCode;
  final int? phoneNumber;

  CandidateUpdateVerificationRequestParams(
      {this.token,
      this.requestId,
      this.userId,
      this.method,
      this.email,
      this.countryCode,
      this.phoneNumber});
}

//Candidate Delete Account
class CandidateDeleteAccountRequestParams {
  final String? token;
  final int? userId;

  CandidateDeleteAccountRequestParams({this.token, this.userId});
}

//Candidate Delete Profile
class CandidateDeleteProfileRequestParams {
  final String? token;
  final int? candidateId;

  CandidateDeleteProfileRequestParams({this.token, this.candidateId});
}

//Candidate Big Data
class CandidateCreateBigDataRequestParams {
  final String? token;
  final int? userId;
  final String? countryOfWork;
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
  final int? languageProficientEnglish;
  final int? languageChineseMandarin;
  final int? languageBahasaMelayu;
  final int? languageTamil;
  final int? languageHokkien;
  final int? languageTeochew;
  final int? languageCantonese;
  final int? languageBahasaIndonesian;
  final int? languageJapanese;
  final int? languageKorean;
  final int? languageFrench;
  final int? languageGerman;
  final int? languageArabic;
  final int? agentFee;
  final String? countryOfResidence;
  final String? availabilityStatus;
  final int? restDayChoice;
  final int? restDayWorkPref;
  final int? age;

  CandidateCreateBigDataRequestParams(
      {this.token,
      this.userId,
      this.countryOfWork,
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
      this.languageProficientEnglish,
      this.languageChineseMandarin,
      this.languageBahasaMelayu,
      this.languageTamil,
      this.languageHokkien,
      this.languageTeochew,
      this.languageCantonese,
      this.languageBahasaIndonesian,
      this.languageJapanese,
      this.languageKorean,
      this.languageFrench,
      this.languageGerman,
      this.languageArabic,
      this.agentFee,
      this.countryOfResidence,
      this.availabilityStatus,
      this.restDayChoice,
      this.restDayWorkPref,
      this.age});
}

//Candidate Delete Big Data
class CandidateDeleteBigDataRequestParams {
  final String? token;
  final int? userId;

  CandidateDeleteBigDataRequestParams({this.token, this.userId});
}

//Candidate Reviews
class CandidateReviewsRequestParams {
  final String? token;
  final int? userId;

  CandidateReviewsRequestParams({this.token, this.userId});
}

//Candidate Create Reviews
class CandidateCreateReviewsRequestParams {
  final String? token;
  final int? onUserId;
  final int? byUserId;
  final String? review;
  final int? reviewStarRating;

  CandidateCreateReviewsRequestParams(
      {this.token,
      this.onUserId,
      this.byUserId,
      this.review,
      this.reviewStarRating});
}

//Candidate Delete Reviews
class CandidateDeleteReviewsRequestParams {
  final String? token;
  final int? reviewId;

  CandidateDeleteReviewsRequestParams({this.token, this.reviewId});
}

//Candidate Refer Friend List
class CandidateReferFriendRequestParams {
  final String? token;
  final int? userId;

  CandidateReferFriendRequestParams({this.token, this.userId});
}

//Candidate Account Update
class CandidateUpdateAccountRequestParams {
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

  CandidateUpdateAccountRequestParams(
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

//Candidate Create Employment Sorting
class CandidateCreateEmploymentSortRequestParams {
  final String? token;
  final List<int>? employments;

  CandidateCreateEmploymentSortRequestParams({this.token, this.employments});
}

//Candidate Notify Save Search
class CandidateNotifySaveSearchRequestParams {
  final String? token;
  final int? savedSearchId;
  final int? userId;

  CandidateNotifySaveSearchRequestParams(
      {this.token, this.savedSearchId, this.userId});
}

//Candidate Update Shareable Link
class CandidateUpdateShareableLinkRequestParams {
  final String? token;
  final int? userId;
  final String? link;

  CandidateUpdateShareableLinkRequestParams(
      {this.token, this.userId, this.link});
}

//Candidate Check Verified
class CandidateCheckVerifiedRequestParams {
  final String? type;
  final String? email;
  final int? countryCode;
  final int? phoneNumber;

  CandidateCheckVerifiedRequestParams(
      {this.type, this.email, this.countryCode, this.phoneNumber});
}

//Candidate Work Permit
class CandidateWorkPermitRequestParams {
  final String? token;
  final String? dob;
  final String? fin;
  final String? country;
  final File? workPermitFrontFile;
  final File? workPermitBackFile;

  CandidateWorkPermitRequestParams({
    this.token,
    this.dob,
    this.fin,
    this.country,
    this.workPermitFrontFile,
    this.workPermitBackFile,
  });
}

//Candidate Profile Complaint
class CandidateProfileComplaintRequestParams {
  final String? token;
  final int? userId;

  CandidateProfileComplaintRequestParams({this.token, this.userId});
}

//Candidate Update Configs
class CandidateUpdateConfigsRequestParams {
  final String? token;
  final String? path;
  final String? appLocale;
  final String? preferredLanguage;

  CandidateUpdateConfigsRequestParams(
      {this.token, this.path, this.appLocale, this.preferredLanguage});
}

//Candidate Configs
class CandidateConfigsRequestParams {
  final String? lastTimestamp;

  CandidateConfigsRequestParams({this.lastTimestamp});
}

//Exchange
class CandidateExchangeRateRequestParams {
  final String? base;
  final String? target;
  final double? baseAmount;

  CandidateExchangeRateRequestParams({this.base, this.target, this.baseAmount});
}

//Exchange salary range
class CandidatePHCSalaryRangeExchangeRequestParams {
  final String targetCurrency;
  final double phcSalaryMin;
  final double phcSalaryMax;

  CandidatePHCSalaryRangeExchangeRequestParams(
      {required this.targetCurrency,
      required this.phcSalaryMax,
      required this.phcSalaryMin});
}

//Offer Action
class CandidateOfferActionRequestParams {
  final int? notificationId;
  final String? action;
  final int? employerId;
  final String? token;

  CandidateOfferActionRequestParams(
      {this.notificationId, this.action, this.employerId, this.token});
}
