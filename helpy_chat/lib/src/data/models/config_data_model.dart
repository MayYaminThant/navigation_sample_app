import 'dart:convert';

class ConfigDataModel {
    final Data? data;
    final String? message;

    ConfigDataModel({
        this.data,
        this.message,
    });

    factory ConfigDataModel.fromJson(String str) => ConfigDataModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ConfigDataModel.fromMap(Map<String, dynamic> json) => ConfigDataModel(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
    };
}

class Data {
    final List<FormDhLanguageTypeLanguage>? articleCreateFormDhLanguageTypeLanguage;
    final DateTime? articleCreateFormDhLanguageTypeLanguageLastUpdateDatetime;
    final List<FormDhLanguageTypeLanguage>? articleListFormDhLanguageTypeLanguage;
    final DateTime? articleListFormDhLanguageTypeLanguageLastUpdateDatetime;
    final List<String>? candidateAdvancedSearchFormDhAgentFeeAgentFee;
    final DateTime? candidateAdvancedSearchFormDhAgentFeeAgentFeeLastUpdateDatetime;
    final List<FormDhAppLocaleTypeCurrencyCode>? candidateAdvancedSearchFormDhAppLocaleTypeCurrencyCode;
    final DateTime? candidateAdvancedSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime;
    final List<CountryName>? candidateAdvancedSearchFormDhCountryOfEmployerWorkCountryName;
    final DateTime? candidateAdvancedSearchFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime;
    final List<FormDhRestDayTypeRestDayPerMonthChoice>? candidateAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoice;
    final DateTime? candidateAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime;
    final List<String>? candidateAdvancedSearchFormDhTaskTypeTaskType;
    final DateTime? candidateAdvancedSearchFormDhTaskTypeTaskTypeLastUpdateDatetime;
    final List<String>? candidateAdvancedSearchFormSwReligionTypeReligion;
    final DateTime? candidateAdvancedSearchFormSwReligionTypeReligionLastUpdateDatetime;
    final List<String>? candidateAvailabilityStatusChangeFormDhAgentFeeAgentFee;
    final DateTime? candidateAvailabilityStatusChangeFormDhAgentFeeAgentFeeLastUpdateDatetime;
    final List<FormDhAppLocaleTypeCurrencyCode>? candidateAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCode;
    final DateTime? candidateAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime;
    final List<AvailabilityStatusTypeAvailabilityStatus>? candidateAvailabilityStatusChangeFormDhCandidateAvailabilityStatusTypeAvailabilityStatus;
    final DateTime? candidateAvailabilityStatusChangeFormDhCandidateAvailabilityStatusTypeAvailabilityStatusLastUpdateDatetime;
    final List<CountryName>? candidateAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryName;
    final DateTime? candidateAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime;
    final List<FormDhRestDayTypeRestDayPerMonthChoice>? candidateAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoice;
    final DateTime? candidateAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime;
    final List<String>? candidateAvailabilityStatusChangeFormDhTaskTypeTaskType;
    final DateTime? candidateAvailabilityStatusChangeFormDhTaskTypeTaskTypeLastUpdateDatetime;
    final List<String>? candidateAvailabilityStatusChangeFormSwReligionTypeReligion;
    final DateTime? candidateAvailabilityStatusChangeFormSwReligionTypeReligionLastUpdateDatetime;
    final List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>? candidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName;
    final DateTime? candidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryNameLastUpdateDatetime;
    final List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>? candidateEmployerProfileCreationStep1FormSwCountryCallingCodeIbanAlpha2Code;
    final DateTime? candidateEmployerProfileCreationStep1FormSwCountryCallingCodeIbanAlpha2CodeLastUpdateDatetime;
    final List<String>? candidateEmployerProfileCreationStep1FormSwGenderTypeGender;
    final DateTime? candidateEmployerProfileCreationStep1FormSwGenderTypeGenderLastUpdateDatetime;
    final List<String>? candidateEmployerProfileCreationStep1FormSwReligionTypeReligion;
    final DateTime? candidateEmployerProfileCreationStep1FormSwReligionTypeReligionLastUpdateDatetime;
    final List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>? candidateEmployerProfileCreationStep1Form2SwCountryCallingCodeCountryName;
    final DateTime? candidateEmployerProfileCreationStep1Form2SwCountryCallingCodeCountryNameLastUpdateDatetime;
    final List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>? candidateEmploymentHistoryFormSwCountryCallingCodeCountryName;
    final DateTime? candidateEmploymentHistoryFormSwCountryCallingCodeCountryNameLastUpdateDatetime;
    final List<FormDhAppLocaleTypeAppLocale>? candidateMyAccountFormDhAppLocaleTypeAppLocale;
    final DateTime? candidateMyAccountFormDhAppLocaleTypeAppLocaleLastUpdateDatetime;
    final List<FormDhAppLocaleTypeCurrencyCode>? candidateOfferAcceptOrRejectFormDhAppLocaleTypeCurrencyCode;
    final DateTime? candidateOfferAcceptOrRejectFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime;
    final List<String>? candidateProfileCreationStep2FormDhCandidateFamilyMemberTypeMemberType;
    final DateTime? candidateProfileCreationStep2FormDhCandidateFamilyMemberTypeMemberTypeLastUpdateDatetime;
    final List<String>? candidateProfileCreationStep2FormDhCandidateFamilyStatusTypeFamilyStatus;
    final DateTime? candidateProfileCreationStep2FormDhCandidateFamilyStatusTypeFamilyStatusLastUpdateDatetime;
    final List<String>? candidateProfileCreationStep3FormDhCandidateAcademicQualificationTypeQualification;
    final DateTime? candidateProfileCreationStep3FormDhCandidateAcademicQualificationTypeQualificationLastUpdateDatetime;
    final List<String>? candidateProfileCreationStep3FormDhTaskTypeTaskType;
    final DateTime? candidateProfileCreationStep3FormDhTaskTypeTaskTypeLastUpdateDatetime;
    final List<String>? candidateProfileCreationStep5FormDhTaskTypeTaskType;
    final DateTime? candidateProfileCreationStep5FormDhTaskTypeTaskTypeLastUpdateDatetime;
    final List<String>? candidateSimpleSearchFormDhAgentFeeAgentFee;
    final DateTime? candidateSimpleSearchFormDhAgentFeeAgentFeeLastUpdateDatetime;
    final List<FormDhAppLocaleTypeCurrencyCode>? candidateSimpleSearchFormDhAppLocaleTypeCurrencyCode;
    final DateTime? candidateSimpleSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime;
    final List<CountryName>? candidateSimpleSearchFormDhCountryOfEmployerWorkCountryName;
    final DateTime? candidateSimpleSearchFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime;
    final String? colorTagFamily;
    final DateTime? colorTagFamilyLastUpdateDatetime;
    final String? colorTagLanguage;
    final DateTime? colorTagLanguageLastUpdateDatetime;
    final String? colorTagSkill;
    final DateTime? colorTagSkillLastUpdateDatetime;
    final String? colorTagTransferMaid;
    final DateTime? colorTagTransferMaidLastUpdateDatetime;
    final List<String>? customerSupportFormDhContactIssueTypeContactIssue;
    final DateTime? customerSupportFormDhContactIssueTypeContactIssueLastUpdateDatetime;
    final List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>? customerSupportFormSwCountryCallingCodeCountryName;
    final DateTime? customerSupportFormSwCountryCallingCodeCountryNameLastUpdateDatetime;
    final List<DhAppLocaleTypePhc100000ForexValue>? dhAppLocaleTypePhc100000ForexValue;
    final DateTime? dhAppLocaleTypePhc100000ForexValueLastUpdateDatetime;
    final int? dhArticleCommentComplaintMaxCount;
    final DateTime? dhArticleCommentComplaintMaxCountLastUpdateDatetime;
    final int? dhArticleComplaintMaxCount;
    final DateTime? dhArticleComplaintMaxCountLastUpdateDatetime;
    final Dh? dhCandidateCreateAccountCoinRewardForReferer;
    final DateTime? dhCandidateCreateAccountCoinRewardForRefererLastUpdateDatetime;
    final int? dhCandidateProfileProgressPerStep;
    final DateTime? dhCandidateProfileProgressPerStepLastUpdateDatetime;
    final Dh? dhCandidateVerifyPhoneCoinRewardForReferer;
    final DateTime? dhCandidateVerifyPhoneCoinRewardForRefererLastUpdateDatetime;
    final Dh? dhCandidateVerifyWorkpermitCoinRewardForReferee;
    final DateTime? dhCandidateVerifyWorkpermitCoinRewardForRefereeLastUpdateDatetime;
    final Dh? dhCandidateVerifyWorkpermitCoinRewardForReferer;
    final DateTime? dhCandidateVerifyWorkpermitCoinRewardForRefererLastUpdateDatetime;
    final Dh? dhEmployerCreateAccountCoinRewardForReferer;
    final DateTime? dhEmployerCreateAccountCoinRewardForRefererLastUpdateDatetime;
    final int? dhEmployerProfileProgressPerStep;
    final DateTime? dhEmployerProfileProgressPerStepLastUpdateDatetime;
    final Dh? dhEmployerVerifyPhoneCoinRewardForReferer;
    final DateTime? dhEmployerVerifyPhoneCoinRewardForRefererLastUpdateDatetime;
    final int? dhProfileComplaintMaxCount;
    final DateTime? dhProfileComplaintMaxCountLastUpdateDatetime;
    final int? dhProfileCompletionCoinReward;
    final DateTime? dhProfileCompletionCoinRewardLastUpdateDatetime;
    final int? dhProfileCompletionVoucherReward;
    final DateTime? dhProfileCompletionVoucherRewardLastUpdateDatetime;
    final int? dialPrependSpecialMy;
    final DateTime? dialPrependSpecialMyLastUpdateDatetime;
    final List<FormDhAppLocaleTypeCurrencyCode>? employerAdvancedSearchFormDhAppLocaleTypeCurrencyCode;
    final DateTime? employerAdvancedSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime;
    final List<CountryName>? employerAdvancedSearchFormDhCountryOfCandidateSourceCountryName;
    final DateTime? employerAdvancedSearchFormDhCountryOfCandidateSourceCountryNameLastUpdateDatetime;
    final List<FormDhRestDayTypeRestDayPerMonthChoice>? employerAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoice;
    final DateTime? employerAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime;
    final List<String>? employerAdvancedSearchFormDhTaskTypeTaskType;
    final DateTime? employerAdvancedSearchFormDhTaskTypeTaskTypeLastUpdateDatetime;
    final List<String>? employerAdvancedSearchFormSwReligionTypeReligion;
    final DateTime? employerAdvancedSearchFormSwReligionTypeReligionLastUpdateDatetime;
    final List<FormDhAppLocaleTypeCurrencyCode>? employerAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCode;
    final DateTime? employerAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime;
    final List<CountryName>? employerAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryName;
    final DateTime? employerAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime;
    final List<AvailabilityStatusTypeAvailabilityStatus>? employerAvailabilityStatusChangeFormDhEmployerAvailabilityStatusTypeAvailabilityStatus;
    final DateTime? employerAvailabilityStatusChangeFormDhEmployerAvailabilityStatusTypeAvailabilityStatusLastUpdateDatetime;
    final List<FormDhRestDayTypeRestDayPerMonthChoice>? employerAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoice;
    final DateTime? employerAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime;
    final List<String>? employerAvailabilityStatusChangeFormDhTaskTypeTaskType;
    final DateTime? employerAvailabilityStatusChangeFormDhTaskTypeTaskTypeLastUpdateDatetime;
    final List<String>? employerAvailabilityStatusChangeFormSwReligionTypeReligion;
    final DateTime? employerAvailabilityStatusChangeFormSwReligionTypeReligionLastUpdateDatetime;
    final List<FormDhAppLocaleTypeAppLocale>? employerMyAccountFormDhAppLocaleTypeAppLocale;
    final DateTime? employerMyAccountFormDhAppLocaleTypeAppLocaleLastUpdateDatetime;
    final List<FormDhAppLocaleTypeCurrencyCode>? employerOfferFormDhAppLocaleTypeCurrencyCode;
    final DateTime? employerOfferFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime;
    final List<String>? employerProfileCreationStep2FormDhEmployerFamilyMemberTypeMemberType;
    final DateTime? employerProfileCreationStep2FormDhEmployerFamilyMemberTypeMemberTypeLastUpdateDatetime;
    final List<String>? employerProfileCreationStep2FormDhEmployerFamilyStatusTypeFamilyStatus;
    final DateTime? employerProfileCreationStep2FormDhEmployerFamilyStatusTypeFamilyStatusLastUpdateDatetime;
    final List<FormDhAppLocaleTypeCurrencyCode>? employerSimpleSearchFormDhAppLocaleTypeCurrencyCode;
    final DateTime? employerSimpleSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime;
    final List<CountryName>? employerSimpleSearchFormDhCountryOfCandidateSourceCountryName;
    final DateTime? employerSimpleSearchFormDhCountryOfCandidateSourceCountryNameLastUpdateDatetime;
    final List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>? forgotPasswordFormSwCountryCallingCodeCountryName;
    final DateTime? forgotPasswordFormSwCountryCallingCodeCountryNameLastUpdateDatetime;
    final List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>? loginPhoneNumberFormSwCountryCallingCodeCountryName;
    final DateTime? loginPhoneNumberFormSwCountryCallingCodeCountryNameLastUpdateDatetime;
    final int? maxCallCount;
    final DateTime? maxCallCountLastUpdateDatetime;
    final int? maxCallTimeLength;
    final DateTime? maxCallTimeLengthLastUpdateDatetime;
    final int? maxConcurrentInterview;
    final DateTime? maxConcurrentInterviewLastUpdateDatetime;
    final int? maxConnectionPerDay;
    final DateTime? maxConnectionPerDayLastUpdateDatetime;
    final int? maxDailyViewCount;
    final DateTime? maxDailyViewCountLastUpdateDatetime;
    final int? maxEmployerOfferValidDay;
    final DateTime? maxEmployerOfferValidDayLastUpdateDatetime;
    final int? maxMonthlySalaryInSgd;
    final DateTime? maxMonthlySalaryInSgdLastUpdateDatetime;
    final int? maxStarlistCount;
    final DateTime? maxStarlistCountLastUpdateDatetime;
    final int? minCallTimeLength;
    final DateTime? minCallTimeLengthLastUpdateDatetime;
    final int? minMonthlySalaryInSgd;
    final DateTime? minMonthlySalaryInSgdLastUpdateDatetime;
    final List<FormDhLanguageTypeLanguage>? myAccountFormDhLanguageTypeLanguage;
    final DateTime? myAccountFormDhLanguageTypeLanguageLastUpdateDatetime;
    final int? prospectRepeatViewDay;
    final DateTime? prospectRepeatViewDayLastUpdateDatetime;
    final List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>? registerPhoneNumberFormSwCountryCallingCodeCountryName;
    final DateTime? registerPhoneNumberFormSwCountryCallingCodeCountryNameLastUpdateDatetime;
    final List<FormDhAppLocaleTypeAppLocale>? rewardListFormDhAppLocaleTypeAppLocale;
    final DateTime? rewardListFormDhAppLocaleTypeAppLocaleLastUpdateDatetime;
    final List<SearchFormDhAppLocaleTypeAppLocale>? searchFormDhAppLocaleTypeAppLocale;
    final DateTime? searchFormDhAppLocaleTypeAppLocaleLastUpdateDatetime;
    final List<FormDhAppLocaleTypeAppLocale>? sidebarAppFirstTimeLoadFormDhAppLocaleTypeAppLocale;
    final DateTime? sidebarAppFirstTimeLoadFormDhAppLocaleTypeAppLocaleLastUpdateDatetime;
    final List<FormDhLanguageTypeLanguage>? sidebarAppFirstTimeLoadFormDhLanguageTypeLanguage;
    final DateTime? sidebarAppFirstTimeLoadFormDhLanguageTypeLanguageLastUpdateDatetime;
    final int? verifyWorkPermitDelayHour;
    final DateTime? verifyWorkPermitDelayHourLastUpdateDatetime;
    final List<FormDhAppLocaleTypeAppLocale>? workPermitFormDhAppLocaleTypeAppLocale;
    final DateTime? workPermitFormDhAppLocaleTypeAppLocaleLastUpdateDatetime;
    final String? storagePrefix;

    Data({
        this.articleCreateFormDhLanguageTypeLanguage,
        this.articleCreateFormDhLanguageTypeLanguageLastUpdateDatetime,
        this.articleListFormDhLanguageTypeLanguage,
        this.articleListFormDhLanguageTypeLanguageLastUpdateDatetime,
        this.candidateAdvancedSearchFormDhAgentFeeAgentFee,
        this.candidateAdvancedSearchFormDhAgentFeeAgentFeeLastUpdateDatetime,
        this.candidateAdvancedSearchFormDhAppLocaleTypeCurrencyCode,
        this.candidateAdvancedSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime,
        this.candidateAdvancedSearchFormDhCountryOfEmployerWorkCountryName,
        this.candidateAdvancedSearchFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime,
        this.candidateAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoice,
        this.candidateAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime,
        this.candidateAdvancedSearchFormDhTaskTypeTaskType,
        this.candidateAdvancedSearchFormDhTaskTypeTaskTypeLastUpdateDatetime,
        this.candidateAdvancedSearchFormSwReligionTypeReligion,
        this.candidateAdvancedSearchFormSwReligionTypeReligionLastUpdateDatetime,
        this.candidateAvailabilityStatusChangeFormDhAgentFeeAgentFee,
        this.candidateAvailabilityStatusChangeFormDhAgentFeeAgentFeeLastUpdateDatetime,
        this.candidateAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCode,
        this.candidateAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime,
        this.candidateAvailabilityStatusChangeFormDhCandidateAvailabilityStatusTypeAvailabilityStatus,
        this.candidateAvailabilityStatusChangeFormDhCandidateAvailabilityStatusTypeAvailabilityStatusLastUpdateDatetime,
        this.candidateAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryName,
        this.candidateAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime,
        this.candidateAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoice,
        this.candidateAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime,
        this.candidateAvailabilityStatusChangeFormDhTaskTypeTaskType,
        this.candidateAvailabilityStatusChangeFormDhTaskTypeTaskTypeLastUpdateDatetime,
        this.candidateAvailabilityStatusChangeFormSwReligionTypeReligion,
        this.candidateAvailabilityStatusChangeFormSwReligionTypeReligionLastUpdateDatetime,
        this.candidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName,
        this.candidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryNameLastUpdateDatetime,
        this.candidateEmployerProfileCreationStep1FormSwCountryCallingCodeIbanAlpha2Code,
        this.candidateEmployerProfileCreationStep1FormSwCountryCallingCodeIbanAlpha2CodeLastUpdateDatetime,
        this.candidateEmployerProfileCreationStep1FormSwGenderTypeGender,
        this.candidateEmployerProfileCreationStep1FormSwGenderTypeGenderLastUpdateDatetime,
        this.candidateEmployerProfileCreationStep1FormSwReligionTypeReligion,
        this.candidateEmployerProfileCreationStep1FormSwReligionTypeReligionLastUpdateDatetime,
        this.candidateEmployerProfileCreationStep1Form2SwCountryCallingCodeCountryName,
        this.candidateEmployerProfileCreationStep1Form2SwCountryCallingCodeCountryNameLastUpdateDatetime,
        this.candidateEmploymentHistoryFormSwCountryCallingCodeCountryName,
        this.candidateEmploymentHistoryFormSwCountryCallingCodeCountryNameLastUpdateDatetime,
        this.candidateMyAccountFormDhAppLocaleTypeAppLocale,
        this.candidateMyAccountFormDhAppLocaleTypeAppLocaleLastUpdateDatetime,
        this.candidateOfferAcceptOrRejectFormDhAppLocaleTypeCurrencyCode,
        this.candidateOfferAcceptOrRejectFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime,
        this.candidateProfileCreationStep2FormDhCandidateFamilyMemberTypeMemberType,
        this.candidateProfileCreationStep2FormDhCandidateFamilyMemberTypeMemberTypeLastUpdateDatetime,
        this.candidateProfileCreationStep2FormDhCandidateFamilyStatusTypeFamilyStatus,
        this.candidateProfileCreationStep2FormDhCandidateFamilyStatusTypeFamilyStatusLastUpdateDatetime,
        this.candidateProfileCreationStep3FormDhCandidateAcademicQualificationTypeQualification,
        this.candidateProfileCreationStep3FormDhCandidateAcademicQualificationTypeQualificationLastUpdateDatetime,
        this.candidateProfileCreationStep3FormDhTaskTypeTaskType,
        this.candidateProfileCreationStep3FormDhTaskTypeTaskTypeLastUpdateDatetime,
        this.candidateProfileCreationStep5FormDhTaskTypeTaskType,
        this.candidateProfileCreationStep5FormDhTaskTypeTaskTypeLastUpdateDatetime,
        this.candidateSimpleSearchFormDhAgentFeeAgentFee,
        this.candidateSimpleSearchFormDhAgentFeeAgentFeeLastUpdateDatetime,
        this.candidateSimpleSearchFormDhAppLocaleTypeCurrencyCode,
        this.candidateSimpleSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime,
        this.candidateSimpleSearchFormDhCountryOfEmployerWorkCountryName,
        this.candidateSimpleSearchFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime,
        this.colorTagFamily,
        this.colorTagFamilyLastUpdateDatetime,
        this.colorTagLanguage,
        this.colorTagLanguageLastUpdateDatetime,
        this.colorTagSkill,
        this.colorTagSkillLastUpdateDatetime,
        this.colorTagTransferMaid,
        this.colorTagTransferMaidLastUpdateDatetime,
        this.customerSupportFormDhContactIssueTypeContactIssue,
        this.customerSupportFormDhContactIssueTypeContactIssueLastUpdateDatetime,
        this.customerSupportFormSwCountryCallingCodeCountryName,
        this.customerSupportFormSwCountryCallingCodeCountryNameLastUpdateDatetime,
        this.dhAppLocaleTypePhc100000ForexValue,
        this.dhAppLocaleTypePhc100000ForexValueLastUpdateDatetime,
        this.dhArticleCommentComplaintMaxCount,
        this.dhArticleCommentComplaintMaxCountLastUpdateDatetime,
        this.dhArticleComplaintMaxCount,
        this.dhArticleComplaintMaxCountLastUpdateDatetime,
        this.dhCandidateCreateAccountCoinRewardForReferer,
        this.dhCandidateCreateAccountCoinRewardForRefererLastUpdateDatetime,
        this.dhCandidateProfileProgressPerStep,
        this.dhCandidateProfileProgressPerStepLastUpdateDatetime,
        this.dhCandidateVerifyPhoneCoinRewardForReferer,
        this.dhCandidateVerifyPhoneCoinRewardForRefererLastUpdateDatetime,
        this.dhCandidateVerifyWorkpermitCoinRewardForReferee,
        this.dhCandidateVerifyWorkpermitCoinRewardForRefereeLastUpdateDatetime,
        this.dhCandidateVerifyWorkpermitCoinRewardForReferer,
        this.dhCandidateVerifyWorkpermitCoinRewardForRefererLastUpdateDatetime,
        this.dhEmployerCreateAccountCoinRewardForReferer,
        this.dhEmployerCreateAccountCoinRewardForRefererLastUpdateDatetime,
        this.dhEmployerProfileProgressPerStep,
        this.dhEmployerProfileProgressPerStepLastUpdateDatetime,
        this.dhEmployerVerifyPhoneCoinRewardForReferer,
        this.dhEmployerVerifyPhoneCoinRewardForRefererLastUpdateDatetime,
        this.dhProfileComplaintMaxCount,
        this.dhProfileComplaintMaxCountLastUpdateDatetime,
        this.dhProfileCompletionCoinReward,
        this.dhProfileCompletionCoinRewardLastUpdateDatetime,
        this.dhProfileCompletionVoucherReward,
        this.dhProfileCompletionVoucherRewardLastUpdateDatetime,
        this.dialPrependSpecialMy,
        this.dialPrependSpecialMyLastUpdateDatetime,
        this.employerAdvancedSearchFormDhAppLocaleTypeCurrencyCode,
        this.employerAdvancedSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime,
        this.employerAdvancedSearchFormDhCountryOfCandidateSourceCountryName,
        this.employerAdvancedSearchFormDhCountryOfCandidateSourceCountryNameLastUpdateDatetime,
        this.employerAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoice,
        this.employerAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime,
        this.employerAdvancedSearchFormDhTaskTypeTaskType,
        this.employerAdvancedSearchFormDhTaskTypeTaskTypeLastUpdateDatetime,
        this.employerAdvancedSearchFormSwReligionTypeReligion,
        this.employerAdvancedSearchFormSwReligionTypeReligionLastUpdateDatetime,
        this.employerAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCode,
        this.employerAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime,
        this.employerAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryName,
        this.employerAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime,
        this.employerAvailabilityStatusChangeFormDhEmployerAvailabilityStatusTypeAvailabilityStatus,
        this.employerAvailabilityStatusChangeFormDhEmployerAvailabilityStatusTypeAvailabilityStatusLastUpdateDatetime,
        this.employerAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoice,
        this.employerAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime,
        this.employerAvailabilityStatusChangeFormDhTaskTypeTaskType,
        this.employerAvailabilityStatusChangeFormDhTaskTypeTaskTypeLastUpdateDatetime,
        this.employerAvailabilityStatusChangeFormSwReligionTypeReligion,
        this.employerAvailabilityStatusChangeFormSwReligionTypeReligionLastUpdateDatetime,
        this.employerMyAccountFormDhAppLocaleTypeAppLocale,
        this.employerMyAccountFormDhAppLocaleTypeAppLocaleLastUpdateDatetime,
        this.employerOfferFormDhAppLocaleTypeCurrencyCode,
        this.employerOfferFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime,
        this.employerProfileCreationStep2FormDhEmployerFamilyMemberTypeMemberType,
        this.employerProfileCreationStep2FormDhEmployerFamilyMemberTypeMemberTypeLastUpdateDatetime,
        this.employerProfileCreationStep2FormDhEmployerFamilyStatusTypeFamilyStatus,
        this.employerProfileCreationStep2FormDhEmployerFamilyStatusTypeFamilyStatusLastUpdateDatetime,
        this.employerSimpleSearchFormDhAppLocaleTypeCurrencyCode,
        this.employerSimpleSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime,
        this.employerSimpleSearchFormDhCountryOfCandidateSourceCountryName,
        this.employerSimpleSearchFormDhCountryOfCandidateSourceCountryNameLastUpdateDatetime,
        this.forgotPasswordFormSwCountryCallingCodeCountryName,
        this.forgotPasswordFormSwCountryCallingCodeCountryNameLastUpdateDatetime,
        this.loginPhoneNumberFormSwCountryCallingCodeCountryName,
        this.loginPhoneNumberFormSwCountryCallingCodeCountryNameLastUpdateDatetime,
        this.maxCallCount,
        this.maxCallCountLastUpdateDatetime,
        this.maxCallTimeLength,
        this.maxCallTimeLengthLastUpdateDatetime,
        this.maxConcurrentInterview,
        this.maxConcurrentInterviewLastUpdateDatetime,
        this.maxConnectionPerDay,
        this.maxConnectionPerDayLastUpdateDatetime,
        this.maxDailyViewCount,
        this.maxDailyViewCountLastUpdateDatetime,
        this.maxEmployerOfferValidDay,
        this.maxEmployerOfferValidDayLastUpdateDatetime,
        this.maxMonthlySalaryInSgd,
        this.maxMonthlySalaryInSgdLastUpdateDatetime,
        this.maxStarlistCount,
        this.maxStarlistCountLastUpdateDatetime,
        this.minCallTimeLength,
        this.minCallTimeLengthLastUpdateDatetime,
        this.minMonthlySalaryInSgd,
        this.minMonthlySalaryInSgdLastUpdateDatetime,
        this.myAccountFormDhLanguageTypeLanguage,
        this.myAccountFormDhLanguageTypeLanguageLastUpdateDatetime,
        this.prospectRepeatViewDay,
        this.prospectRepeatViewDayLastUpdateDatetime,
        this.registerPhoneNumberFormSwCountryCallingCodeCountryName,
        this.registerPhoneNumberFormSwCountryCallingCodeCountryNameLastUpdateDatetime,
        this.rewardListFormDhAppLocaleTypeAppLocale,
        this.rewardListFormDhAppLocaleTypeAppLocaleLastUpdateDatetime,
        this.searchFormDhAppLocaleTypeAppLocale,
        this.searchFormDhAppLocaleTypeAppLocaleLastUpdateDatetime,
        this.sidebarAppFirstTimeLoadFormDhAppLocaleTypeAppLocale,
        this.sidebarAppFirstTimeLoadFormDhAppLocaleTypeAppLocaleLastUpdateDatetime,
        this.sidebarAppFirstTimeLoadFormDhLanguageTypeLanguage,
        this.sidebarAppFirstTimeLoadFormDhLanguageTypeLanguageLastUpdateDatetime,
        this.verifyWorkPermitDelayHour,
        this.verifyWorkPermitDelayHourLastUpdateDatetime,
        this.workPermitFormDhAppLocaleTypeAppLocale,
        this.workPermitFormDhAppLocaleTypeAppLocaleLastUpdateDatetime,
        this.storagePrefix,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        articleCreateFormDhLanguageTypeLanguage: json["ARTICLE_CREATE_FORM.DH_LANGUAGE_TYPE.language"] == null ? [] : List<FormDhLanguageTypeLanguage>.from(json["ARTICLE_CREATE_FORM.DH_LANGUAGE_TYPE.language"]!.map((x) => FormDhLanguageTypeLanguage.fromMap(x))),
        articleCreateFormDhLanguageTypeLanguageLastUpdateDatetime: json["ARTICLE_CREATE_FORM.DH_LANGUAGE_TYPE.language.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["ARTICLE_CREATE_FORM.DH_LANGUAGE_TYPE.language.LAST_UPDATE_DATETIME"]),
        articleListFormDhLanguageTypeLanguage: json["ARTICLE_LIST_FORM.DH_LANGUAGE_TYPE.language"] == null ? [] : List<FormDhLanguageTypeLanguage>.from(json["ARTICLE_LIST_FORM.DH_LANGUAGE_TYPE.language"]!.map((x) => FormDhLanguageTypeLanguage.fromMap(x))),
        articleListFormDhLanguageTypeLanguageLastUpdateDatetime: json["ARTICLE_LIST_FORM.DH_LANGUAGE_TYPE.language.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["ARTICLE_LIST_FORM.DH_LANGUAGE_TYPE.language.LAST_UPDATE_DATETIME"]),
        candidateAdvancedSearchFormDhAgentFeeAgentFee: json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_AGENT_FEE.agent_fee"] == null ? [] : List<String>.from(json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_AGENT_FEE.agent_fee"]!.map((x) => x)),
        candidateAdvancedSearchFormDhAgentFeeAgentFeeLastUpdateDatetime: json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_AGENT_FEE.agent_fee.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_AGENT_FEE.agent_fee.LAST_UPDATE_DATETIME"]),
        candidateAdvancedSearchFormDhAppLocaleTypeCurrencyCode: json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code"] == null ? [] : List<FormDhAppLocaleTypeCurrencyCode>.from(json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code"]!.map((x) => FormDhAppLocaleTypeCurrencyCode.fromMap(x))),
        candidateAdvancedSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime: json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"]),
        candidateAdvancedSearchFormDhCountryOfEmployerWorkCountryName: json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name"] == null ? [] : List<CountryName>.from(json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name"]!.map((x) => CountryName.fromMap(x))),
        candidateAdvancedSearchFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime: json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name.LAST_UPDATE_DATETIME"]),
        candidateAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoice: json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice"] == null ? [] : List<FormDhRestDayTypeRestDayPerMonthChoice>.from(json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice"]!.map((x) => FormDhRestDayTypeRestDayPerMonthChoice.fromMap(x))),
        candidateAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime: json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice.LAST_UPDATE_DATETIME"]),
        candidateAdvancedSearchFormDhTaskTypeTaskType: json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_TASK_TYPE.task_type"] == null ? [] : List<String>.from(json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_TASK_TYPE.task_type"]!.map((x) => x)),
        candidateAdvancedSearchFormDhTaskTypeTaskTypeLastUpdateDatetime: json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_ADVANCED_SEARCH_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME"]),
        candidateAdvancedSearchFormSwReligionTypeReligion: json["CANDIDATE_ADVANCED_SEARCH_FORM.SW-RELIGION_TYPE.religion"] == null ? [] : List<String>.from(json["CANDIDATE_ADVANCED_SEARCH_FORM.SW-RELIGION_TYPE.religion"]!.map((x) => x)),
        candidateAdvancedSearchFormSwReligionTypeReligionLastUpdateDatetime: json["CANDIDATE_ADVANCED_SEARCH_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_ADVANCED_SEARCH_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME"]),
        candidateAvailabilityStatusChangeFormDhAgentFeeAgentFee: json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_AGENT_FEE.agent_fee"] == null ? [] : List<String>.from(json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_AGENT_FEE.agent_fee"]!.map((x) => x)),
        candidateAvailabilityStatusChangeFormDhAgentFeeAgentFeeLastUpdateDatetime: json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_AGENT_FEE.agent_fee.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_AGENT_FEE.agent_fee.LAST_UPDATE_DATETIME"]),
        candidateAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCode: json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_APP_LOCALE_TYPE.currency_code"] == null ? [] : List<FormDhAppLocaleTypeCurrencyCode>.from(json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_APP_LOCALE_TYPE.currency_code"]!.map((x) => FormDhAppLocaleTypeCurrencyCode.fromMap(x))),
        candidateAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime: json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"]),
        candidateAvailabilityStatusChangeFormDhCandidateAvailabilityStatusTypeAvailabilityStatus: json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_CANDIDATE_AVAILABILITY_STATUS_TYPE.availability_status"] == null ? [] : List<AvailabilityStatusTypeAvailabilityStatus>.from(json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_CANDIDATE_AVAILABILITY_STATUS_TYPE.availability_status"]!.map((x) => AvailabilityStatusTypeAvailabilityStatus.fromMap(x))),
        candidateAvailabilityStatusChangeFormDhCandidateAvailabilityStatusTypeAvailabilityStatusLastUpdateDatetime: json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_CANDIDATE_AVAILABILITY_STATUS_TYPE.availability_status.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_CANDIDATE_AVAILABILITY_STATUS_TYPE.availability_status.LAST_UPDATE_DATETIME"]),
        candidateAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryName: json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name"] == null ? [] : List<CountryName>.from(json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name"]!.map((x) => CountryName.fromMap(x))),
        candidateAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime: json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name.LAST_UPDATE_DATETIME"]),
        candidateAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoice: json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice"] == null ? [] : List<FormDhRestDayTypeRestDayPerMonthChoice>.from(json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice"]!.map((x) => FormDhRestDayTypeRestDayPerMonthChoice.fromMap(x))),
        candidateAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime: json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice.LAST_UPDATE_DATETIME"]),
        candidateAvailabilityStatusChangeFormDhTaskTypeTaskType: json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_TASK_TYPE.task_type"] == null ? [] : List<String>.from(json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_TASK_TYPE.task_type"]!.map((x) => x)),
        candidateAvailabilityStatusChangeFormDhTaskTypeTaskTypeLastUpdateDatetime: json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME"]),
        candidateAvailabilityStatusChangeFormSwReligionTypeReligion: json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.SW-RELIGION_TYPE.religion"] == null ? [] : List<String>.from(json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.SW-RELIGION_TYPE.religion"]!.map((x) => x)),
        candidateAvailabilityStatusChangeFormSwReligionTypeReligionLastUpdateDatetime: json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME"]),
        candidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName: json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-COUNTRY_CALLING_CODE.country_name"] == null ? [] : List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>.from(json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-COUNTRY_CALLING_CODE.country_name"]!.map((x) => CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName.fromMap(x))),
        candidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryNameLastUpdateDatetime: json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME"]),
        candidateEmployerProfileCreationStep1FormSwCountryCallingCodeIbanAlpha2Code: json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-COUNTRY_CALLING_CODE.iban_alpha_2_code"] == null ? [] : List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>.from(json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-COUNTRY_CALLING_CODE.iban_alpha_2_code"]!.map((x) => CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName.fromMap(x))),
        candidateEmployerProfileCreationStep1FormSwCountryCallingCodeIbanAlpha2CodeLastUpdateDatetime: json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-COUNTRY_CALLING_CODE.iban_alpha_2_code.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-COUNTRY_CALLING_CODE.iban_alpha_2_code.LAST_UPDATE_DATETIME"]),
        candidateEmployerProfileCreationStep1FormSwGenderTypeGender: json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-GENDER_TYPE.gender"] == null ? [] : List<String>.from(json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-GENDER_TYPE.gender"]!.map((x) => x)),
        candidateEmployerProfileCreationStep1FormSwGenderTypeGenderLastUpdateDatetime: json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-GENDER_TYPE.gender.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-GENDER_TYPE.gender.LAST_UPDATE_DATETIME"]),
        candidateEmployerProfileCreationStep1FormSwReligionTypeReligion: json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-RELIGION_TYPE.religion"] == null ? [] : List<String>.from(json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-RELIGION_TYPE.religion"]!.map((x) => x)),
        candidateEmployerProfileCreationStep1FormSwReligionTypeReligionLastUpdateDatetime: json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME"]),
        candidateEmployerProfileCreationStep1Form2SwCountryCallingCodeCountryName: json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM2.SW-COUNTRY_CALLING_CODE.country_name"] == null ? [] : List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>.from(json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM2.SW-COUNTRY_CALLING_CODE.country_name"]!.map((x) => CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName.fromMap(x))),
        candidateEmployerProfileCreationStep1Form2SwCountryCallingCodeCountryNameLastUpdateDatetime: json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM2.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM2.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME"]),
        candidateEmploymentHistoryFormSwCountryCallingCodeCountryName: json["CANDIDATE_EMPLOYMENT_HISTORY_FORM.SW-COUNTRY_CALLING_CODE.country_name"] == null ? [] : List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>.from(json["CANDIDATE_EMPLOYMENT_HISTORY_FORM.SW-COUNTRY_CALLING_CODE.country_name"]!.map((x) => CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName.fromMap(x))),
        candidateEmploymentHistoryFormSwCountryCallingCodeCountryNameLastUpdateDatetime: json["CANDIDATE_EMPLOYMENT_HISTORY_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_EMPLOYMENT_HISTORY_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME"]),
        candidateMyAccountFormDhAppLocaleTypeAppLocale: json["CANDIDATE_MY_ACCOUNT_FORM.DH_APP_LOCALE_TYPE.app_locale"] == null ? [] : List<FormDhAppLocaleTypeAppLocale>.from(json["CANDIDATE_MY_ACCOUNT_FORM.DH_APP_LOCALE_TYPE.app_locale"]!.map((x) => FormDhAppLocaleTypeAppLocale.fromMap(x))),
        candidateMyAccountFormDhAppLocaleTypeAppLocaleLastUpdateDatetime: json["CANDIDATE_MY_ACCOUNT_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_MY_ACCOUNT_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME"]),
        candidateOfferAcceptOrRejectFormDhAppLocaleTypeCurrencyCode: json["CANDIDATE_OFFER_ACCEPT_OR_REJECT_FORM.DH_APP_LOCALE_TYPE.currency_code"] == null ? [] : List<FormDhAppLocaleTypeCurrencyCode>.from(json["CANDIDATE_OFFER_ACCEPT_OR_REJECT_FORM.DH_APP_LOCALE_TYPE.currency_code"]!.map((x) => FormDhAppLocaleTypeCurrencyCode.fromMap(x))),
        candidateOfferAcceptOrRejectFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime: json["CANDIDATE_OFFER_ACCEPT_OR_REJECT_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_OFFER_ACCEPT_OR_REJECT_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"]),
        candidateProfileCreationStep2FormDhCandidateFamilyMemberTypeMemberType: json["CANDIDATE_PROFILE_CREATION_STEP2_FORM.DH_CANDIDATE_FAMILY_MEMBER_TYPE.member_type"] == null ? [] : List<String>.from(json["CANDIDATE_PROFILE_CREATION_STEP2_FORM.DH_CANDIDATE_FAMILY_MEMBER_TYPE.member_type"]!.map((x) => x)),
        candidateProfileCreationStep2FormDhCandidateFamilyMemberTypeMemberTypeLastUpdateDatetime: json["CANDIDATE_PROFILE_CREATION_STEP2_FORM.DH_CANDIDATE_FAMILY_MEMBER_TYPE.member_type.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_PROFILE_CREATION_STEP2_FORM.DH_CANDIDATE_FAMILY_MEMBER_TYPE.member_type.LAST_UPDATE_DATETIME"]),
        candidateProfileCreationStep2FormDhCandidateFamilyStatusTypeFamilyStatus: json["CANDIDATE_PROFILE_CREATION_STEP2_FORM.DH_CANDIDATE_FAMILY_STATUS_TYPE.family_status"] == null ? [] : List<String>.from(json["CANDIDATE_PROFILE_CREATION_STEP2_FORM.DH_CANDIDATE_FAMILY_STATUS_TYPE.family_status"]!.map((x) => x)),
        candidateProfileCreationStep2FormDhCandidateFamilyStatusTypeFamilyStatusLastUpdateDatetime: json["CANDIDATE_PROFILE_CREATION_STEP2_FORM.DH_CANDIDATE_FAMILY_STATUS_TYPE.family_status.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_PROFILE_CREATION_STEP2_FORM.DH_CANDIDATE_FAMILY_STATUS_TYPE.family_status.LAST_UPDATE_DATETIME"]),
        candidateProfileCreationStep3FormDhCandidateAcademicQualificationTypeQualification: json["CANDIDATE_PROFILE_CREATION_STEP3_FORM.DH_CANDIDATE_ACADEMIC_QUALIFICATION_TYPE.qualification"] == null ? [] : List<String>.from(json["CANDIDATE_PROFILE_CREATION_STEP3_FORM.DH_CANDIDATE_ACADEMIC_QUALIFICATION_TYPE.qualification"]!.map((x) => x)),
        candidateProfileCreationStep3FormDhCandidateAcademicQualificationTypeQualificationLastUpdateDatetime: json["CANDIDATE_PROFILE_CREATION_STEP3_FORM.DH_CANDIDATE_ACADEMIC_QUALIFICATION_TYPE.qualification.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_PROFILE_CREATION_STEP3_FORM.DH_CANDIDATE_ACADEMIC_QUALIFICATION_TYPE.qualification.LAST_UPDATE_DATETIME"]),
        candidateProfileCreationStep3FormDhTaskTypeTaskType: json["CANDIDATE_PROFILE_CREATION_STEP3_FORM.DH_TASK_TYPE.task_type"] == null ? [] : List<String>.from(json["CANDIDATE_PROFILE_CREATION_STEP3_FORM.DH_TASK_TYPE.task_type"]!.map((x) => x)),
        candidateProfileCreationStep3FormDhTaskTypeTaskTypeLastUpdateDatetime: json["CANDIDATE_PROFILE_CREATION_STEP3_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_PROFILE_CREATION_STEP3_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME"]),
        candidateProfileCreationStep5FormDhTaskTypeTaskType: json["CANDIDATE_PROFILE_CREATION_STEP5_FORM.DH_TASK_TYPE.task_type"] == null ? [] : List<String>.from(json["CANDIDATE_PROFILE_CREATION_STEP5_FORM.DH_TASK_TYPE.task_type"]!.map((x) => x)),
        candidateProfileCreationStep5FormDhTaskTypeTaskTypeLastUpdateDatetime: json["CANDIDATE_PROFILE_CREATION_STEP5_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_PROFILE_CREATION_STEP5_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME"]),
        candidateSimpleSearchFormDhAgentFeeAgentFee: json["CANDIDATE_SIMPLE_SEARCH_FORM.DH_AGENT_FEE.agent_fee"] == null ? [] : List<String>.from(json["CANDIDATE_SIMPLE_SEARCH_FORM.DH_AGENT_FEE.agent_fee"]!.map((x) => x)),
        candidateSimpleSearchFormDhAgentFeeAgentFeeLastUpdateDatetime: json["CANDIDATE_SIMPLE_SEARCH_FORM.DH_AGENT_FEE.agent_fee.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_SIMPLE_SEARCH_FORM.DH_AGENT_FEE.agent_fee.LAST_UPDATE_DATETIME"]),
        candidateSimpleSearchFormDhAppLocaleTypeCurrencyCode: json["CANDIDATE_SIMPLE_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code"] == null ? [] : List<FormDhAppLocaleTypeCurrencyCode>.from(json["CANDIDATE_SIMPLE_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code"]!.map((x) => FormDhAppLocaleTypeCurrencyCode.fromMap(x))),
        candidateSimpleSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime: json["CANDIDATE_SIMPLE_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_SIMPLE_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"]),
        candidateSimpleSearchFormDhCountryOfEmployerWorkCountryName: json["CANDIDATE_SIMPLE_SEARCH_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name"] == null ? [] : List<CountryName>.from(json["CANDIDATE_SIMPLE_SEARCH_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name"]!.map((x) => CountryName.fromMap(x))),
        candidateSimpleSearchFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime: json["CANDIDATE_SIMPLE_SEARCH_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CANDIDATE_SIMPLE_SEARCH_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name.LAST_UPDATE_DATETIME"]),
        colorTagFamily: json["COLOR_TAG_FAMILY"],
        colorTagFamilyLastUpdateDatetime: json["COLOR_TAG_FAMILY.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["COLOR_TAG_FAMILY.LAST_UPDATE_DATETIME"]),
        colorTagLanguage: json["COLOR_TAG_LANGUAGE"],
        colorTagLanguageLastUpdateDatetime: json["COLOR_TAG_LANGUAGE.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["COLOR_TAG_LANGUAGE.LAST_UPDATE_DATETIME"]),
        colorTagSkill: json["COLOR_TAG_SKILL"],
        colorTagSkillLastUpdateDatetime: json["COLOR_TAG_SKILL.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["COLOR_TAG_SKILL.LAST_UPDATE_DATETIME"]),
        colorTagTransferMaid: json["COLOR_TAG_TRANSFER_MAID"],
        colorTagTransferMaidLastUpdateDatetime: json["COLOR_TAG_TRANSFER_MAID.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["COLOR_TAG_TRANSFER_MAID.LAST_UPDATE_DATETIME"]),
        customerSupportFormDhContactIssueTypeContactIssue: json["CUSTOMER_SUPPORT_FORM.DH_CONTACT_ISSUE_TYPE.contact_issue"] == null ? [] : List<String>.from(json["CUSTOMER_SUPPORT_FORM.DH_CONTACT_ISSUE_TYPE.contact_issue"]!.map((x) => x)),
        customerSupportFormDhContactIssueTypeContactIssueLastUpdateDatetime: json["CUSTOMER_SUPPORT_FORM.DH_CONTACT_ISSUE_TYPE.contact_issue.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CUSTOMER_SUPPORT_FORM.DH_CONTACT_ISSUE_TYPE.contact_issue.LAST_UPDATE_DATETIME"]),
        customerSupportFormSwCountryCallingCodeCountryName: json["CUSTOMER_SUPPORT_FORM.SW-COUNTRY_CALLING_CODE.country_name"] == null ? [] : List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>.from(json["CUSTOMER_SUPPORT_FORM.SW-COUNTRY_CALLING_CODE.country_name"]!.map((x) => CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName.fromMap(x))),
        customerSupportFormSwCountryCallingCodeCountryNameLastUpdateDatetime: json["CUSTOMER_SUPPORT_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["CUSTOMER_SUPPORT_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME"]),
        dhAppLocaleTypePhc100000ForexValue: json["DH_APP_LOCALE_TYPE.PHC_100000_FOREX_value"] == null ? [] : List<DhAppLocaleTypePhc100000ForexValue>.from(json["DH_APP_LOCALE_TYPE.PHC_100000_FOREX_value"]!.map((x) => DhAppLocaleTypePhc100000ForexValue.fromMap(x))),
        dhAppLocaleTypePhc100000ForexValueLastUpdateDatetime: json["DH_APP_LOCALE_TYPE.PHC_100000_FOREX_value.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DH_APP_LOCALE_TYPE.PHC_100000_FOREX_value.LAST_UPDATE_DATETIME"]),
        dhArticleCommentComplaintMaxCount: json["DH_ARTICLE_COMMENT_COMPLAINT_MAX_COUNT"],
        dhArticleCommentComplaintMaxCountLastUpdateDatetime: json["DH_ARTICLE_COMMENT_COMPLAINT_MAX_COUNT.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DH_ARTICLE_COMMENT_COMPLAINT_MAX_COUNT.LAST_UPDATE_DATETIME"]),
        dhArticleComplaintMaxCount: json["DH_ARTICLE_COMPLAINT_MAX_COUNT"],
        dhArticleComplaintMaxCountLastUpdateDatetime: json["DH_ARTICLE_COMPLAINT_MAX_COUNT.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DH_ARTICLE_COMPLAINT_MAX_COUNT.LAST_UPDATE_DATETIME"]),
        dhCandidateCreateAccountCoinRewardForReferer: json["DH_CANDIDATE_CREATE_ACCOUNT_COIN_REWARD_FOR_REFERER"] == null ? null : Dh.fromMap(json["DH_CANDIDATE_CREATE_ACCOUNT_COIN_REWARD_FOR_REFERER"]),
        dhCandidateCreateAccountCoinRewardForRefererLastUpdateDatetime: json["DH_CANDIDATE_CREATE_ACCOUNT_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DH_CANDIDATE_CREATE_ACCOUNT_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME"]),
        dhCandidateProfileProgressPerStep: json["DH_CANDIDATE_PROFILE_PROGRESS_PER_STEP"],
        dhCandidateProfileProgressPerStepLastUpdateDatetime: json["DH_CANDIDATE_PROFILE_PROGRESS_PER_STEP.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DH_CANDIDATE_PROFILE_PROGRESS_PER_STEP.LAST_UPDATE_DATETIME"]),
        dhCandidateVerifyPhoneCoinRewardForReferer: json["DH_CANDIDATE_VERIFY_PHONE_COIN_REWARD_FOR_REFERER"] == null ? null : Dh.fromMap(json["DH_CANDIDATE_VERIFY_PHONE_COIN_REWARD_FOR_REFERER"]),
        dhCandidateVerifyPhoneCoinRewardForRefererLastUpdateDatetime: json["DH_CANDIDATE_VERIFY_PHONE_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DH_CANDIDATE_VERIFY_PHONE_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME"]),
        dhCandidateVerifyWorkpermitCoinRewardForReferee: json["DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFEREE"] == null ? null : Dh.fromMap(json["DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFEREE"]),
        dhCandidateVerifyWorkpermitCoinRewardForRefereeLastUpdateDatetime: json["DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFEREE.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFEREE.LAST_UPDATE_DATETIME"]),
        dhCandidateVerifyWorkpermitCoinRewardForReferer: json["DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFERER"] == null ? null : Dh.fromMap(json["DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFERER"]),
        dhCandidateVerifyWorkpermitCoinRewardForRefererLastUpdateDatetime: json["DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME"]),
        dhEmployerCreateAccountCoinRewardForReferer: json["DH_EMPLOYER_CREATE_ACCOUNT_COIN_REWARD_FOR_REFERER"] == null ? null : Dh.fromMap(json["DH_EMPLOYER_CREATE_ACCOUNT_COIN_REWARD_FOR_REFERER"]),
        dhEmployerCreateAccountCoinRewardForRefererLastUpdateDatetime: json["DH_EMPLOYER_CREATE_ACCOUNT_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DH_EMPLOYER_CREATE_ACCOUNT_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME"]),
        dhEmployerProfileProgressPerStep: json["DH_EMPLOYER_PROFILE_PROGRESS_PER_STEP"],
        dhEmployerProfileProgressPerStepLastUpdateDatetime: json["DH_EMPLOYER_PROFILE_PROGRESS_PER_STEP.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DH_EMPLOYER_PROFILE_PROGRESS_PER_STEP.LAST_UPDATE_DATETIME"]),
        dhEmployerVerifyPhoneCoinRewardForReferer: json["DH_EMPLOYER_VERIFY_PHONE_COIN_REWARD_FOR_REFERER"] == null ? null : Dh.fromMap(json["DH_EMPLOYER_VERIFY_PHONE_COIN_REWARD_FOR_REFERER"]),
        dhEmployerVerifyPhoneCoinRewardForRefererLastUpdateDatetime: json["DH_EMPLOYER_VERIFY_PHONE_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DH_EMPLOYER_VERIFY_PHONE_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME"]),
        dhProfileComplaintMaxCount: json["DH_PROFILE_COMPLAINT_MAX_COUNT"],
        dhProfileComplaintMaxCountLastUpdateDatetime: json["DH_PROFILE_COMPLAINT_MAX_COUNT.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DH_PROFILE_COMPLAINT_MAX_COUNT.LAST_UPDATE_DATETIME"]),
        dhProfileCompletionCoinReward: json["DH_PROFILE_COMPLETION_COIN_REWARD"],
        dhProfileCompletionCoinRewardLastUpdateDatetime: json["DH_PROFILE_COMPLETION_COIN_REWARD.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DH_PROFILE_COMPLETION_COIN_REWARD.LAST_UPDATE_DATETIME"]),
        dhProfileCompletionVoucherReward: json["DH_PROFILE_COMPLETION_VOUCHER_REWARD"],
        dhProfileCompletionVoucherRewardLastUpdateDatetime: json["DH_PROFILE_COMPLETION_VOUCHER_REWARD.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DH_PROFILE_COMPLETION_VOUCHER_REWARD.LAST_UPDATE_DATETIME"]),
        dialPrependSpecialMy: json["DIAL_PREPEND_SPECIAL_MY"],
        dialPrependSpecialMyLastUpdateDatetime: json["DIAL_PREPEND_SPECIAL_MY.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["DIAL_PREPEND_SPECIAL_MY.LAST_UPDATE_DATETIME"]),
        employerAdvancedSearchFormDhAppLocaleTypeCurrencyCode: json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code"] == null ? [] : List<FormDhAppLocaleTypeCurrencyCode>.from(json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code"]!.map((x) => FormDhAppLocaleTypeCurrencyCode.fromMap(x))),
        employerAdvancedSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime: json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"]),
        employerAdvancedSearchFormDhCountryOfCandidateSourceCountryName: json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_COUNTRY_OF_CANDIDATE_SOURCE.country_name"] == null ? [] : List<CountryName>.from(json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_COUNTRY_OF_CANDIDATE_SOURCE.country_name"]!.map((x) => CountryName.fromMap(x))),
        employerAdvancedSearchFormDhCountryOfCandidateSourceCountryNameLastUpdateDatetime: json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_COUNTRY_OF_CANDIDATE_SOURCE.country_name.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_COUNTRY_OF_CANDIDATE_SOURCE.country_name.LAST_UPDATE_DATETIME"]),
        employerAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoice: json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice"] == null ? [] : List<FormDhRestDayTypeRestDayPerMonthChoice>.from(json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice"]!.map((x) => FormDhRestDayTypeRestDayPerMonthChoice.fromMap(x))),
        employerAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime: json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice.LAST_UPDATE_DATETIME"]),
        employerAdvancedSearchFormDhTaskTypeTaskType: json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_TASK_TYPE.task_type"] == null ? [] : List<String>.from(json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_TASK_TYPE.task_type"]!.map((x) => x)),
        employerAdvancedSearchFormDhTaskTypeTaskTypeLastUpdateDatetime: json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_ADVANCED_SEARCH_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME"]),
        employerAdvancedSearchFormSwReligionTypeReligion: json["EMPLOYER_ADVANCED_SEARCH_FORM.SW-RELIGION_TYPE.religion"] == null ? [] : List<String>.from(json["EMPLOYER_ADVANCED_SEARCH_FORM.SW-RELIGION_TYPE.religion"]!.map((x) => x)),
        employerAdvancedSearchFormSwReligionTypeReligionLastUpdateDatetime: json["EMPLOYER_ADVANCED_SEARCH_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_ADVANCED_SEARCH_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME"]),
        employerAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCode: json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_APP_LOCALE_TYPE.currency_code"] == null ? [] : List<FormDhAppLocaleTypeCurrencyCode>.from(json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_APP_LOCALE_TYPE.currency_code"]!.map((x) => FormDhAppLocaleTypeCurrencyCode.fromMap(x))),
        employerAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime: json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"]),
        employerAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryName: json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name"] == null ? [] : List<CountryName>.from(json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name"]!.map((x) => CountryName.fromMap(x))),
        employerAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime: json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name.LAST_UPDATE_DATETIME"]),
        employerAvailabilityStatusChangeFormDhEmployerAvailabilityStatusTypeAvailabilityStatus: json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_EMPLOYER_AVAILABILITY_STATUS_TYPE.availability_status"] == null ? [] : List<AvailabilityStatusTypeAvailabilityStatus>.from(json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_EMPLOYER_AVAILABILITY_STATUS_TYPE.availability_status"]!.map((x) => AvailabilityStatusTypeAvailabilityStatus.fromMap(x))),
        employerAvailabilityStatusChangeFormDhEmployerAvailabilityStatusTypeAvailabilityStatusLastUpdateDatetime: json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_EMPLOYER_AVAILABILITY_STATUS_TYPE.availability_status.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_EMPLOYER_AVAILABILITY_STATUS_TYPE.availability_status.LAST_UPDATE_DATETIME"]),
        employerAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoice: json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice"] == null ? [] : List<FormDhRestDayTypeRestDayPerMonthChoice>.from(json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice"]!.map((x) => FormDhRestDayTypeRestDayPerMonthChoice.fromMap(x))),
        employerAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime: json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice.LAST_UPDATE_DATETIME"]),
        employerAvailabilityStatusChangeFormDhTaskTypeTaskType: json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_TASK_TYPE.task_type"] == null ? [] : List<String>.from(json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_TASK_TYPE.task_type"]!.map((x) => x)),
        employerAvailabilityStatusChangeFormDhTaskTypeTaskTypeLastUpdateDatetime: json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME"]),
        employerAvailabilityStatusChangeFormSwReligionTypeReligion: json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.SW-RELIGION_TYPE.religion"] == null ? [] : List<String>.from(json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.SW-RELIGION_TYPE.religion"]!.map((x) => x)),
        employerAvailabilityStatusChangeFormSwReligionTypeReligionLastUpdateDatetime: json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME"]),
        employerMyAccountFormDhAppLocaleTypeAppLocale: json["EMPLOYER_MY_ACCOUNT_FORM.DH_APP_LOCALE_TYPE.app_locale"] == null ? [] : List<FormDhAppLocaleTypeAppLocale>.from(json["EMPLOYER_MY_ACCOUNT_FORM.DH_APP_LOCALE_TYPE.app_locale"]!.map((x) => FormDhAppLocaleTypeAppLocale.fromMap(x))),
        employerMyAccountFormDhAppLocaleTypeAppLocaleLastUpdateDatetime: json["EMPLOYER_MY_ACCOUNT_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_MY_ACCOUNT_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME"]),
        employerOfferFormDhAppLocaleTypeCurrencyCode: json["EMPLOYER_OFFER_FORM.DH_APP_LOCALE_TYPE.currency_code"] == null ? [] : List<FormDhAppLocaleTypeCurrencyCode>.from(json["EMPLOYER_OFFER_FORM.DH_APP_LOCALE_TYPE.currency_code"]!.map((x) => FormDhAppLocaleTypeCurrencyCode.fromMap(x))),
        employerOfferFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime: json["EMPLOYER_OFFER_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_OFFER_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"]),
        employerProfileCreationStep2FormDhEmployerFamilyMemberTypeMemberType: json["EMPLOYER_PROFILE_CREATION_STEP2_FORM.DH_EMPLOYER_FAMILY_MEMBER_TYPE.member_type"] == null ? [] : List<String>.from(json["EMPLOYER_PROFILE_CREATION_STEP2_FORM.DH_EMPLOYER_FAMILY_MEMBER_TYPE.member_type"]!.map((x) => x)),
        employerProfileCreationStep2FormDhEmployerFamilyMemberTypeMemberTypeLastUpdateDatetime: json["EMPLOYER_PROFILE_CREATION_STEP2_FORM.DH_EMPLOYER_FAMILY_MEMBER_TYPE.member_type.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_PROFILE_CREATION_STEP2_FORM.DH_EMPLOYER_FAMILY_MEMBER_TYPE.member_type.LAST_UPDATE_DATETIME"]),
        employerProfileCreationStep2FormDhEmployerFamilyStatusTypeFamilyStatus: json["EMPLOYER_PROFILE_CREATION_STEP2_FORM.DH_EMPLOYER_FAMILY_STATUS_TYPE.family_status"] == null ? [] : List<String>.from(json["EMPLOYER_PROFILE_CREATION_STEP2_FORM.DH_EMPLOYER_FAMILY_STATUS_TYPE.family_status"]!.map((x) => x)),
        employerProfileCreationStep2FormDhEmployerFamilyStatusTypeFamilyStatusLastUpdateDatetime: json["EMPLOYER_PROFILE_CREATION_STEP2_FORM.DH_EMPLOYER_FAMILY_STATUS_TYPE.family_status.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_PROFILE_CREATION_STEP2_FORM.DH_EMPLOYER_FAMILY_STATUS_TYPE.family_status.LAST_UPDATE_DATETIME"]),
        employerSimpleSearchFormDhAppLocaleTypeCurrencyCode: json["EMPLOYER_SIMPLE_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code"] == null ? [] : List<FormDhAppLocaleTypeCurrencyCode>.from(json["EMPLOYER_SIMPLE_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code"]!.map((x) => FormDhAppLocaleTypeCurrencyCode.fromMap(x))),
        employerSimpleSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime: json["EMPLOYER_SIMPLE_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_SIMPLE_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME"]),
        employerSimpleSearchFormDhCountryOfCandidateSourceCountryName: json["EMPLOYER_SIMPLE_SEARCH_FORM.DH_COUNTRY_OF_CANDIDATE_SOURCE.country_name"] == null ? [] : List<CountryName>.from(json["EMPLOYER_SIMPLE_SEARCH_FORM.DH_COUNTRY_OF_CANDIDATE_SOURCE.country_name"]!.map((x) => CountryName.fromMap(x))),
        employerSimpleSearchFormDhCountryOfCandidateSourceCountryNameLastUpdateDatetime: json["EMPLOYER_SIMPLE_SEARCH_FORM.DH_COUNTRY_OF_CANDIDATE_SOURCE.country_name.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["EMPLOYER_SIMPLE_SEARCH_FORM.DH_COUNTRY_OF_CANDIDATE_SOURCE.country_name.LAST_UPDATE_DATETIME"]),
        forgotPasswordFormSwCountryCallingCodeCountryName: json["FORGOT_PASSWORD_FORM.SW-COUNTRY_CALLING_CODE.country_name"] == null ? [] : List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>.from(json["FORGOT_PASSWORD_FORM.SW-COUNTRY_CALLING_CODE.country_name"]!.map((x) => CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName.fromMap(x))),
        forgotPasswordFormSwCountryCallingCodeCountryNameLastUpdateDatetime: json["FORGOT_PASSWORD_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["FORGOT_PASSWORD_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME"]),
        loginPhoneNumberFormSwCountryCallingCodeCountryName: json["LOGIN_PHONE_NUMBER_FORM.SW-COUNTRY_CALLING_CODE.country_name"] == null ? [] : List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>.from(json["LOGIN_PHONE_NUMBER_FORM.SW-COUNTRY_CALLING_CODE.country_name"]!.map((x) => CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName.fromMap(x))),
        loginPhoneNumberFormSwCountryCallingCodeCountryNameLastUpdateDatetime: json["LOGIN_PHONE_NUMBER_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["LOGIN_PHONE_NUMBER_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME"]),
        maxCallCount: json["MAX_CALL_COUNT"],
        maxCallCountLastUpdateDatetime: json["MAX_CALL_COUNT.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["MAX_CALL_COUNT.LAST_UPDATE_DATETIME"]),
        maxCallTimeLength: json["MAX_CALL_TIME_LENGTH"],
        maxCallTimeLengthLastUpdateDatetime: json["MAX_CALL_TIME_LENGTH.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["MAX_CALL_TIME_LENGTH.LAST_UPDATE_DATETIME"]),
        maxConcurrentInterview: json["MAX_CONCURRENT_INTERVIEW"],
        maxConcurrentInterviewLastUpdateDatetime: json["MAX_CONCURRENT_INTERVIEW.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["MAX_CONCURRENT_INTERVIEW.LAST_UPDATE_DATETIME"]),
        maxConnectionPerDay: json["MAX_CONNECTION_PER_DAY"],
        maxConnectionPerDayLastUpdateDatetime: json["MAX_CONNECTION_PER_DAY.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["MAX_CONNECTION_PER_DAY.LAST_UPDATE_DATETIME"]),
        maxDailyViewCount: json["MAX_DAILY_VIEW_COUNT"],
        maxDailyViewCountLastUpdateDatetime: json["MAX_DAILY_VIEW_COUNT.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["MAX_DAILY_VIEW_COUNT.LAST_UPDATE_DATETIME"]),
        maxEmployerOfferValidDay: json["MAX_EMPLOYER_OFFER_VALID_DAY"],
        maxEmployerOfferValidDayLastUpdateDatetime: json["MAX_EMPLOYER_OFFER_VALID_DAY.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["MAX_EMPLOYER_OFFER_VALID_DAY.LAST_UPDATE_DATETIME"]),
        maxMonthlySalaryInSgd: json["MAX_MONTHLY_SALARY_IN_SGD"],
        maxMonthlySalaryInSgdLastUpdateDatetime: json["MAX_MONTHLY_SALARY_IN_SGD.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["MAX_MONTHLY_SALARY_IN_SGD.LAST_UPDATE_DATETIME"]),
        maxStarlistCount: json["MAX_STARLIST_COUNT"],
        maxStarlistCountLastUpdateDatetime: json["MAX_STARLIST_COUNT.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["MAX_STARLIST_COUNT.LAST_UPDATE_DATETIME"]),
        minCallTimeLength: json["MIN_CALL_TIME_LENGTH"],
        minCallTimeLengthLastUpdateDatetime: json["MIN_CALL_TIME_LENGTH.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["MIN_CALL_TIME_LENGTH.LAST_UPDATE_DATETIME"]),
        minMonthlySalaryInSgd: json["MIN_MONTHLY_SALARY_IN_SGD"],
        minMonthlySalaryInSgdLastUpdateDatetime: json["MIN_MONTHLY_SALARY_IN_SGD.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["MIN_MONTHLY_SALARY_IN_SGD.LAST_UPDATE_DATETIME"]),
        myAccountFormDhLanguageTypeLanguage: json["MY_ACCOUNT_FORM.DH_LANGUAGE_TYPE.language"] == null ? [] : List<FormDhLanguageTypeLanguage>.from(json["MY_ACCOUNT_FORM.DH_LANGUAGE_TYPE.language"]!.map((x) => FormDhLanguageTypeLanguage.fromMap(x))),
        myAccountFormDhLanguageTypeLanguageLastUpdateDatetime: json["MY_ACCOUNT_FORM.DH_LANGUAGE_TYPE.language.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["MY_ACCOUNT_FORM.DH_LANGUAGE_TYPE.language.LAST_UPDATE_DATETIME"]),
        prospectRepeatViewDay: json["PROSPECT_REPEAT_VIEW_DAY"],
        prospectRepeatViewDayLastUpdateDatetime: json["PROSPECT_REPEAT_VIEW_DAY.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["PROSPECT_REPEAT_VIEW_DAY.LAST_UPDATE_DATETIME"]),
        registerPhoneNumberFormSwCountryCallingCodeCountryName: json["REGISTER_PHONE_NUMBER_FORM.SW-COUNTRY_CALLING_CODE.country_name"] == null ? [] : List<CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName>.from(json["REGISTER_PHONE_NUMBER_FORM.SW-COUNTRY_CALLING_CODE.country_name"]!.map((x) => CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName.fromMap(x))),
        registerPhoneNumberFormSwCountryCallingCodeCountryNameLastUpdateDatetime: json["REGISTER_PHONE_NUMBER_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["REGISTER_PHONE_NUMBER_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME"]),
        rewardListFormDhAppLocaleTypeAppLocale: json["REWARD_LIST_FORM.DH_APP_LOCALE_TYPE.app_locale"] == null ? [] : List<FormDhAppLocaleTypeAppLocale>.from(json["REWARD_LIST_FORM.DH_APP_LOCALE_TYPE.app_locale"]!.map((x) => FormDhAppLocaleTypeAppLocale.fromMap(x))),
        rewardListFormDhAppLocaleTypeAppLocaleLastUpdateDatetime: json["REWARD_LIST_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["REWARD_LIST_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME"]),
        searchFormDhAppLocaleTypeAppLocale: json["SEARCH_FORM.DH_APP_LOCALE_TYPE.app_locale"] == null ? [] : List<SearchFormDhAppLocaleTypeAppLocale>.from(json["SEARCH_FORM.DH_APP_LOCALE_TYPE.app_locale"]!.map((x) => SearchFormDhAppLocaleTypeAppLocale.fromMap(x))),
        searchFormDhAppLocaleTypeAppLocaleLastUpdateDatetime: json["SEARCH_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["SEARCH_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME"]),
        sidebarAppFirstTimeLoadFormDhAppLocaleTypeAppLocale: json["SIDEBAR_APP_FIRST_TIME_LOAD _FORM.DH_APP_LOCALE_TYPE.app_locale"] == null ? [] : List<FormDhAppLocaleTypeAppLocale>.from(json["SIDEBAR_APP_FIRST_TIME_LOAD _FORM.DH_APP_LOCALE_TYPE.app_locale"]!.map((x) => FormDhAppLocaleTypeAppLocale.fromMap(x))),
        sidebarAppFirstTimeLoadFormDhAppLocaleTypeAppLocaleLastUpdateDatetime: json["SIDEBAR_APP_FIRST_TIME_LOAD _FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["SIDEBAR_APP_FIRST_TIME_LOAD _FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME"]),
        sidebarAppFirstTimeLoadFormDhLanguageTypeLanguage: json["SIDEBAR_APP_FIRST_TIME_LOAD_FORM.DH_LANGUAGE_TYPE.language"] == null ? [] : List<FormDhLanguageTypeLanguage>.from(json["SIDEBAR_APP_FIRST_TIME_LOAD_FORM.DH_LANGUAGE_TYPE.language"]!.map((x) => FormDhLanguageTypeLanguage.fromMap(x))),
        sidebarAppFirstTimeLoadFormDhLanguageTypeLanguageLastUpdateDatetime: json["SIDEBAR_APP_FIRST_TIME_LOAD_FORM.DH_LANGUAGE_TYPE.language.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["SIDEBAR_APP_FIRST_TIME_LOAD_FORM.DH_LANGUAGE_TYPE.language.LAST_UPDATE_DATETIME"]),
        verifyWorkPermitDelayHour: json["VERIFY_WORK_PERMIT_DELAY_HOUR"],
        verifyWorkPermitDelayHourLastUpdateDatetime: json["VERIFY_WORK_PERMIT_DELAY_HOUR.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["VERIFY_WORK_PERMIT_DELAY_HOUR.LAST_UPDATE_DATETIME"]),
        workPermitFormDhAppLocaleTypeAppLocale: json["WORK_PERMIT_FORM.DH_APP_LOCALE_TYPE.app_locale"] == null ? [] : List<FormDhAppLocaleTypeAppLocale>.from(json["WORK_PERMIT_FORM.DH_APP_LOCALE_TYPE.app_locale"]!.map((x) => FormDhAppLocaleTypeAppLocale.fromMap(x))),
        workPermitFormDhAppLocaleTypeAppLocaleLastUpdateDatetime: json["WORK_PERMIT_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME"] == null ? null : DateTime.parse(json["WORK_PERMIT_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME"]),
        storagePrefix: json["STORAGE_PREFIX"],
    );

    Map<String, dynamic> toMap() => {
        "ARTICLE_CREATE_FORM.DH_LANGUAGE_TYPE.language": articleCreateFormDhLanguageTypeLanguage == null ? [] : List<dynamic>.from(articleCreateFormDhLanguageTypeLanguage!.map((x) => x.toMap())),
        "ARTICLE_CREATE_FORM.DH_LANGUAGE_TYPE.language.LAST_UPDATE_DATETIME": articleCreateFormDhLanguageTypeLanguageLastUpdateDatetime?.toIso8601String(),
        "ARTICLE_LIST_FORM.DH_LANGUAGE_TYPE.language": articleListFormDhLanguageTypeLanguage == null ? [] : List<dynamic>.from(articleListFormDhLanguageTypeLanguage!.map((x) => x.toMap())),
        "ARTICLE_LIST_FORM.DH_LANGUAGE_TYPE.language.LAST_UPDATE_DATETIME": articleListFormDhLanguageTypeLanguageLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_ADVANCED_SEARCH_FORM.DH_AGENT_FEE.agent_fee": candidateAdvancedSearchFormDhAgentFeeAgentFee == null ? [] : List<dynamic>.from(candidateAdvancedSearchFormDhAgentFeeAgentFee!.map((x) => x)),
        "CANDIDATE_ADVANCED_SEARCH_FORM.DH_AGENT_FEE.agent_fee.LAST_UPDATE_DATETIME": candidateAdvancedSearchFormDhAgentFeeAgentFeeLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_ADVANCED_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code": candidateAdvancedSearchFormDhAppLocaleTypeCurrencyCode == null ? [] : List<dynamic>.from(candidateAdvancedSearchFormDhAppLocaleTypeCurrencyCode!.map((x) => x.toMap())),
        "CANDIDATE_ADVANCED_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME": candidateAdvancedSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_ADVANCED_SEARCH_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name": candidateAdvancedSearchFormDhCountryOfEmployerWorkCountryName == null ? [] : List<dynamic>.from(candidateAdvancedSearchFormDhCountryOfEmployerWorkCountryName!.map((x) => x.toMap())),
        "CANDIDATE_ADVANCED_SEARCH_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name.LAST_UPDATE_DATETIME": candidateAdvancedSearchFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_ADVANCED_SEARCH_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice": candidateAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoice == null ? [] : List<dynamic>.from(candidateAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoice!.map((x) => x.toMap())),
        "CANDIDATE_ADVANCED_SEARCH_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice.LAST_UPDATE_DATETIME": candidateAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_ADVANCED_SEARCH_FORM.DH_TASK_TYPE.task_type": candidateAdvancedSearchFormDhTaskTypeTaskType == null ? [] : List<dynamic>.from(candidateAdvancedSearchFormDhTaskTypeTaskType!.map((x) => x)),
        "CANDIDATE_ADVANCED_SEARCH_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME": candidateAdvancedSearchFormDhTaskTypeTaskTypeLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_ADVANCED_SEARCH_FORM.SW-RELIGION_TYPE.religion": candidateAdvancedSearchFormSwReligionTypeReligion == null ? [] : List<dynamic>.from(candidateAdvancedSearchFormSwReligionTypeReligion!.map((x) => x)),
        "CANDIDATE_ADVANCED_SEARCH_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME": candidateAdvancedSearchFormSwReligionTypeReligionLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_AGENT_FEE.agent_fee": candidateAvailabilityStatusChangeFormDhAgentFeeAgentFee == null ? [] : List<dynamic>.from(candidateAvailabilityStatusChangeFormDhAgentFeeAgentFee!.map((x) => x)),
        "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_AGENT_FEE.agent_fee.LAST_UPDATE_DATETIME": candidateAvailabilityStatusChangeFormDhAgentFeeAgentFeeLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_APP_LOCALE_TYPE.currency_code": candidateAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCode == null ? [] : List<dynamic>.from(candidateAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCode!.map((x) => x.toMap())),
        "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME": candidateAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_CANDIDATE_AVAILABILITY_STATUS_TYPE.availability_status": candidateAvailabilityStatusChangeFormDhCandidateAvailabilityStatusTypeAvailabilityStatus == null ? [] : List<dynamic>.from(candidateAvailabilityStatusChangeFormDhCandidateAvailabilityStatusTypeAvailabilityStatus!.map((x) => x.toMap())),
        "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_CANDIDATE_AVAILABILITY_STATUS_TYPE.availability_status.LAST_UPDATE_DATETIME": candidateAvailabilityStatusChangeFormDhCandidateAvailabilityStatusTypeAvailabilityStatusLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name": candidateAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryName == null ? [] : List<dynamic>.from(candidateAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryName!.map((x) => x.toMap())),
        "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name.LAST_UPDATE_DATETIME": candidateAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice": candidateAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoice == null ? [] : List<dynamic>.from(candidateAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoice!.map((x) => x.toMap())),
        "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice.LAST_UPDATE_DATETIME": candidateAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_TASK_TYPE.task_type": candidateAvailabilityStatusChangeFormDhTaskTypeTaskType == null ? [] : List<dynamic>.from(candidateAvailabilityStatusChangeFormDhTaskTypeTaskType!.map((x) => x)),
        "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME": candidateAvailabilityStatusChangeFormDhTaskTypeTaskTypeLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.SW-RELIGION_TYPE.religion": candidateAvailabilityStatusChangeFormSwReligionTypeReligion == null ? [] : List<dynamic>.from(candidateAvailabilityStatusChangeFormSwReligionTypeReligion!.map((x) => x)),
        "CANDIDATE_AVAILABILITY_STATUS_CHANGE_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME": candidateAvailabilityStatusChangeFormSwReligionTypeReligionLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-COUNTRY_CALLING_CODE.country_name": candidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName == null ? [] : List<dynamic>.from(candidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName!.map((x) => x.toMap())),
        "CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME": candidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryNameLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-COUNTRY_CALLING_CODE.iban_alpha_2_code": candidateEmployerProfileCreationStep1FormSwCountryCallingCodeIbanAlpha2Code == null ? [] : List<dynamic>.from(candidateEmployerProfileCreationStep1FormSwCountryCallingCodeIbanAlpha2Code!.map((x) => x.toMap())),
        "CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-COUNTRY_CALLING_CODE.iban_alpha_2_code.LAST_UPDATE_DATETIME": candidateEmployerProfileCreationStep1FormSwCountryCallingCodeIbanAlpha2CodeLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-GENDER_TYPE.gender": candidateEmployerProfileCreationStep1FormSwGenderTypeGender == null ? [] : List<dynamic>.from(candidateEmployerProfileCreationStep1FormSwGenderTypeGender!.map((x) => x)),
        "CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-GENDER_TYPE.gender.LAST_UPDATE_DATETIME": candidateEmployerProfileCreationStep1FormSwGenderTypeGenderLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-RELIGION_TYPE.religion": candidateEmployerProfileCreationStep1FormSwReligionTypeReligion == null ? [] : List<dynamic>.from(candidateEmployerProfileCreationStep1FormSwReligionTypeReligion!.map((x) => x)),
        "CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME": candidateEmployerProfileCreationStep1FormSwReligionTypeReligionLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM2.SW-COUNTRY_CALLING_CODE.country_name": candidateEmployerProfileCreationStep1Form2SwCountryCallingCodeCountryName == null ? [] : List<dynamic>.from(candidateEmployerProfileCreationStep1Form2SwCountryCallingCodeCountryName!.map((x) => x.toMap())),
        "CANDIDATE_EMPLOYER_PROFILE_CREATION_STEP1_FORM2.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME": candidateEmployerProfileCreationStep1Form2SwCountryCallingCodeCountryNameLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_EMPLOYMENT_HISTORY_FORM.SW-COUNTRY_CALLING_CODE.country_name": candidateEmploymentHistoryFormSwCountryCallingCodeCountryName == null ? [] : List<dynamic>.from(candidateEmploymentHistoryFormSwCountryCallingCodeCountryName!.map((x) => x.toMap())),
        "CANDIDATE_EMPLOYMENT_HISTORY_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME": candidateEmploymentHistoryFormSwCountryCallingCodeCountryNameLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_MY_ACCOUNT_FORM.DH_APP_LOCALE_TYPE.app_locale": candidateMyAccountFormDhAppLocaleTypeAppLocale == null ? [] : List<dynamic>.from(candidateMyAccountFormDhAppLocaleTypeAppLocale!.map((x) => x.toMap())),
        "CANDIDATE_MY_ACCOUNT_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME": candidateMyAccountFormDhAppLocaleTypeAppLocaleLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_OFFER_ACCEPT_OR_REJECT_FORM.DH_APP_LOCALE_TYPE.currency_code": candidateOfferAcceptOrRejectFormDhAppLocaleTypeCurrencyCode == null ? [] : List<dynamic>.from(candidateOfferAcceptOrRejectFormDhAppLocaleTypeCurrencyCode!.map((x) => x.toMap())),
        "CANDIDATE_OFFER_ACCEPT_OR_REJECT_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME": candidateOfferAcceptOrRejectFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_PROFILE_CREATION_STEP2_FORM.DH_CANDIDATE_FAMILY_MEMBER_TYPE.member_type": candidateProfileCreationStep2FormDhCandidateFamilyMemberTypeMemberType == null ? [] : List<dynamic>.from(candidateProfileCreationStep2FormDhCandidateFamilyMemberTypeMemberType!.map((x) => x)),
        "CANDIDATE_PROFILE_CREATION_STEP2_FORM.DH_CANDIDATE_FAMILY_MEMBER_TYPE.member_type.LAST_UPDATE_DATETIME": candidateProfileCreationStep2FormDhCandidateFamilyMemberTypeMemberTypeLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_PROFILE_CREATION_STEP2_FORM.DH_CANDIDATE_FAMILY_STATUS_TYPE.family_status": candidateProfileCreationStep2FormDhCandidateFamilyStatusTypeFamilyStatus == null ? [] : List<dynamic>.from(candidateProfileCreationStep2FormDhCandidateFamilyStatusTypeFamilyStatus!.map((x) => x)),
        "CANDIDATE_PROFILE_CREATION_STEP2_FORM.DH_CANDIDATE_FAMILY_STATUS_TYPE.family_status.LAST_UPDATE_DATETIME": candidateProfileCreationStep2FormDhCandidateFamilyStatusTypeFamilyStatusLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_PROFILE_CREATION_STEP3_FORM.DH_CANDIDATE_ACADEMIC_QUALIFICATION_TYPE.qualification": candidateProfileCreationStep3FormDhCandidateAcademicQualificationTypeQualification == null ? [] : List<dynamic>.from(candidateProfileCreationStep3FormDhCandidateAcademicQualificationTypeQualification!.map((x) => x)),
        "CANDIDATE_PROFILE_CREATION_STEP3_FORM.DH_CANDIDATE_ACADEMIC_QUALIFICATION_TYPE.qualification.LAST_UPDATE_DATETIME": candidateProfileCreationStep3FormDhCandidateAcademicQualificationTypeQualificationLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_PROFILE_CREATION_STEP3_FORM.DH_TASK_TYPE.task_type": candidateProfileCreationStep3FormDhTaskTypeTaskType == null ? [] : List<dynamic>.from(candidateProfileCreationStep3FormDhTaskTypeTaskType!.map((x) => x)),
        "CANDIDATE_PROFILE_CREATION_STEP3_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME": candidateProfileCreationStep3FormDhTaskTypeTaskTypeLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_PROFILE_CREATION_STEP5_FORM.DH_TASK_TYPE.task_type": candidateProfileCreationStep5FormDhTaskTypeTaskType == null ? [] : List<dynamic>.from(candidateProfileCreationStep5FormDhTaskTypeTaskType!.map((x) => x)),
        "CANDIDATE_PROFILE_CREATION_STEP5_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME": candidateProfileCreationStep5FormDhTaskTypeTaskTypeLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_SIMPLE_SEARCH_FORM.DH_AGENT_FEE.agent_fee": candidateSimpleSearchFormDhAgentFeeAgentFee == null ? [] : List<dynamic>.from(candidateSimpleSearchFormDhAgentFeeAgentFee!.map((x) => x)),
        "CANDIDATE_SIMPLE_SEARCH_FORM.DH_AGENT_FEE.agent_fee.LAST_UPDATE_DATETIME": candidateSimpleSearchFormDhAgentFeeAgentFeeLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_SIMPLE_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code": candidateSimpleSearchFormDhAppLocaleTypeCurrencyCode == null ? [] : List<dynamic>.from(candidateSimpleSearchFormDhAppLocaleTypeCurrencyCode!.map((x) => x.toMap())),
        "CANDIDATE_SIMPLE_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME": candidateSimpleSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime?.toIso8601String(),
        "CANDIDATE_SIMPLE_SEARCH_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name": candidateSimpleSearchFormDhCountryOfEmployerWorkCountryName == null ? [] : List<dynamic>.from(candidateSimpleSearchFormDhCountryOfEmployerWorkCountryName!.map((x) => x.toMap())),
        "CANDIDATE_SIMPLE_SEARCH_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name.LAST_UPDATE_DATETIME": candidateSimpleSearchFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime?.toIso8601String(),
        "COLOR_TAG_FAMILY": colorTagFamily,
        "COLOR_TAG_FAMILY.LAST_UPDATE_DATETIME": colorTagFamilyLastUpdateDatetime?.toIso8601String(),
        "COLOR_TAG_LANGUAGE": colorTagLanguage,
        "COLOR_TAG_LANGUAGE.LAST_UPDATE_DATETIME": colorTagLanguageLastUpdateDatetime?.toIso8601String(),
        "COLOR_TAG_SKILL": colorTagSkill,
        "COLOR_TAG_SKILL.LAST_UPDATE_DATETIME": colorTagSkillLastUpdateDatetime?.toIso8601String(),
        "COLOR_TAG_TRANSFER_MAID": colorTagTransferMaid,
        "COLOR_TAG_TRANSFER_MAID.LAST_UPDATE_DATETIME": colorTagTransferMaidLastUpdateDatetime?.toIso8601String(),
        "CUSTOMER_SUPPORT_FORM.DH_CONTACT_ISSUE_TYPE.contact_issue": customerSupportFormDhContactIssueTypeContactIssue == null ? [] : List<dynamic>.from(customerSupportFormDhContactIssueTypeContactIssue!.map((x) => x)),
        "CUSTOMER_SUPPORT_FORM.DH_CONTACT_ISSUE_TYPE.contact_issue.LAST_UPDATE_DATETIME": customerSupportFormDhContactIssueTypeContactIssueLastUpdateDatetime?.toIso8601String(),
        "CUSTOMER_SUPPORT_FORM.SW-COUNTRY_CALLING_CODE.country_name": customerSupportFormSwCountryCallingCodeCountryName == null ? [] : List<dynamic>.from(customerSupportFormSwCountryCallingCodeCountryName!.map((x) => x.toMap())),
        "CUSTOMER_SUPPORT_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME": customerSupportFormSwCountryCallingCodeCountryNameLastUpdateDatetime?.toIso8601String(),
        "DH_APP_LOCALE_TYPE.PHC_100000_FOREX_value": dhAppLocaleTypePhc100000ForexValue == null ? [] : List<dynamic>.from(dhAppLocaleTypePhc100000ForexValue!.map((x) => x.toMap())),
        "DH_APP_LOCALE_TYPE.PHC_100000_FOREX_value.LAST_UPDATE_DATETIME": dhAppLocaleTypePhc100000ForexValueLastUpdateDatetime?.toIso8601String(),
        "DH_ARTICLE_COMMENT_COMPLAINT_MAX_COUNT": dhArticleCommentComplaintMaxCount,
        "DH_ARTICLE_COMMENT_COMPLAINT_MAX_COUNT.LAST_UPDATE_DATETIME": dhArticleCommentComplaintMaxCountLastUpdateDatetime?.toIso8601String(),
        "DH_ARTICLE_COMPLAINT_MAX_COUNT": dhArticleComplaintMaxCount,
        "DH_ARTICLE_COMPLAINT_MAX_COUNT.LAST_UPDATE_DATETIME": dhArticleComplaintMaxCountLastUpdateDatetime?.toIso8601String(),
        "DH_CANDIDATE_CREATE_ACCOUNT_COIN_REWARD_FOR_REFERER": dhCandidateCreateAccountCoinRewardForReferer?.toMap(),
        "DH_CANDIDATE_CREATE_ACCOUNT_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME": dhCandidateCreateAccountCoinRewardForRefererLastUpdateDatetime?.toIso8601String(),
        "DH_CANDIDATE_PROFILE_PROGRESS_PER_STEP": dhCandidateProfileProgressPerStep,
        "DH_CANDIDATE_PROFILE_PROGRESS_PER_STEP.LAST_UPDATE_DATETIME": dhCandidateProfileProgressPerStepLastUpdateDatetime?.toIso8601String(),
        "DH_CANDIDATE_VERIFY_PHONE_COIN_REWARD_FOR_REFERER": dhCandidateVerifyPhoneCoinRewardForReferer?.toMap(),
        "DH_CANDIDATE_VERIFY_PHONE_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME": dhCandidateVerifyPhoneCoinRewardForRefererLastUpdateDatetime?.toIso8601String(),
        "DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFEREE": dhCandidateVerifyWorkpermitCoinRewardForReferee?.toMap(),
        "DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFEREE.LAST_UPDATE_DATETIME": dhCandidateVerifyWorkpermitCoinRewardForRefereeLastUpdateDatetime?.toIso8601String(),
        "DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFERER": dhCandidateVerifyWorkpermitCoinRewardForReferer?.toMap(),
        "DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME": dhCandidateVerifyWorkpermitCoinRewardForRefererLastUpdateDatetime?.toIso8601String(),
        "DH_EMPLOYER_CREATE_ACCOUNT_COIN_REWARD_FOR_REFERER": dhEmployerCreateAccountCoinRewardForReferer?.toMap(),
        "DH_EMPLOYER_CREATE_ACCOUNT_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME": dhEmployerCreateAccountCoinRewardForRefererLastUpdateDatetime?.toIso8601String(),
        "DH_EMPLOYER_PROFILE_PROGRESS_PER_STEP": dhEmployerProfileProgressPerStep,
        "DH_EMPLOYER_PROFILE_PROGRESS_PER_STEP.LAST_UPDATE_DATETIME": dhEmployerProfileProgressPerStepLastUpdateDatetime?.toIso8601String(),
        "DH_EMPLOYER_VERIFY_PHONE_COIN_REWARD_FOR_REFERER": dhEmployerVerifyPhoneCoinRewardForReferer?.toMap(),
        "DH_EMPLOYER_VERIFY_PHONE_COIN_REWARD_FOR_REFERER.LAST_UPDATE_DATETIME": dhEmployerVerifyPhoneCoinRewardForRefererLastUpdateDatetime?.toIso8601String(),
        "DH_PROFILE_COMPLAINT_MAX_COUNT": dhProfileComplaintMaxCount,
        "DH_PROFILE_COMPLAINT_MAX_COUNT.LAST_UPDATE_DATETIME": dhProfileComplaintMaxCountLastUpdateDatetime?.toIso8601String(),
        "DH_PROFILE_COMPLETION_COIN_REWARD": dhProfileCompletionCoinReward,
        "DH_PROFILE_COMPLETION_COIN_REWARD.LAST_UPDATE_DATETIME": dhProfileCompletionCoinRewardLastUpdateDatetime?.toIso8601String(),
        "DH_PROFILE_COMPLETION_VOUCHER_REWARD": dhProfileCompletionVoucherReward,
        "DH_PROFILE_COMPLETION_VOUCHER_REWARD.LAST_UPDATE_DATETIME": dhProfileCompletionVoucherRewardLastUpdateDatetime?.toIso8601String(),
        "DIAL_PREPEND_SPECIAL_MY": dialPrependSpecialMy,
        "DIAL_PREPEND_SPECIAL_MY.LAST_UPDATE_DATETIME": dialPrependSpecialMyLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_ADVANCED_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code": employerAdvancedSearchFormDhAppLocaleTypeCurrencyCode == null ? [] : List<dynamic>.from(employerAdvancedSearchFormDhAppLocaleTypeCurrencyCode!.map((x) => x.toMap())),
        "EMPLOYER_ADVANCED_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME": employerAdvancedSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_ADVANCED_SEARCH_FORM.DH_COUNTRY_OF_CANDIDATE_SOURCE.country_name": employerAdvancedSearchFormDhCountryOfCandidateSourceCountryName == null ? [] : List<dynamic>.from(employerAdvancedSearchFormDhCountryOfCandidateSourceCountryName!.map((x) => x.toMap())),
        "EMPLOYER_ADVANCED_SEARCH_FORM.DH_COUNTRY_OF_CANDIDATE_SOURCE.country_name.LAST_UPDATE_DATETIME": employerAdvancedSearchFormDhCountryOfCandidateSourceCountryNameLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_ADVANCED_SEARCH_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice": employerAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoice == null ? [] : List<dynamic>.from(employerAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoice!.map((x) => x.toMap())),
        "EMPLOYER_ADVANCED_SEARCH_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice.LAST_UPDATE_DATETIME": employerAdvancedSearchFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_ADVANCED_SEARCH_FORM.DH_TASK_TYPE.task_type": employerAdvancedSearchFormDhTaskTypeTaskType == null ? [] : List<dynamic>.from(employerAdvancedSearchFormDhTaskTypeTaskType!.map((x) => x)),
        "EMPLOYER_ADVANCED_SEARCH_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME": employerAdvancedSearchFormDhTaskTypeTaskTypeLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_ADVANCED_SEARCH_FORM.SW-RELIGION_TYPE.religion": employerAdvancedSearchFormSwReligionTypeReligion == null ? [] : List<dynamic>.from(employerAdvancedSearchFormSwReligionTypeReligion!.map((x) => x)),
        "EMPLOYER_ADVANCED_SEARCH_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME": employerAdvancedSearchFormSwReligionTypeReligionLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_APP_LOCALE_TYPE.currency_code": employerAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCode == null ? [] : List<dynamic>.from(employerAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCode!.map((x) => x.toMap())),
        "EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME": employerAvailabilityStatusChangeFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name": employerAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryName == null ? [] : List<dynamic>.from(employerAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryName!.map((x) => x.toMap())),
        "EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_COUNTRY_OF_EMPLOYER_WORK.country_name.LAST_UPDATE_DATETIME": employerAvailabilityStatusChangeFormDhCountryOfEmployerWorkCountryNameLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_EMPLOYER_AVAILABILITY_STATUS_TYPE.availability_status": employerAvailabilityStatusChangeFormDhEmployerAvailabilityStatusTypeAvailabilityStatus == null ? [] : List<dynamic>.from(employerAvailabilityStatusChangeFormDhEmployerAvailabilityStatusTypeAvailabilityStatus!.map((x) => x.toMap())),
        "EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_EMPLOYER_AVAILABILITY_STATUS_TYPE.availability_status.LAST_UPDATE_DATETIME": employerAvailabilityStatusChangeFormDhEmployerAvailabilityStatusTypeAvailabilityStatusLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice": employerAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoice == null ? [] : List<dynamic>.from(employerAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoice!.map((x) => x.toMap())),
        "EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_REST_DAY_TYPE.rest_day_per_month_choice.LAST_UPDATE_DATETIME": employerAvailabilityStatusChangeFormDhRestDayTypeRestDayPerMonthChoiceLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_TASK_TYPE.task_type": employerAvailabilityStatusChangeFormDhTaskTypeTaskType == null ? [] : List<dynamic>.from(employerAvailabilityStatusChangeFormDhTaskTypeTaskType!.map((x) => x)),
        "EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.DH_TASK_TYPE.task_type.LAST_UPDATE_DATETIME": employerAvailabilityStatusChangeFormDhTaskTypeTaskTypeLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.SW-RELIGION_TYPE.religion": employerAvailabilityStatusChangeFormSwReligionTypeReligion == null ? [] : List<dynamic>.from(employerAvailabilityStatusChangeFormSwReligionTypeReligion!.map((x) => x)),
        "EMPLOYER_AVAILABILITY_STATUS_CHANGE_FORM.SW-RELIGION_TYPE.religion.LAST_UPDATE_DATETIME": employerAvailabilityStatusChangeFormSwReligionTypeReligionLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_MY_ACCOUNT_FORM.DH_APP_LOCALE_TYPE.app_locale": employerMyAccountFormDhAppLocaleTypeAppLocale == null ? [] : List<dynamic>.from(employerMyAccountFormDhAppLocaleTypeAppLocale!.map((x) => x.toMap())),
        "EMPLOYER_MY_ACCOUNT_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME": employerMyAccountFormDhAppLocaleTypeAppLocaleLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_OFFER_FORM.DH_APP_LOCALE_TYPE.currency_code": employerOfferFormDhAppLocaleTypeCurrencyCode == null ? [] : List<dynamic>.from(employerOfferFormDhAppLocaleTypeCurrencyCode!.map((x) => x.toMap())),
        "EMPLOYER_OFFER_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME": employerOfferFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_PROFILE_CREATION_STEP2_FORM.DH_EMPLOYER_FAMILY_MEMBER_TYPE.member_type": employerProfileCreationStep2FormDhEmployerFamilyMemberTypeMemberType == null ? [] : List<dynamic>.from(employerProfileCreationStep2FormDhEmployerFamilyMemberTypeMemberType!.map((x) => x)),
        "EMPLOYER_PROFILE_CREATION_STEP2_FORM.DH_EMPLOYER_FAMILY_MEMBER_TYPE.member_type.LAST_UPDATE_DATETIME": employerProfileCreationStep2FormDhEmployerFamilyMemberTypeMemberTypeLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_PROFILE_CREATION_STEP2_FORM.DH_EMPLOYER_FAMILY_STATUS_TYPE.family_status": employerProfileCreationStep2FormDhEmployerFamilyStatusTypeFamilyStatus == null ? [] : List<dynamic>.from(employerProfileCreationStep2FormDhEmployerFamilyStatusTypeFamilyStatus!.map((x) => x)),
        "EMPLOYER_PROFILE_CREATION_STEP2_FORM.DH_EMPLOYER_FAMILY_STATUS_TYPE.family_status.LAST_UPDATE_DATETIME": employerProfileCreationStep2FormDhEmployerFamilyStatusTypeFamilyStatusLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_SIMPLE_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code": employerSimpleSearchFormDhAppLocaleTypeCurrencyCode == null ? [] : List<dynamic>.from(employerSimpleSearchFormDhAppLocaleTypeCurrencyCode!.map((x) => x.toMap())),
        "EMPLOYER_SIMPLE_SEARCH_FORM.DH_APP_LOCALE_TYPE.currency_code.LAST_UPDATE_DATETIME": employerSimpleSearchFormDhAppLocaleTypeCurrencyCodeLastUpdateDatetime?.toIso8601String(),
        "EMPLOYER_SIMPLE_SEARCH_FORM.DH_COUNTRY_OF_CANDIDATE_SOURCE.country_name": employerSimpleSearchFormDhCountryOfCandidateSourceCountryName == null ? [] : List<dynamic>.from(employerSimpleSearchFormDhCountryOfCandidateSourceCountryName!.map((x) => x.toMap())),
        "EMPLOYER_SIMPLE_SEARCH_FORM.DH_COUNTRY_OF_CANDIDATE_SOURCE.country_name.LAST_UPDATE_DATETIME": employerSimpleSearchFormDhCountryOfCandidateSourceCountryNameLastUpdateDatetime?.toIso8601String(),
        "FORGOT_PASSWORD_FORM.SW-COUNTRY_CALLING_CODE.country_name": forgotPasswordFormSwCountryCallingCodeCountryName == null ? [] : List<dynamic>.from(forgotPasswordFormSwCountryCallingCodeCountryName!.map((x) => x.toMap())),
        "FORGOT_PASSWORD_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME": forgotPasswordFormSwCountryCallingCodeCountryNameLastUpdateDatetime?.toIso8601String(),
        "LOGIN_PHONE_NUMBER_FORM.SW-COUNTRY_CALLING_CODE.country_name": loginPhoneNumberFormSwCountryCallingCodeCountryName == null ? [] : List<dynamic>.from(loginPhoneNumberFormSwCountryCallingCodeCountryName!.map((x) => x.toMap())),
        "LOGIN_PHONE_NUMBER_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME": loginPhoneNumberFormSwCountryCallingCodeCountryNameLastUpdateDatetime?.toIso8601String(),
        "MAX_CALL_COUNT": maxCallCount,
        "MAX_CALL_COUNT.LAST_UPDATE_DATETIME": maxCallCountLastUpdateDatetime?.toIso8601String(),
        "MAX_CALL_TIME_LENGTH": maxCallTimeLength,
        "MAX_CALL_TIME_LENGTH.LAST_UPDATE_DATETIME": maxCallTimeLengthLastUpdateDatetime?.toIso8601String(),
        "MAX_CONCURRENT_INTERVIEW": maxConcurrentInterview,
        "MAX_CONCURRENT_INTERVIEW.LAST_UPDATE_DATETIME": maxConcurrentInterviewLastUpdateDatetime?.toIso8601String(),
        "MAX_CONNECTION_PER_DAY": maxConnectionPerDay,
        "MAX_CONNECTION_PER_DAY.LAST_UPDATE_DATETIME": maxConnectionPerDayLastUpdateDatetime?.toIso8601String(),
        "MAX_DAILY_VIEW_COUNT": maxDailyViewCount,
        "MAX_DAILY_VIEW_COUNT.LAST_UPDATE_DATETIME": maxDailyViewCountLastUpdateDatetime?.toIso8601String(),
        "MAX_EMPLOYER_OFFER_VALID_DAY": maxEmployerOfferValidDay,
        "MAX_EMPLOYER_OFFER_VALID_DAY.LAST_UPDATE_DATETIME": maxEmployerOfferValidDayLastUpdateDatetime?.toIso8601String(),
        "MAX_MONTHLY_SALARY_IN_SGD": maxMonthlySalaryInSgd,
        "MAX_MONTHLY_SALARY_IN_SGD.LAST_UPDATE_DATETIME": maxMonthlySalaryInSgdLastUpdateDatetime?.toIso8601String(),
        "MAX_STARLIST_COUNT": maxStarlistCount,
        "MAX_STARLIST_COUNT.LAST_UPDATE_DATETIME": maxStarlistCountLastUpdateDatetime?.toIso8601String(),
        "MIN_CALL_TIME_LENGTH": minCallTimeLength,
        "MIN_CALL_TIME_LENGTH.LAST_UPDATE_DATETIME": minCallTimeLengthLastUpdateDatetime?.toIso8601String(),
        "MIN_MONTHLY_SALARY_IN_SGD": minMonthlySalaryInSgd,
        "MIN_MONTHLY_SALARY_IN_SGD.LAST_UPDATE_DATETIME": minMonthlySalaryInSgdLastUpdateDatetime?.toIso8601String(),
        "MY_ACCOUNT_FORM.DH_LANGUAGE_TYPE.language": myAccountFormDhLanguageTypeLanguage == null ? [] : List<dynamic>.from(myAccountFormDhLanguageTypeLanguage!.map((x) => x.toMap())),
        "MY_ACCOUNT_FORM.DH_LANGUAGE_TYPE.language.LAST_UPDATE_DATETIME": myAccountFormDhLanguageTypeLanguageLastUpdateDatetime?.toIso8601String(),
        "PROSPECT_REPEAT_VIEW_DAY": prospectRepeatViewDay,
        "PROSPECT_REPEAT_VIEW_DAY.LAST_UPDATE_DATETIME": prospectRepeatViewDayLastUpdateDatetime?.toIso8601String(),
        "REGISTER_PHONE_NUMBER_FORM.SW-COUNTRY_CALLING_CODE.country_name": registerPhoneNumberFormSwCountryCallingCodeCountryName == null ? [] : List<dynamic>.from(registerPhoneNumberFormSwCountryCallingCodeCountryName!.map((x) => x.toMap())),
        "REGISTER_PHONE_NUMBER_FORM.SW-COUNTRY_CALLING_CODE.country_name.LAST_UPDATE_DATETIME": registerPhoneNumberFormSwCountryCallingCodeCountryNameLastUpdateDatetime?.toIso8601String(),
        "REWARD_LIST_FORM.DH_APP_LOCALE_TYPE.app_locale": rewardListFormDhAppLocaleTypeAppLocale == null ? [] : List<dynamic>.from(rewardListFormDhAppLocaleTypeAppLocale!.map((x) => x.toMap())),
        "REWARD_LIST_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME": rewardListFormDhAppLocaleTypeAppLocaleLastUpdateDatetime?.toIso8601String(),
        "SEARCH_FORM.DH_APP_LOCALE_TYPE.app_locale": searchFormDhAppLocaleTypeAppLocale == null ? [] : List<dynamic>.from(searchFormDhAppLocaleTypeAppLocale!.map((x) => x.toMap())),
        "SEARCH_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME": searchFormDhAppLocaleTypeAppLocaleLastUpdateDatetime?.toIso8601String(),
        "SIDEBAR_APP_FIRST_TIME_LOAD _FORM.DH_APP_LOCALE_TYPE.app_locale": sidebarAppFirstTimeLoadFormDhAppLocaleTypeAppLocale == null ? [] : List<dynamic>.from(sidebarAppFirstTimeLoadFormDhAppLocaleTypeAppLocale!.map((x) => x.toMap())),
        "SIDEBAR_APP_FIRST_TIME_LOAD _FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME": sidebarAppFirstTimeLoadFormDhAppLocaleTypeAppLocaleLastUpdateDatetime?.toIso8601String(),
        "SIDEBAR_APP_FIRST_TIME_LOAD_FORM.DH_LANGUAGE_TYPE.language": sidebarAppFirstTimeLoadFormDhLanguageTypeLanguage == null ? [] : List<dynamic>.from(sidebarAppFirstTimeLoadFormDhLanguageTypeLanguage!.map((x) => x.toMap())),
        "SIDEBAR_APP_FIRST_TIME_LOAD_FORM.DH_LANGUAGE_TYPE.language.LAST_UPDATE_DATETIME": sidebarAppFirstTimeLoadFormDhLanguageTypeLanguageLastUpdateDatetime?.toIso8601String(),
        "VERIFY_WORK_PERMIT_DELAY_HOUR": verifyWorkPermitDelayHour,
        "VERIFY_WORK_PERMIT_DELAY_HOUR.LAST_UPDATE_DATETIME": verifyWorkPermitDelayHourLastUpdateDatetime?.toIso8601String(),
        "WORK_PERMIT_FORM.DH_APP_LOCALE_TYPE.app_locale": workPermitFormDhAppLocaleTypeAppLocale == null ? [] : List<dynamic>.from(workPermitFormDhAppLocaleTypeAppLocale!.map((x) => x.toMap())),
        "WORK_PERMIT_FORM.DH_APP_LOCALE_TYPE.app_locale.LAST_UPDATE_DATETIME": workPermitFormDhAppLocaleTypeAppLocaleLastUpdateDatetime?.toIso8601String(),
        "STORAGE_PREFIX": storagePrefix,
    };
}

class FormDhLanguageTypeLanguage {
    final String? languageName;
    final String? language;

    FormDhLanguageTypeLanguage({
        this.languageName,
        this.language,
    });

    factory FormDhLanguageTypeLanguage.fromJson(String str) => FormDhLanguageTypeLanguage.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FormDhLanguageTypeLanguage.fromMap(Map<String, dynamic> json) => FormDhLanguageTypeLanguage(
        languageName: json["language_name"],
        language: json["language"],
    );

    Map<String, dynamic> toMap() => {
        "language_name": languageName,
        "language": language,
    };
}

class FormDhAppLocaleTypeCurrencyCode {
    final String? currencyCode;
    final String? ibanAlpha2Code;
    final String? appLocale;

    FormDhAppLocaleTypeCurrencyCode({
        this.currencyCode,
        this.ibanAlpha2Code,
        this.appLocale,
    });

    factory FormDhAppLocaleTypeCurrencyCode.fromJson(String str) => FormDhAppLocaleTypeCurrencyCode.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FormDhAppLocaleTypeCurrencyCode.fromMap(Map<String, dynamic> json) => FormDhAppLocaleTypeCurrencyCode(
        currencyCode: json["currency_code"],
        ibanAlpha2Code: json["iban_alpha_2_code"],
        appLocale: json["app_locale"],
    );

    Map<String, dynamic> toMap() => {
        "currency_code": currencyCode,
        "iban_alpha_2_code": ibanAlpha2Code,
        "app_locale": appLocale,
    };
}

class CountryName {
    final String? countryName;
    final String? ibanAlpha2Code;

    CountryName({
        this.countryName,
        this.ibanAlpha2Code,
    });

    factory CountryName.fromJson(String str) => CountryName.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CountryName.fromMap(Map<String, dynamic> json) => CountryName(
        countryName: json["country_name"],
        ibanAlpha2Code: json["iban_alpha_2_code"],
    );

    Map<String, dynamic> toMap() => {
        "country_name": countryName,
        "iban_alpha_2_code": ibanAlpha2Code,
    };
}

class FormDhRestDayTypeRestDayPerMonthChoice {
    final int? restDayPerMonthChoice;
    final String? desc;

    FormDhRestDayTypeRestDayPerMonthChoice({
        this.restDayPerMonthChoice,
        this.desc,
    });

    factory FormDhRestDayTypeRestDayPerMonthChoice.fromJson(String str) => FormDhRestDayTypeRestDayPerMonthChoice.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FormDhRestDayTypeRestDayPerMonthChoice.fromMap(Map<String, dynamic> json) => FormDhRestDayTypeRestDayPerMonthChoice(
        restDayPerMonthChoice: json["rest_day_per_month_choice"],
        desc: json["desc"],
    );

    Map<String, dynamic> toMap() => {
        "rest_day_per_month_choice": restDayPerMonthChoice,
        "desc": desc,
    };
}

class AvailabilityStatusTypeAvailabilityStatus {
    final String? availabilityStatus;
    final String? availabilityStatusColor;

    AvailabilityStatusTypeAvailabilityStatus({
        this.availabilityStatus,
        this.availabilityStatusColor,
    });

    factory AvailabilityStatusTypeAvailabilityStatus.fromJson(String str) => AvailabilityStatusTypeAvailabilityStatus.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AvailabilityStatusTypeAvailabilityStatus.fromMap(Map<String, dynamic> json) => AvailabilityStatusTypeAvailabilityStatus(
        availabilityStatus: json["availability_status"],
        availabilityStatusColor: json["availability_status_color"],
    );

    Map<String, dynamic> toMap() => {
        "availability_status": availabilityStatus,
        "availability_status_color": availabilityStatusColor,
    };
}

class CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName {
    final int? countryCallingCode;
    final String? countryName;
    final String? ibanAlpha2Code;

    CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName({
        this.countryCallingCode,
        this.countryName,
        this.ibanAlpha2Code,
    });

    factory CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName.fromJson(String str) => CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName.fromMap(Map<String, dynamic> json) => CandidateEmployerProfileCreationStep1FormSwCountryCallingCodeCountryName(
        countryCallingCode: json["country_calling_code"],
        countryName: json["country_name"],
        ibanAlpha2Code: json["iban_alpha_2_code"],
    );

    Map<String, dynamic> toMap() => {
        "country_calling_code": countryCallingCode,
        "country_name": countryName,
        "iban_alpha_2_code": ibanAlpha2Code,
    };
}

class FormDhAppLocaleTypeAppLocale {
    final String? appLocale;
    final String? ibanAlpha2Code;

    FormDhAppLocaleTypeAppLocale({
        this.appLocale,
        this.ibanAlpha2Code,
    });

    factory FormDhAppLocaleTypeAppLocale.fromJson(String str) => FormDhAppLocaleTypeAppLocale.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FormDhAppLocaleTypeAppLocale.fromMap(Map<String, dynamic> json) => FormDhAppLocaleTypeAppLocale(
        appLocale: json["app_locale"],
        ibanAlpha2Code: json["iban_alpha_2_code"],
    );

    Map<String, dynamic> toMap() => {
        "app_locale": appLocale,
        "iban_alpha_2_code": ibanAlpha2Code,
    };
}

class DhAppLocaleTypePhc100000ForexValue {
    final String? appLocale;
    final dynamic candidatePhcDefaultPayMin;
    final dynamic candidatePhcDefaultPayMax;
    final String? currencyCode;
    final int? phc100000ForexValue;
    final int? maxMonthlySalary;
    final dynamic minMonthlySalary;

    DhAppLocaleTypePhc100000ForexValue({
        this.appLocale,
        this.candidatePhcDefaultPayMin,
        this.candidatePhcDefaultPayMax,
        this.currencyCode,
        this.phc100000ForexValue,
        this.maxMonthlySalary,
        this.minMonthlySalary,
    });

    factory DhAppLocaleTypePhc100000ForexValue.fromJson(String str) => DhAppLocaleTypePhc100000ForexValue.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DhAppLocaleTypePhc100000ForexValue.fromMap(Map<String, dynamic> json) => DhAppLocaleTypePhc100000ForexValue(
        appLocale: json["app_locale"],
        candidatePhcDefaultPayMin: json["candidate_PHC_default_pay_min"],
        candidatePhcDefaultPayMax: json["candidate_PHC_default_pay_max"],
        currencyCode: json["currency_code"],
        phc100000ForexValue: json["PHC_100000_FOREX_value"],
        maxMonthlySalary: json["MAX_MONTHLY_SALARY"],
        minMonthlySalary: json["MIN_MONTHLY_SALARY"],
    );

    Map<String, dynamic> toMap() => {
        "app_locale": appLocale,
        "candidate_PHC_default_pay_min": candidatePhcDefaultPayMin,
        "candidate_PHC_default_pay_max": candidatePhcDefaultPayMax,
        "currency_code": currencyCode,
        "PHC_100000_FOREX_value": phc100000ForexValue,
        "MAX_MONTHLY_SALARY": maxMonthlySalary,
        "MIN_MONTHLY_SALARY": minMonthlySalary,
    };
}

class Dh {
    final int? amount;
    final DateTime? startDate;
    final DateTime? endDate;

    Dh({
        this.amount,
        this.startDate,
        this.endDate,
    });

    factory Dh.fromJson(String str) => Dh.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Dh.fromMap(Map<String, dynamic> json) => Dh(
        amount: json["amount"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    );

    Map<String, dynamic> toMap() => {
        "amount": amount,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
    };
}

class SearchFormDhAppLocaleTypeAppLocale {
    final String? appLocale;
    final int? candidatePhcDefaultPayMin;
    final int? candidatePhcDefaultPayMax;
    final String? currencyCode;

    SearchFormDhAppLocaleTypeAppLocale({
        this.appLocale,
        this.candidatePhcDefaultPayMin,
        this.candidatePhcDefaultPayMax,
        this.currencyCode,
    });

    factory SearchFormDhAppLocaleTypeAppLocale.fromJson(String str) => SearchFormDhAppLocaleTypeAppLocale.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SearchFormDhAppLocaleTypeAppLocale.fromMap(Map<String, dynamic> json) => SearchFormDhAppLocaleTypeAppLocale(
        appLocale: json["app_locale"],
        candidatePhcDefaultPayMin: json["candidate_PHC_default_pay_min"],
        candidatePhcDefaultPayMax: json["candidate_PHC_default_pay_max"],
        currencyCode: json["currency_code"],
    );

    Map<String, dynamic> toMap() => {
        "app_locale": appLocale,
        "candidate_PHC_default_pay_min": candidatePhcDefaultPayMin,
        "candidate_PHC_default_pay_max": candidatePhcDefaultPayMax,
        "currency_code": currencyCode,
    };
}
