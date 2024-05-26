import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/models.dart';

part 'employer_api_service.g.dart';

@RestApi()
abstract class EmployerApiService {
  factory EmployerApiService(Dio dio, {String baseUrl}) = _EmployerApiService;

  //Employer Login
  @POST('/employer/login/{path}')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createUserLogin(
      {@Header("Accept") String? acceptType,
      @Path("path") String? path,
      @Field("country_calling_code") int? countryCallingCode,
      @Field("phone_number") int? phoneNumber,
      @Field("email") String? email,
      @Field("password") String? password});

  //Employer Logout
  @POST('/employer/logout')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> userLogout({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Employer Social Login
  @POST('/employer/login/social')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createSocialLogin(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? defaultToken,
      @Field("provider") String? provider,
      @Field("user_id") String? userId});

  //Employer Social Register
  @POST('/employer/social/register')
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

  //Employer Register
  @POST('/employer/register')
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
  @POST('/employer/contact')
  @MultiPart()
  Future<HttpResponse<DataResponseModel>> createEmployerContactUs({
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
  });

  //Employer Configs
  @GET('/employer/configs')
  Future<HttpResponse<DataResponseModel>> getEmployerConfigs({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Query("last_timestamp") String? lastTimestamp,
  });

  //Employer Countries
  @GET('/employer/countries')
  Future<HttpResponse<DataResponseModel>> getEmployerCountries({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Employer Genders
  @GET('/employer/genders')
  Future<HttpResponse<DataResponseModel>> getEmployerGenders({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Employer Language Types
  @GET('/employer/language_type')
  Future<HttpResponse<DataResponseModel>> getEmployerLanguageTypes(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Query("app_silo") String? appSilo});

  //Employer Religions
  @GET('/employer/religions')
  Future<HttpResponse<DataResponseModel>> getEmployerReligions({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Employer Profile
  @GET('/employer/profile/detail')
  Future<HttpResponse<DataResponseModel>> getEmployerProfile({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Employer Ceate About
  @POST('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createEmployerAbout({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Part(name: "self_desc") String? selfDesc,
    @Part(name: "expect_candidate") String? expectedEmployer,
    @Part(name: "first_name") String? firstName,
    @Part(name: "last_name") String? lastName,
    @Part(name: "email") String? email,
    @Part(name: "country_calling_code") String? countryCallingCode,
    @Part(name: "phone_number") String? phoneNumber,
    @Part(name: "date_of_birth") String? dateOfBirth,
    @Part(name: "religion") String? religion,
    @Part(name: "nationality") String? nationality,
    @Part(name: "country_of_residence") String? countryOfResidence,
    @Part(name: "gender") String? gender,
    @Part(name: "media") String? media,
    @Part(name: "portfolios[]", contentType: "image/png")
        List<File>? portfolios,
    @Part(name: "thumbnails[]", contentType: "image/png")
        List<File>? thumbnails,
    @Part(name: "update_progress") int? updateProgress,
  });

  //Employer Update Family Status
  @POST('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateEmployerFamilyInformation({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field("family_status") String? familyStatus,
    @Field("members") List<dynamic>? members,
    @Field("special_req_children") String? specialReqChildren,
    @Field("special_req_elderly") String? specialReqElderly,
    @Field("special_req_pet") String? specialReqPet,
    @Field("update_progress") int? updateProgress,
  });

  //Employer Update Language
  @POST('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateEmployerLanguage(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("user_id") int? userId,
      @Field("languages[language_proficient_english]") int? proficientEnglish,
      @Field("languages[language_chinese_mandarin]") int? chineseMandarin,
      @Field("languages[language_bahasa_melayu]") int? bahasaMelayu,
      @Field("languages[language_tamil]") int? tamil,
      @Field("languages[language_hokkien]") int? hokkien,
      @Field("languages[language_teochew]") int? teochew,
      @Field("languages[language_cantonese]") int? cantonese,
      @Field("languages[language_bahasa_indonesian]") int? bahasaIndonesian,
      @Field("languages[language_japanese]") int? japanese,
      @Field("languages[language_korean]") int? korean,
      @Field("languages[language_french]") int? french,
      @Field("languages[language_german]") int? german,
      @Field("languages[language_arabic]") int? arabic,
      @Field("language_other_specify") String? othersSpecify,
      @Field("update_progress") int? updateProgress});

  //Employer Employments
  @GET('/employer/employments')
  Future<HttpResponse<DataResponseModel>> getEmployerEmployments({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Employer Create Employments
  @POST('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createEmployerEmployment({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field("user_id") int? userId,
    @Field("work_country_name") String? countryName,
    @Field("display_order") int? displayOrder,
    @Field("start_date") String? startDate,
    @Field("end_date") String? endDate,
    @Field("work_desc") String? workDesc,
    @Field("dh_related") int? dhRelated,
  });

  //Employer Update Employments
  @PUT('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateEmployerEmployment({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("id") int? employmentId,
    @Field("user_id") int? userId,
    @Field("start_date") String? startDate,
    @Field("end_date") String? endDate,
    @Field("work_country_name") String? countryName,
    @Field("work_desc") String? workDesc,
    @Field("dh_related") bool? dhRelated,
  });

  //Employer Delete Employments
  @DELETE('/employer/employments/{id}')
  Future<HttpResponse<DataResponseModel>> deleteEmployerEmployment({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("id") int? employmentId,
  });

  //Employer Availability Status
  @GET('/employer/availability_status')
  Future<HttpResponse<DataResponseModel>> getEmployerAvailabilityStatus(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Query("app_silo") String? appSilo});

  //Employer Update Availability Status
  @PUT('/employer/availability_status')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateEmployerAvailabilityStatus({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field("user_id") int? userId,
    @Field("status") String? status,
  });

  //Employer StarList
  @GET('/employer/stars')
  Future<HttpResponse<DataResponseModel>> getEmployerStarsList({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Employer add StarList
  @POST('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> postEmployerStarsList({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field("candidate_id") int? candidateId,
  });

  //Employer Remove StarList
  @DELETE('/employer')
  Future<HttpResponse<DataResponseModel>> removeEmployerStarsList(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Path("star_id") int? starId});

  //Employer Forgot Password
  @POST('/employer/forgot-password/{path}')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createEmployerForgotPassword({
    @Header("Accept") String? acceptType,
    @Path("path") String? path,
    @Field("country_calling_code") int? countryCallingCode,
    @Field("phone_number") int? phoneNumber,
    @Field("email") String? email,
  });

  //Candidate Reset Password
  @POST('/employer/reset-password/{path}')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createEmployerResetPassword({
    @Header("Accept") String? acceptType,
    @Path("path") String? path,
    @Field("request_id") String? requestId,
    @Field("country_calling_code") int? countryCallingCode,
    @Field("phone_number") int? phoneNumber,
    @Field("email") String? email,
    @Field("password") String? password,
  });

  //Employer Update Work Preference
  @PUT('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateEmployerWorkPreference({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field("rest_day_work_pref") int? restDayWorkPref,
  });

  //Employer Spotlights
  @POST('/employer/spotlights')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createEmployerSpotlights({
    @Header("Accept") String? acceptType,
    @Field("category") String? category,
  });

  //Employer Save Search List
  @GET('/employer')
  Future<HttpResponse<DataResponseModel>> employerSaveSearchList({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Employer Update Save Search
  @PUT('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateEmployerSaveSearch(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("id") int? saveSearchId,
      @Field("name") String? name});

  //Employer Delete Save Search
  @DELETE('/employer')
  Future<HttpResponse<DataResponseModel>> deleteEmployerSaveSearch(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Path("employerSavedSearch") int? saveSearchId});

  //Employer FCM
  @POST('/employer/fcm_token')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createEmployerFCMTOken(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("fcm_token") String? fcmToken});

  //Employer Upload Avatar
  @POST('/employer/avatar')
  @MultiPart()
  Future<HttpResponse<DataResponseModel>> createEmployerAvatar({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Part(name: 'avatar', contentType: "image/png") File? avatar,
  });

  //Employer Delete Avatar
  @DELETE('/employer')
  Future<HttpResponse<DataResponseModel>> deleteEmployerAvatar({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Employer Update Verification
  @POST('/employer/update_verification')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createEmployerVerification({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field('request_id') String? requestId,
    @Field('user_id') int? userId,
    @Field('verified_method') String? method,
    @Field('email') String? email,
    @Field('country_calling_code') int? countryCallingCode,
    @Field('phone_number') int? phoneNumber,
    @Field('app_silo_name') String? appSiloName,
  });

  //Employer Account
  @DELETE('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> deleteEmployerAccount({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Employer Profile Delete
  @DELETE('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> deleteEmployerProfile({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path('employerId') int? employerId,
  });

  //Employer Offer
  @POST('/employer/offer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createEmployerOffer(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field('country_of_work_offer') String? countryOfWork,
      @Field('dh_nationality') String? dhNationality,
      @Field('salary') int? salary,
      @Field('currency') String? currency,
      @Field('start_date') String? availableStartDate,
      @Field('end_date') String? availableEndDate,
      @Field('nationality') String? nationality,
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
      @Field("process_fee") int? processFee,
      @Field("availability_status") String? availabilityStatus});

  //Employer Delete Offer
  @DELETE('/employer/offer')
  Future<HttpResponse<DataResponseModel>> deleteEmployerOffer({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Employer Reviews
  @GET('/employer/reviews')
  Future<HttpResponse<DataResponseModel>> getEmployerReviews({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Query("user_id") int? userId,
  });

  //Employer Create Reviews
  @POST('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createEmployerReviews(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("on_user_id") int? onUserId,
      @Field("review") String? review,
      @Field("review_star_rating") int? reviewStarRating});

  //Employer Update Reviews
  @PUT('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateEmployerReviews(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("user_review_id") int? reviewId,
      @Field("review") String? review,
      @Field("review_star_rating") int? reviewStarRating});

  //Employer Delete Reviews
  @DELETE('/employer')
  Future<HttpResponse<DataResponseModel>> deleteEmployerReview({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("reviewId") int? reviewId,
  });

  //Employer List Voucher History
  @GET('/employer/coin_history')
  Future<HttpResponse<DataResponseModel>> employerVoucherListHistory(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token});

  //Employer Coin Balance
  @GET('/employer/coin_balance')
  Future<HttpResponse<DataResponseModel>> employerCoinBalance(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token});

  //Candidate Referred Friend
  @POST('/employer/refer_friends')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> employerReferFriendList(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("user_id") int? userId});

  //Employer Update Account
  @POST('/employer')
  @MultiPart()
  Future<HttpResponse<DataResponseModel>> employerAccountUpdate(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Part(name: "user_id") int? userId,
      @Part(name: "avatar", contentType: "image/png") File? avatar,
      @Part(name: "first_name") String? firstName,
      @Part(name: "last_name") String? lastName,
      @Part(name: "email") String? email,
      @Part(name: "country_calling_code") int? countryCallingCode,
      @Part(name: "phone_number") int? phoneNumber,
      @Part(name: "is_email_verified") int? isEmailVerified,
      @Part(name: "is_phone_verified") int? isPhoneVerified});

  //Employer Save Search Notify
  @POST('/employer/save_search_notify')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateEmployerSaveSearchNotify(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("saved_search_id") int? savedSearchId});

  //Employer Update Shareable Link
  @POST('/employer/update_share_link')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateEmployerShareableLink(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("user_id") int? userId,
      @Field("link") String? link});

  //Employer Check Verified
  @POST('/employer/check-already-verified')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> getEmployerCheckVerified({
    @Header("Accept") String? acceptType,
    @Field('type') String? type,
    @Field('email') String? email,
    @Field('country_calling_code') int? countryCallingCode,
    @Field('phone_number') int? phoneNumber,
  });

  //Employer Hiring
  @POST('/employer/hiring')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createEmployerHiring(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field('country_calling_code') int? countryCallingCode,
      @Field('phone_number') int? phoneNumber,
      @Field('from_time') String? fromTime,
      @Field('to_tome') String? toTime,
      @Field('currency') String? currency,
      @Field('salary') int? salary,
      @Field('expiry_date') String? expiryDate,
      @Field('candidate_id') int? candidateId});

  //Employer Profile Complaint
  @POST('/employer/profile/complain')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createEmployerComplaint({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field('profile_id') int? userId,
  });

  //Employer Local Configs
  @PUT('/employer/{path}')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateEmployerConfigs({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path('path') String? path,
    @Field('app_locale') String? appLocale,
    @Field('preferred_language') String? preferredLanguage,
  });

  //Empliyer Exchange
  @POST('/employer/convert')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> employerExchange({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field('base') String? base,
    @Field('target') String? target,
    @Field('base_amount') double? baseAmount,
  });
}
