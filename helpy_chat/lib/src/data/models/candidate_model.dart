part of 'models.dart';

class CandidateModel extends Candidate {
  const CandidateModel({
    int? id,
    String? dateOfBirth,
    int? height,
    int? weight,
    String? availabilityStatus,
    bool? proficientEnglish,
    bool? chineseMandarin,
    bool? bahasaMelayu,
    bool? tamil,
    bool? hokkien,
    bool? teochew,
    bool? cantonese,
    bool? bahasaIndonesian,
    bool? japanese,
    bool? korean,
    bool? french,
    bool? german,
    bool? arabic,
    String? othersSpecify,
    String? selfDesc,
    String? expectEmployer,
    String? familyStatus,
    int? numOfSiblings,
    List<dynamic>? familyMembers,
    String? highestQualification,
    String? educationJourneyDesc,
    bool? skillInfantCare,
    bool? skillSpecialNeedsCare,
    bool? skillElderlyCare,
    bool? skillCooking,
    bool? skillGeneralHousework,
    bool? skillPetCare,
    bool? skillHandicapCare,
    bool? skillbedriddenCare,
    String? skillOthersSpecify,
    int? restDayChoice,
    bool? restDayWorkPref,
    String? foodAllergy,
    String? workReligionPref,
    List<MediaFile>? media,
    List<Employment>? employments,
    User? user,
    int? profileProgressBar,
    List<Tasks>? tasksTypes,
    String? workPermitStatus,
    WorkPermit? workPermit,
    String? nationality
  }) : super(
            id: id,
            dateOfBirth: dateOfBirth,
            height: height,
            weight: weight,
            availabilityStatus: availabilityStatus,
            proficientEnglish: proficientEnglish,
            chineseMandarin: chineseMandarin,
            bahasaMelayu: bahasaMelayu,
            tamil: tamil,
            hokkien: hokkien,
            teochew: teochew,
            cantonese: cantonese,
            bahasaIndonesian: bahasaIndonesian,
            japanese: japanese,
            korean: korean,
            french: french,
            german: german,
            arabic: arabic,
            othersSpecify: othersSpecify,
            selfDesc: selfDesc,
            expectEmployer: expectEmployer,
            familyStatus: familyStatus,
            numOfSiblings: numOfSiblings,
            familyMembers: familyMembers,
            highestQualification: highestQualification,
            educationJourneyDesc: educationJourneyDesc,
            skillInfantCare: skillInfantCare,
            skillSpecialNeedsCare: skillSpecialNeedsCare,
            skillElderlyCare: skillElderlyCare,
            skillCooking: skillCooking,
            skillGeneralHousework: skillGeneralHousework,
            skillPetCare: skillPetCare,
            skillHandicapCare: skillHandicapCare,
            skillbedriddenCare: skillbedriddenCare,
            skillOthersSpecify: skillOthersSpecify,
            restDayChoice: restDayChoice,
            restDayWorkPref: restDayWorkPref,
            foodAllergy: foodAllergy,
            workReligionPref: workReligionPref,
            media: media,
            employments: employments,
            user: user,
            profileProgressBar: profileProgressBar,
            tasksTypes: tasksTypes,
            workPermitStatus: workPermitStatus,
            workPermit: workPermit,
            nationality: nationality
            );

  factory CandidateModel.fromJson(Map<dynamic, dynamic> map) {
    return CandidateModel(
      id: map['user_id'] != null ? map['user_id'] as int : null,
      dateOfBirth:
          map['date_of_birth'] != null ? map['date_of_birth'] as String : null,
      height: map['height_cm'] != null ? map['height_cm'] as int : null,
      weight: map['weight_g'] != null ? map['weight_g'] as int : null,
      availabilityStatus: map['availability_status'] != null
          ? map['availability_status'] as String
          : null,
      proficientEnglish: map['language_proficient_english'] != null
          ? map['language_proficient_english'] as bool
          : null,
      chineseMandarin: map['language_chinese_mandarin'] != null
          ? map['language_chinese_mandarin'] as bool
          : null,
      bahasaMelayu: map['language_bahasa_melayu'] != null
          ? map['language_bahasa_melayu'] as bool
          : null,
      tamil:
          map['language_tamil'] != null ? map['language_tamil'] as bool : null,
      hokkien: map['language_hokkien'] != null
          ? map['language_hokkien'] as bool
          : null,
      teochew: map['language_teochew'] != null
          ? map['language_teochew'] as bool
          : null,
      cantonese: map['language_cantonese'] != null
          ? map['language_cantonese'] as bool
          : null,
      bahasaIndonesian: map['language_bahasa_indonesian'] != null
          ? map['language_bahasa_indonesian'] as bool
          : null,
      japanese: map['language_japanese'] != null
          ? map['language_japanese'] as bool
          : null,
      korean: map['language_korean'] != null
          ? map['language_korean'] as bool
          : null,
      french: map['language_french'] != null
          ? map['language_french'] as bool
          : null,
      german: map['language_german'] != null
          ? map['language_german'] as bool
          : null,
      arabic: map['language_arabic'] != null
          ? map['language_arabic'] as bool
          : null,
      othersSpecify: map['language_others_specify'] != null
          ? map['language_others_specify'] as String
          : null,
      selfDesc: map['self_desc'] != null ? map['self_desc'] as String : null,
      expectEmployer: map['expect_employer'] != null
          ? map['expect_employer'] as String
          : null,
      familyStatus: map['family_status'] != null
          ? map['family_status'] as String
          : null,
      numOfSiblings:
          map['num_of_siblings'] != null ? map['num_of_siblings'] as int : null,
      familyMembers: map['family_members'] != null
          ? map['family_members'] as List<dynamic>
          : null,
      highestQualification: map['highest_qualification'] != null
          ? map['highest_qualification'] as String
          : null,
      educationJourneyDesc: map['education_journey_desc'] != null
          ? map['education_journey_desc'] as String
          : null,
      skillInfantCare: map['skill_infant_care'] != null
          ? map['skill_infant_care'] as bool
          : null,
      skillSpecialNeedsCare: map['skill_special_needs_care'] != null
          ? map['skill_special_needs_care'] as bool
          : null,
      skillElderlyCare: map['skill_elderly_care'] != null
          ? map['skill_elderly_care'] as bool
          : null,
      skillCooking:
          map['skill_cooking'] != null ? map['skill_cooking'] as bool : null,
      skillGeneralHousework: map['skill_general_housework'] != null
          ? map['skill_general_housework'] as bool
          : null,
      skillPetCare:
          map['skill_pet_care'] != null ? map['skill_pet_care'] as bool : null,
      skillHandicapCare: map['skill_handicap_care'] != null
          ? map['skill_handicap_care'] as bool
          : null,
      skillbedriddenCare: map['skill_bedridden_care'] != null
          ? map['skill_bedridden_care'] as bool
          : null,
      skillOthersSpecify: map['skill_others_specify'] != null
          ? map['skill_others_specify'] as String
          : null,
      restDayWorkPref: map['rest_day_work_pref'] != null
          ? map['rest_day_work_pref'] as bool
          : null,
      foodAllergy:
          map['food_drug_allergy'] != null ? map['food_drug_allergy'] as String : null,
      restDayChoice:
        map['rest_day_per_month_choice'] != null ? map['rest_day_per_month_choice'] as int : null,
      
      workReligionPref: map['additional_work_pref'] != null
          ? map['additional_work_pref'] as String
          : null,
      media: map['media'] != null
          ? List<MediaFile>.from((map['media'] as List<dynamic>)
              .map((e) => MediaFileModel.fromJson(e as Map<dynamic, dynamic>)))
          : null,
      employments: map['employments'] != null
          ? List<Employment>.from((map['employments'] as List<dynamic>)
              .map((e) => EmploymentModel.fromJson(e as Map<String, dynamic>)))
          : null,
      user: map['user'] != null ? UserModel.fromJson(map['user']) : null,
      profileProgressBar: map['profile_progress_bar'] != null
          ? map['profile_progress_bar'] as int
          : null,
      tasksTypes: map['task_type'] != null
          ? List<Tasks>.from((map['task_type'] as List<dynamic>)
              .map((e) => TasksModel.fromJson(e as Map<String, dynamic>)))
          : null,
      workPermitStatus: map['work_permit_status'] != null ? map['work_permit_status'] as String : null,
      workPermit: map['work_permit'] != null ? WorkPermitModel.fromJson(map['work_permit']) : null,
      nationality: map['nationality'] != null ? map['nationality'] as String : null
    );
  }
}
