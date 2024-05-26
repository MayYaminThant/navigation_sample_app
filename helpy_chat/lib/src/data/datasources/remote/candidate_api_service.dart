import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/models.dart';

part 'candidate_api_service.g.dart';

@RestApi()
abstract class CandidateApiService {
  factory CandidateApiService(Dio dio, {String baseUrl}) = _CandidateApiService;

  //Candidate Login
  @POST('/candidate/login/{path}')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createUserLogin(
      {@Header("Accept") String? acceptType,
      @Path("path") String? path,
      @Field("country_calling_code") int? countryCallingCode,
      @Field("phone_number") int? phoneNumber,
      @Field("email") String? email,
      @Field("password") String? password,
      @Field("fcm_token") String? fcmToken});

  //Candidate Logout
  @POST('/candidate/logout')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> userLogout({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Candidate Social Login
  @POST('/candidate/login/social')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createSocialLogin(
      {@Header("Accept") String? acceptType,
      @Field("provider") String? provider,
      @Field("user_id") String? userId,
      @Field("fcm_token") String? fcmToken});

  //Candidate Social Register
  @POST('/candidate/social/register')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createSocialRegister({
    @Header("Accept") String? acceptType,
    @Field("first_name") String? firstName,
    @Field("last_name") String? lastName,
    @Field("email") String? email,
    @Field("app_alpha2_code") String? appAlpha2Code,
    @Field("provider") String? provider,
    @Field("user_id") String? userId,
    @Field("refer_code") String? referCode,
    @Field("preferred_language") String? preferredLanguage,
    @Field("app_locale") String? appLocale,
  });

  //Candidate Register
  @POST('/candidate/register')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createUserRegister({
    @Header("Accept") String? acceptType,
    @Field("first_name") String? firstName,
    @Field("last_name") String? lastName,
    @Field("email") String? email,
    @Field("password") String? password,
    @Field("country_calling_code") String? countryCallingCode,
    @Field("phone_number") int? phoneNumber,
    @Field("verified_method") String? verifiedMethod,
    @Field("refer_code") String? referCode,
    @Field("request_id") String? requestId,
    @Field("preferred_language") String? preferredLanguage,
    @Field("app_locale") String? appLocale,
  });

  //Contact Us
  @POST('/candidate/contact')
  @MultiPart()
  Future<HttpResponse<DataResponseModel>> createCandidateContactUs({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? defaultToken,
    @Part(name: "name") String? name,
    @Part(name: "email") String? email,
    @Part(name: "issue") String? issue,
    @Part(name: "message") String? message,
    @Part(name: "phone_number") String? phone,
    @Part(name: "login_name") String? loginName,
    @Part(name: "country_calling_code") int? countryCallingCode,
    @Part(name: "can_contact_via_phone") int? canContactViaPhone,
    @Part(name: 'images[]') List<File>? images,
    @Part(name: 'thumbnails[]') List<File>? thumbnails,
  });

  //Candidate Configs
  @GET('/candidate/configs')
  Future<HttpResponse<DataResponseModel>> getCandidateConfigs({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Query("last_timestamp") String? lastTimestamp,
  });

  //Candidate Countries
  @GET('/candidate/countries')
  Future<HttpResponse<DataResponseModel>> getCandidateCountries({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Candidate Genders
  @GET('/candidate/genders')
  Future<HttpResponse<DataResponseModel>> getCandidateGenders({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Candidate Language Types
  @GET('/candidate/language_type')
  Future<HttpResponse<DataResponseModel>> getCandidateLanguageTypes(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Query("app_silo") String? appSilo});

  //Candidate Religions
  @GET('/candidate/religions')
  Future<HttpResponse<DataResponseModel>> getCandidateReligions({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Candidate Profile
  @GET('/candidate/profile/detail')
  Future<HttpResponse<DataResponseModel>> getCandidateProfile(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Path("candidateId") int? userId});

  //Candidate Ceate About
  @POST('/candidate/profile/about')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createCandidateAbout(
      {@Header("Accept")
          String? acceptType,
      @Header("Authorization")
          String? token,
      @Part(name: "self_desc")
          String? selfDesc,
      @Part(name: "expect_employer")
          String? expectedEmployer,
      @Part(name: "first_name")
          String? firstName,
      @Part(name: "last_name")
          String? lastName,
      @Part(name: "email")
          String? email,
      @Part(name: "country_calling_code")
          String? countryCallingCode,
      @Part(name: "phone_number")
          String? phoneNumber,
      @Part(name: "date_of_birth")
          String? dateOfBirth,
      @Part(name: "height_cm")
          double? height,
      @Part(name: "weight_g")
          double? weight,
      @Part(name: "religion")
          String? religion,
      @Part(name: "nationality")
          String? nationality,
      @Part(name: "country_of_residence")
          String? countryOfResidence,
      @Part(name: "gender")
          String? gender,
      @Part(name: "languages[language_proficient_english]")
          int? proficientEnglish,
      @Part(name: "languages[language_chinese_mandarin]")
          int? chineseMandarin,
      @Part(name: "languages[language_bahasa_melayu]")
          int? bahasaMelayu,
      @Part(name: "languages[language_tamil]")
          int? tamil,
      @Part(name: "languages[language_hokkien]")
          int? hokkien,
      @Part(name: "languages[language_teochew]")
          int? teochew,
      @Part(name: "languages[language_cantonese]")
          int? cantonese,
      @Part(name: "languages[language_bahasa_indonesian]")
          int? bahasaIndonesian,
      @Part(name: "languages[language_japanese]")
          int? japanese,
      @Part(name: "languages[language_korean]")
          int? korean,
      @Part(name: "languages[language_french]")
          int? french,
      @Part(name: "languages[language_german]")
          int? german,
      @Part(name: "languages[language_arabic]")
          int? arabic,
      @Part(name: "language_others_specify")
          String? othersSpecify,
      @Part(name: "media")
          String? media,
      @Part(name: "update_progress")
          int? updateProgress,
      @Part(name: "is_email_verified")
          int? isEmailVerified,
      @Part(name: "is_phone_verified")
          int? isPhoneVerified});

  // single file upload
  @POST('/candidate')
  @MultiPart()
  Future<HttpResponse<DataResponseModel>> singleFileUploadProfile({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Part(name: 'portfolio') File? portfolio,
    @Part(name: 'thumbnail') File? thumbnail,
  });

  //Candidate Update Family Status
  @POST('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateCandidateFamilyInformation(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("family_status") String? familyStatus,
      @Field("num_of_siblings") int? numOfSiblings,
      @Field("members") List<dynamic>? members,
      @Field("update_progress") int? updateProgress});

  //Candidate Update Skill And Qualification
  @POST('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateCandidateSkillAndQualification(
      {@Header("Accept")
          String? acceptType,
      @Header("Authorization")
          String? token,
      @Field("highest_qualification")
          String? highestQualification,
      @Field("education_journey_desc")
          String? educationJourneyDesc,
      @Field("skills[skill_infant_care]")
          int? skillInfantCare,
      @Field("skills[skill_special_needs_care]")
          int? skillSpecialNeedsCare,
      @Field("skills[skill_elderly_care]")
          int? skillElderlyCare,
      @Field("skills[skill_cooking]")
          int? skillCooking,
      @Field("skills[skill_general_housework]")
          int? skillGeneralHousework,
      @Field("skills[skill_pet_care]")
          int? skillPetCare,
      @Field("skills[skill_handicap_care]")
          int? skillHandicapCare,
      @Field("skills[skill_bedridden_care]")
          int? skillBedriddenCare,
      @Field("skill_others_specify")
          String? skillOthersSpecify,
      @Field("work_permit_fin_number_hash")
          String? workPermitFinNumberHash,
      @Field("work_permit_issue_country_name")
          String? workPermitIssueCountryName,
      @Field("update_progress")
          int? updateProgress});

  //Candidate Employments
  @GET('/candidate/employments')
  Future<HttpResponse<DataResponseModel>> getCandidateEmployments({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Candidate Create Employments
  @POST('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createCandidateEmployment({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field("work_country_name") String? countryName,
    @Field("display_order") int? displayOrder,
    @Field("start_date") String? startDate,
    @Field("end_date") String? endDate,
    @Field("work_desc") String? workDesc,
    @Field("dh_related") int? dhRelated,
  });

  //Candidate Update Employments
  @PUT('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateCandidateEmployment({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("id") int? employmentId,
    @Field("user_id") int? userId,
    @Field("start_date") String? startDate,
    @Field("end_date") String? endDate,
    @Field("work_country_name") String? countryName,
    @Field("work_desc") String? workDesc,
    @Field("dh_related") int? dhRelated,
  });

  //Candidate Delete Employments
  @DELETE('/candidate')
  Future<HttpResponse<DataResponseModel>> deleteCandidateEmployment({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("id") int? employmentId,
  });

  //Candidate Availability Status
  @GET('/candidate/availability_status')
  Future<HttpResponse<DataResponseModel>> getCandidateAvailabilityStatus(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Query("app_silo") String? appSilo});

  //Candidate Update Availability Status
  @PUT('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateCandidateAvailabilityStatus({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field("user_id") int? userId,
    @Field("status") String? status,
  });

  //Candidate StarList
  @GET('/candidate/stars')
  Future<HttpResponse<DataResponseModel>> getCandidateStarsList({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Candidate add StarList
  @POST('/candidate')
  Future<HttpResponse<DataResponseModel>> postCandidateStarsList({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field("employer_id") int? employerId,
  });

  //Candidate Remove StarList
  @DELETE('/candidate')
  Future<HttpResponse<DataResponseModel>> removeCandidateStarsList(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Path("star_id") int? starId});

  //Candidate Forgot Password
  @POST('/candidate/forgot-password/{path}')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createCandidateForgotPassword({
    @Header("Accept") String? acceptType,
    @Path("path") String? path,
    @Field("country_calling_code") int? countryCallingCode,
    @Field("phone_number") int? phoneNumber,
    @Field("email") String? email,
  });

  //Candidate Reset Password
  @POST('/candidate/reset-password/{path}')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createCandidateResetPassword({
    @Header("Accept") String? acceptType,
    @Path("path") String? path,
    @Field("request_id") String? requestId,
    @Field("country_calling_code") int? countryCallingCode,
    @Field("phone_number") int? phoneNumber,
    @Field("email") String? email,
    @Field("password") String? password,
  });

  //Candidate Update Work Preference
  @POST('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateCandidateWorkPreference(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("rest_day_per_month_choice") int? restDayChoice,
      @Field("rest_day_work_pref") int? restDayWorkPref,
      @Field("food_drug_allergy") String? foodAllergy,
      @Field("additional_work_pref") String? additionalWorkPref,
      @Field("tasks") List<dynamic>? tasks,
      @Field("update_progress") int? updateProgress});

  //Candidate Spotlights
  @POST('/candidate/spotlights')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createCandidateSpotlights({
    @Header("Accept") String? acceptType,
    @Field("category") String? category,
  });

  //Candidate Save Search List
  @GET('/candidate')
  Future<HttpResponse<DataResponseModel>> candidateSaveSearchList(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token});

  //Candidate Update Save Search
  @PUT('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateCandidateSaveSearch(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("id") int? saveSearchId,
      @Field("name") String? name});

  //Candidate Delete Save Search
  @DELETE('/candidate')
  Future<HttpResponse<DataResponseModel>> deleteCandidateSaveSearch(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Path("candidateSavedSearch") int? saveSearchId});

  //Candidate FCM
  @POST('/candidate/fcm_token')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createCandidateFCMTOken(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("fcm_token") String? fcmToken,
      @Field("user_id") int? userId});

  //Candidate Upload Avatar
  @POST('/candidate/avatar')
  @MultiPart()
  Future<HttpResponse<DataResponseModel>> createCandidateAvatar(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Part(name: 'avatar', contentType: "image/png") File? avatar});

  //Candidate Delete Avatar
  @DELETE('/candidate/avatar')
  Future<HttpResponse<DataResponseModel>> deleteCandidateAvatar({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Candidate Update Verification
  @POST('/candidate/update_verification')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createCandidateVerification({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field('request_id') String? requestId,
    @Field('verified_method') String? method,
    @Field('email') String? email,
    @Field('country_calling_code') int? countryCallingCode,
    @Field('phone_number') int? phoneNumber,
  });

  //Candidate Account
  @DELETE('/candidate/account')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> deleteCandidateAccount({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Candidate Profile Delete
  @DELETE('/candidate/profile/{candidateId}')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> deleteCandidateProfile({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path('candidateId') int? candidateId,
  });

  //Candidate Big Data
  @POST('/candidate/bid')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createCandidateBId(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field('country_of_work') String? countryOfWork,
      @Field('salary') int? salary,
      @Field('currency') String? currency,
      @Field('start_date') String? availableStartDate,
      @Field('end_date') String? availableEndDate,
      @Field('religion') String? religion,
      @Field('rest_day_per_month_choice') int? restDayChoice,
      @Field('rest_day_work_pref') int? restDayWorkPref,
      @Field("skill_infant_care") int? skillInfantCare,
      @Field("skill_special_needs_care") int? skillSpecialNeedsCare,
      @Field("skill_elderly_care") int? skillElderlyCare,
      @Field("skill_cooking") int? skillCooking,
      @Field("skill_general_housework") int? skillGeneralHousework,
      @Field("skill_pet_care") int? skillPetCare,
      @Field("skill_handicap_care") int? skillHandicapCare,
      @Field("skill_bedridden_care") int? skillBedriddenCare,
      // @Field("language_proficient_english") int? proficientEnglish,
      // @Field("language_chinese_mandarin") int? chineseMandarin,
      // @Field("language_bahasa_melayu") int? bahasaMelayu,
      // @Field("language_tamil") int? tamil,
      // @Field("language_hokkien") int? hokkien,
      // @Field("language_teochew") int? teochew,
      // @Field("language_cantonese") int? cantonese,
      // @Field("language_bahasa_indonesian") int? bahasaIndonesian,
      // @Field("language_japanese") int? japanese,
      // @Field("language_korean") int? korean,
      // @Field("language_french") int? french,
      // @Field("language_german") int? german,
      // @Field("language_arabic") int? arabic,
      // @Field("agent_fee") int? agentFee,
      // @Field("country_of_residence") String? countryOfResidence,
      @Field("age") int? age,
      @Field("availability_status") String? availabilityStatus});

  //Candidate Delete Big Data
  @DELETE('/candidate/bid')
  Future<HttpResponse<DataResponseModel>> deleteCandidateBId({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Candidate Reviews
  @GET('/candidate/reviews')
  Future<HttpResponse<DataResponseModel>> getCandidateReviews({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Query("user_id") int? userId,
  });

  //Candidate Create Reviews
  @POST('/candidate/reviews')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createCandidateReviews(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("on_user_id") int? onUserId,
      @Field("review") String? review,
      @Field("review_star_rating") int? reviewStarRating});

  //Candidate Update Reviews
  @PUT('/candidate/reviews')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateCandidateReviews(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("user_review_id") int? reviewId,
      @Field("review") String? review,
      @Field("review_star_rating") int? reviewStarRating});

  //Candidate Delete Reviews
  @DELETE('/candidate/reviews/{reviewId}')
  Future<HttpResponse<DataResponseModel>> deleteCandidateReview({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("reviewId") int? reviewId,
  });

  //Candidate List Coin History
  @GET('/candidate')
  Future<HttpResponse<DataResponseModel>> candidateCoinListHistory(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token});

  //Candidate List Coin Balance
  @GET('/candidate')
  Future<HttpResponse<DataResponseModel>> candidateCoinListBalance(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token});

  //Candidate Referred Friend
  @POST('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> candidateReferFriendList({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Candidate Update Account
  @POST('/candidate')
  @MultiPart()
  Future<HttpResponse<DataResponseModel>> candidateAccountUpdate(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Part(name: "avatar", contentType: "image/png") File? avatar,
      @Part(name: "first_name") String? firstName,
      @Part(name: "last_name") String? lastName,
      @Part(name: "email") String? email,
      @Part(name: "country_calling_code") int? countryCallingCode,
      @Part(name: "phone_number") int? phoneNumber,
      @Part(name: "is_email_verified") int? isEmailVerified,
      @Part(name: "is_phone_verified") int? isPhoneVerified});

  //Candidate Employment Sorting
  @POST('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> candidateCreateEmploymentSort(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("employments[]") List<int>? employments});

  //Candidate Save Search Notify
  @POST('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateCandidateSaveSearchNotify(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("saved_search_id") int? savedSearchId});

  //Candidate Update Shareable Link
  @POST('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateCandidateShareableLink(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("user_id") int? userId,
      @Field("link") String? link});

  //Candidate Check Verified
  @POST('/candidate/check-already-verified')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> getCandidateCheckVerified({
    @Header("Accept") String? acceptType,
    @Field('type') String? type,
    @Field('email') String? email,
    @Field('country_calling_code') int? countryCallingCode,
    @Field('phone_number') int? phoneNumber,
  });

  //Candidate Work Permit
  @POST('/candidate')
  @MultiPart()
  Future<HttpResponse<DataResponseModel>> createCandidateWorkPermit({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Part(name: 'dob') String? dob,
    @Part(name: 'fin') String? fin,
    @Part(name: 'country') String? country,
    @Part(name: 'work_permit_front_filepath') File? workPermitFrontFile,
    @Part(name: 'work_permit_back_filepath') File? workPermitBackFile,
  });

  //Candidate Profile Complaint
  @POST('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createCandidateComplaint({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field('profile_id') int? userId,
  });

  //Candidate Local Configs
  @PUT('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateCandidateConfigs({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path('path') String? path,
    @Field('app_locale') String? appLocale,
    @Field('preferred_language') String? preferredLanguage,
  });

  //Candidate Exchange
  @POST('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> candidateExchange({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field('base') String? base,
    @Field('target') String? target,
    @Field('base_amount') double? baseAmount,
  });

  //Candidate Exchange
  @POST('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> candidateOfferAction({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field('notification_id') int? notificationId,
    @Field('action') String? action,
    @Field('employer_id') int? employerId,
  });
}
