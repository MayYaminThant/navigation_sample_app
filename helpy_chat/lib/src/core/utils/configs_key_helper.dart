//Configs Keys
class ConfigsKeyHelper {
  // app version
  static String candidateAppMinCompatibleVersionKey =
      "CANDIDATE_APP_MIN_COMPATIBLE_VERSION";
  static String employerAppMinCompatibleVersionKey =
      "EMPLOYER_APP_MIN_COMPITABLE_VERSION";

  //Language
  static String firstTimeLoadLanguageKey =
      "SIDEBAR_APP_FIRST_TIME_LOAD_FORM.DH_LANGUAGE_TYPE.language";
  static String articleLanguageKey =
      "ARTICLE_LIST_FORM.DH_LANGUAGE_TYPE.language";
  static String articleCreateLanguageKey =
      "ARTICLE_CREATE_FORM.DH_LANGUAGE_TYPE.language";

  static String firstTimeLoadCountryKey =
      "SIDEBAR_APP_FIRST_TIME_LOAD _FORM.DH_APP_LOCALE_TYPE.app_locale";

  //SW-COUNTRY-CallingCode
  static String loginPhoneKey =
      "LOGIN_PHONE_NUMBER_FORM.SW-COUNTRY_CALLING_CODE.country_name";
  static String registerPhoneKey =
      "REGISTER_PHONE_NUMBER_FORM.SW-COUNTRY_CALLING_CODE.country_name";
  static String forgetPhoneKey =
      "FORGOT_PASSWORD_FORM.SW-COUNTRY_CALLING_CODE.country_name";
  static String profileStep1PhoneKey =
      "CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-COUNTRY_CALLING_CODE.country_name";

  static String languageConfigKey =
      "ARTICLE_LIST_FORM.DH_LANGUAGE_TYPE.language";
  static String agentFeeKey =
      "CANDIDATE_ADVANCED_SEARCH_FORM.DH_AGENT_FEE.agent_fee";
  static String currencyCodeKey =
      "CANDIDATE_ADVANCED_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code";

  static String restDayChoiceKey =
      "CANDIDATE_ADVANCED_SEARCH_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice";
  static String taskTypeKey =
      "CANDIDATE_ADVANCED_SEARCH_FORM.DH_TASK_TYPE.task_type";

  static String religionKey =
      "CANDIDATE_ADVANCED_SEARCH_FORM.SW-RELIGION_TYPE.religion";

  //Family Information
  static String familyMemberTypeKey =
      "CANDIDATE_PROFILE_CREATION_STEP2_FORM.DH_CANDIDATE_FAMILY_MEMBER_TYPE.member_type";

  //Religion
  static String profileStep1ReligionKey =
      "CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-RELIGION_TYPE.religion";
  static String adSearchReligionKey =
      "CANDIDATE_ADVANCED_SEARCH_FORM.SW-RELIGION_TYPE.religion";
  static String offerReligionKey =
      "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.SW-RELIGION_TYPE.religion";

  //DH_COUNTRY_OF_EMPLOYER_WORK
  static String simpleSearchWorkCountryKey =
      "CANDIDATE_SIMPLE_SEARCH_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name";
  static String offerWorkCountryKey =
      "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name";
  static String adSearchWorkCountryKey =
      "CANDIDATE_ADVANCED_SEARCH_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name";

  //Currency
  static String simpleSearchCurrencyCodeKey =
      "CANDIDATE_SIMPLE_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code";
  static String adSearchCurrencyCodeKey =
      "CANDIDATE_ADVANCED_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code";
  static String offerCurrencyCodeKey =
      "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_APP_LOCALE_TYPE.currency_code";

  ///TODO
  //My Nationality
  static String myNationalityKey =
      "CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-COUNTRY_CALLING_CODE.country_name";

  //Rest Day
  static String adSearchRestDayKey =
      "CANDIDATE_ADVANCED_SEARCH_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice";
  static String offerRestDayKey =
      "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice";

  //Gender
  static String genderTypeKey =
      "CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-GENDER_TYPE.gender";

  //Task Type
  static String adSearchTaskTypeKey =
      "CANDIDATE_ADVANCED_SEARCH_FORM.DH_TASK_TYPE.task_type";
  static String offerTaskTypeKey =
      "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_TASK_TYPE.task_type";
  static String profileStep3TaskTypeKey =
      "CANDIDATE_PROFILE_CREATION_STEP3_FORM.DH_TASK_TYPE.task_type";
  static String profileStep5TaskTypeKey =
      "CANDIDATE_PROFILE_CREATION_STEP5_FORM.DH_TASK_TYPE.task_type";

  //Work Permit
  static String workPermitCountryKey =
      "WORK_PERMIT_FORM.DH_APP_LOCALE_TYPE.app_locale";

  //Marital Status
  static String maritalStatusKey =
      "CANDIDATE_PROFILE_CREATION_STEP2_FORM.DH_CANDIDATE_FAMILY_STATUS_TYPE.family_status";

  //Qualification
  static String qualificationKey =
      "CANDIDATE_PROFILE_CREATION_STEP3_FORM.DH_CANDIDATE_ACADEMIC_QUALIFICATION_TYPE.qualification";

  //Employment
  static String employmentKey =
      "CANDIDATE_EMPLOYMENT_HISTORY_FORM.SW-COUNTRY_CALLING_CODE.country_name";

  //AVAILABILITY
  static String availabilityStatusKey =
      "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_CANDIDATE_AVAILABILITY_STATUS_TYPE.availability_status";

  //Exchange Key
  static String exchangePHCkey = "DH_APP_LOCALE_TYPE.PHC_100000_FOREX_value";

  //WorkPermit Key
  static String workPermitKey = "WORK_PERMIT_VERIFICATION_REWARD";

  //Reward Country
  static String rewardCountryKey =
      "REWARD_LIST_FORM.DH_APP_LOCALE_TYPE.app_locale";

  //Referral Key
  static String referralCreateAccountKey =
      "DH_CANDIDATE_CREATE_ACCOUNT_COIN_REWARD_FOR_REFERER";

  static String refererVerifyKey =
      'DH_CANDIDATE_VERIFY_PHONE_COIN_REWARD_FOR_REFERER';
  static String refererWorkPermitKey =
      'DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFERER';
  static String refereeWorkPermitKey =
      "DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFEREE";

  //Contact Us
  static String customerSupportPhoneKey =
      "CUSTOMER_SUPPORT_FORM.SW-COUNTRY_CALLING_CODE.country_name";
  static String customerSupportIssueKey =
      "CUSTOMER_SUPPORT_FORM.DH_CONTACT_ISSUE_TYPE.contact_issue";

  //Work Permit Verify Delay
  static String workPermitVerifyDelay = "VERIFY_WORK_PERMIT_DELAY_HOUR";
}
