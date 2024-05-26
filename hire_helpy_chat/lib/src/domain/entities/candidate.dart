part of 'entities.dart';

// ignore: must_be_immutable
class Candidate extends Equatable {
  final int? id;
  final String? countryOfResidence;
  final String? dateOfBirth;
  final int? height;
  final int? weight;
  final String? availabilityStatus;
  final bool? languageProficientEnglish;
  final bool? languageChineseMandarin;
  final bool? languageBahasaMelayu;
  final bool? languageTamil;
  final bool? languageHokkien;
  final bool? languageTeochew;
  final bool? languageCantonese;
  final bool? languageBahasaIndonesian;
  final bool? languageJapanese;
  final bool? languageKorean;
  final bool? languageFrench;
  final bool? languageGerman;
  final bool? languageArabic;
  final String? languageOthersSpecify;
  final String? selfDesc;
  final String? expectEmployer;
  final String? familyStatus;
  final int? numOfSiblings;
  final String? highestQualification;
  final String? educationJourneyDesc;
  final bool? skillInfantCare;
  final bool? skillSpecialNeedsCare;
  final bool? skillElderlyCare;
  final bool? skillCooking;
  final bool? skillGeneralHousework;
  final bool? skillPetCare;
  final bool? skillHandicapCare;
  final bool? skillbedriddenCare;
  final bool? skillOthers;
  final String? skillOthersSpecify;
  final bool? restDayWorkPref;
  final int? restDayChoice;
  final String? foodDrugAllergy;
  final String? workReligionPref;
  final List<MediaFile>? media;
  final List<Employment>? employments;
  final User? user;
  final BidData? bidData;
  final List<dynamic>? familyMembers;
  final List<Tasks>? tasksTypes;
  final List<Review>? reviews;
  final String? workPermitStatus;
  final WorkPermit? workPermit;

  const Candidate(
      {this.id,
      this.countryOfResidence,
      this.dateOfBirth,
      this.height,
      this.weight,
      this.availabilityStatus,
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
      this.languageOthersSpecify,
      this.selfDesc,
      this.expectEmployer,
      this.familyStatus,
      this.numOfSiblings,
      this.highestQualification,
      this.educationJourneyDesc,
      this.skillInfantCare,
      this.skillSpecialNeedsCare,
      this.skillElderlyCare,
      this.skillCooking,
      this.skillGeneralHousework,
      this.skillPetCare,
      this.skillHandicapCare,
      this.skillbedriddenCare,
      this.skillOthers,
      this.skillOthersSpecify,
      this.restDayWorkPref,
      this.restDayChoice,
      this.foodDrugAllergy,
      this.workReligionPref,
      this.media,
      this.employments,
      this.user,
      this.bidData,
      this.familyMembers,
      this.tasksTypes,
      this.reviews,
      this.workPermitStatus,
      this.workPermit
      });

  @override
  List<Object?> get props => [
        id,
        countryOfResidence,
        dateOfBirth,
        height,
        weight,
        availabilityStatus,
        languageProficientEnglish,
        languageChineseMandarin,
        languageBahasaMelayu,
        languageTamil,
        languageHokkien,
        languageTeochew,
        languageCantonese,
        languageBahasaIndonesian,
        languageJapanese,
        languageKorean,
        languageFrench,
        languageGerman,
        languageArabic,
        languageOthersSpecify,
        selfDesc,
        expectEmployer,
        familyStatus,
        numOfSiblings,
        highestQualification,
        educationJourneyDesc,
        skillInfantCare,
        skillSpecialNeedsCare,
        skillElderlyCare,
        skillCooking,
        skillGeneralHousework,
        skillPetCare,
        skillHandicapCare,
        skillbedriddenCare,
        skillOthers,
        skillOthersSpecify,
        restDayChoice,
        restDayWorkPref,
        foodDrugAllergy,
        workReligionPref,
        media,
        employments,
        user,
        bidData,
        familyMembers,
        tasksTypes,
        reviews,
        workPermitStatus,
        workPermit
      ];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
        "user_id": id,
        "country_of_residence": countryOfResidence,
        "date_of_birth": dateOfBirth,
        "height_cm": height,
        "weight_g": weight,
        "availability_status": availabilityStatus,
        "language_proficient_english": languageProficientEnglish,
        "language_chinese_mandarin": languageChineseMandarin,
        "language_bahasa_melayu": languageBahasaMelayu,
        "language_tamil": languageTamil,
        "language_hokkien": languageHokkien,
        "language_teochew": languageTeochew,
        "language_cantonese": languageCantonese,
        "language_bahasa_indonesian": languageBahasaIndonesian,
        "language_japanese": languageJapanese,
        "language_korean": languageKorean,
        "language_french": languageFrench,
        "language_german": languageGerman,
        "language_arabic": languageArabic,
        "language_others_specify": languageOthersSpecify,
        "self_desc": selfDesc,
        "expect_employer": expectEmployer,
        "family_status": familyStatus,
        "num_of_siblings": numOfSiblings,
        "family_members": familyMembers,
        "highest_qualification": highestQualification,
        "education_journey_desc": educationJourneyDesc,
        "skill_infant_care": skillInfantCare,
        "skill_special_needs_care": skillSpecialNeedsCare,
        "skill_elderly_care": skillElderlyCare,
        "skill_cooking": skillCooking,
        "skill_general_housework": skillGeneralHousework,
        "skill_pet_care": skillPetCare,
        "skill_handicap_care": skillHandicapCare,
        "skill_bedridden_care": skillbedriddenCare,
        "skill_others": skillOthers,
        "rest_day_work_pref": restDayWorkPref,
        "food_drug_allergy": foodDrugAllergy,
        "rest_day_per_month_choice": restDayChoice,
        "additional_work_pref": workReligionPref,
        "media": media,
        "employments": employments,
        "user": user,
        "task_type": tasksTypes,
        "reviews": reviews,
        "work_permit_status": workPermitStatus,
        "work_permit": workPermit,
        "bid_data": bidData
      };
}
