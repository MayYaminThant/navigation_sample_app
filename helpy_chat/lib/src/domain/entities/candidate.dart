part of 'entities.dart';

// ignore: must_be_immutable
class Candidate extends Equatable {
  final int? id;
  final String? dateOfBirth;
  final int? height;
  final int? weight;
  final String? availabilityStatus;
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
  final String? selfDesc;
  final String? expectEmployer;
  final String? familyStatus;
  final int? numOfSiblings;
  final List<dynamic>? familyMembers;
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
  final String? skillOthersSpecify;
  final int? restDayChoice;
  final bool? restDayWorkPref;
  final String? foodAllergy;
  final String? workReligionPref;
  final List<MediaFile>? media;
  final List<Employment>? employments;
  final User? user;
  final int? profileProgressBar;
  final List<Tasks>? tasksTypes;
  final String? workPermitStatus;
  final WorkPermit? workPermit;
  final String? nationality;

  const Candidate(
      {this.id,
      this.dateOfBirth,
      this.height,
      this.weight,
      this.availabilityStatus,
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
      this.selfDesc,
      this.expectEmployer,
      this.familyStatus,
      this.numOfSiblings,
      this.familyMembers,
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
      this.skillOthersSpecify,
      this.restDayChoice,
      this.restDayWorkPref,
      this.foodAllergy,
      this.workReligionPref,
      this.media,
      this.employments,
      this.user,
      this.profileProgressBar,
      this.tasksTypes,
      this.workPermitStatus,
      this.workPermit,
      this.nationality});

  @override
  List<Object?> get props => [
        id,
        dateOfBirth,
        height,
        weight,
        availabilityStatus,
        proficientEnglish,
        chineseMandarin,
        bahasaMelayu,
        tamil,
        hokkien,
        teochew,
        cantonese,
        bahasaIndonesian,
        japanese,
        korean,
        french,
        german,
        arabic,
        othersSpecify,
        selfDesc,
        expectEmployer,
        familyStatus,
        numOfSiblings,
        familyMembers,
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
        skillOthersSpecify,
        restDayChoice,
        restDayWorkPref,
        foodAllergy,
        workReligionPref,
        media,
        employments,
        user,
        profileProgressBar,
        tasksTypes,
        workPermitStatus,
        workPermit,
        nationality
      ];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
        "user_id": id,
        "date_of_birth": dateOfBirth,
        "height_cm": height,
        "weight_g": weight,
        "availability_status": availabilityStatus,
        "language_proficient_english": proficientEnglish,
        "language_chinese_mandarin": chineseMandarin,
        "language_bahasa_melayu": bahasaMelayu,
        "language_tamil": tamil,
        "language_hokkien": hokkien,
        "language_teochew": teochew,
        "language_cantonese": cantonese,
        "language_bahasa_indonesian": bahasaIndonesian,
        "language_japanese": japanese,
        "language_korean": korean,
        "language_french": french,
        "language_german": german,
        "language_arabic": arabic,
        "language_others_specify": othersSpecify,
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
        "skill_others_specify": skillOthersSpecify,
        "rest_day_work_pref": restDayWorkPref,
        "food_drug_allergy": foodAllergy,
        "rest_day_per_month_choice": restDayChoice,
        "additional_work_pref": workReligionPref,
        "media": media,
        "employments": employments,
        "user": user,
        "profile_progress_bar": profileProgressBar,
        "task_type": tasksTypes,
        "work_permit_status": workPermitStatus,
        "work_permit": workPermit,
        "nationality": nationality
      };
}
