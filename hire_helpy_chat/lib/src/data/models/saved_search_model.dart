part of 'models.dart';

class SavedSearchModel extends SavedSearch {
  const SavedSearchModel({
    int? id,
    String? name,
    int? userId,
    int? displayOrder,
    String? createdAt,
    String? country,
    String? currency,
    int? offeredSalary,
    int? agentFee,
    String? startDate,
    bool? skillInfantCare,
    bool? skillSpecialNeedsCare,
    bool? skillElderlyCare,
    bool? skillCooking,
    bool? skillGeneralHousework,
    bool? skillPetCare,
    bool? skillHandicapCare,
    bool? skillbedriddenCare,
    String? skillOthersSpecify,
    String? endDate,
    int? restDayChoice,
    bool? workRestDays,
    bool? showOnlyEntriesWithPics,
    bool? saveMySearch,
    String? ageMin,
    String? ageMax,
    String? religion
  }) : super(
            id: id,
            name: name,
            userId: userId,
            displayOrder: displayOrder,
            createdAt: createdAt,
            country: country,
            currency: currency,
            offeredSalary: offeredSalary,
            agentFee: agentFee,
            startDate: startDate,
            restDayChoice: restDayChoice,
            endDate: endDate,
            skillInfantCare: skillInfantCare,
            skillSpecialNeedsCare: skillSpecialNeedsCare,
            skillElderlyCare: skillElderlyCare,
            skillCooking: skillCooking,
            skillGeneralHousework: skillGeneralHousework,
            skillPetCare: skillPetCare,
            skillHandicapCare: skillHandicapCare,
            skillbedriddenCare: skillbedriddenCare,
            skillOthersSpecify: skillOthersSpecify,
            workRestDays: workRestDays,
            showOnlyEntriesWithPics: showOnlyEntriesWithPics,
            saveMySearch: saveMySearch,
            ageMin: ageMin,
            ageMax: ageMax,
            religion: religion,
            );

  factory SavedSearchModel.fromJson(Map<dynamic, dynamic> map) {
    return SavedSearchModel(
      id: map['saved_search_id'] != null ? map['saved_search_id'] as int : null,
      name: map['saved_search_name'] != null
          ? map['saved_search_name'] as String
          : null,
      userId:
          map['user_id'] != null ? int.parse(map['user_id'].toString()) : null,
      country: map['saved_search_data']['country'] != null
          ? map['saved_search_data']['country'] as String
          : null,
      currency: map['saved_search_data']['currency'] != null
          ? map['saved_search_data']['currency'] as String
          : null,
      offeredSalary: map['saved_search_data']['offered_salary'] != null
          ? int.parse(map['saved_search_data']['offered_salary'].toString())
          : null,
      agentFee: map['saved_search_data']['agent_fee'] != null
          ? int.parse(map['saved_search_data']['agent_fee'].toString())
          : null,
      startDate: map['saved_search_data']['start_date'] != null
          ? map['saved_search_data']['start_date'] as String
          : null,
      endDate: map['saved_search_data']['end_date'] != null
          ? map['saved_search_data']['end_date'] as String
          : null,
      skillInfantCare: map['saved_search_data']['skill_infant_care'] != null
          ? int.parse(map['saved_search_data']['skill_infant_care']) == 1
          : null,
      skillSpecialNeedsCare: map['saved_search_data']['skill_special_needs_care'] != null
          ? int.parse(map['saved_search_data']['skill_special_needs_care']) == 1
          : null,
      skillElderlyCare: map['saved_search_data']['skill_elderly_care'] != null
          ? int.parse(map['saved_search_data']['skill_elderly_care']) == 1
          : null,
      skillCooking: map['saved_search_data']['skill_cooking'] != null
          ? int.parse(map['saved_search_data']['skill_cooking']) == 1
          : null,
      skillGeneralHousework: map['saved_search_data']['skill_general_housework'] != null
          ? int.parse(map['saved_search_data']['skill_general_housework']) == 1
          : null,
      skillPetCare: map['saved_search_data']['skill_pet_care'] != null
          ? int.parse(map['saved_search_data']['skill_pet_care']) == 1
          : null,
      skillHandicapCare: map['saved_search_data']['skill_handicap_care'] != null
          ? int.parse(map['saved_search_data']['skill_handicap_care']) == 1
          : null,
      skillbedriddenCare: map['saved_search_data']['skill_bedridden_care'] != null
          ? int.parse(map['saved_search_data']['skill_bedridden_care']) == 1
          : null,
      skillOthersSpecify: map['saved_search_data']['skill_others_specify'] != null
          ? map['saved_search_data']['skill_others_specify'] as String
          : null,
      restDayChoice: map['saved_search_data']['rest_day_choice'] != null
          ? int.parse(map['saved_search_data']['rest_day_choice'].toString())
          : null,
      workRestDays: map['saved_search_data']['work_rest_days'] != null
          ? int.parse(map['saved_search_data']['work_rest_days'].toString()) !=
                  0
              ? true
              : false
          : null,
      showOnlyEntriesWithPics:
          map['saved_search_data']['show_only_entries_with_pics'] != null
              ? int.parse(map['saved_search_data']
                              ['show_only_entries_with_pics']
                          .toString()) !=
                      0
                  ? true
                  : false
              : null,
      createdAt: map['saved_search_creation_datetime'] != null
          ? map['saved_search_creation_datetime'] as String
          : null,
      displayOrder: map['saved_search_display_order'] != null
          ? map['saved_search_display_order'] as int
          : null,
      saveMySearch: map['saved_search_data']['save_my_search'] != null
          ? int.parse(map['saved_search_data']['save_my_search'].toString()) !=
                  0
              ? true
              : false
          : null,
      ageMin: map['saved_search_data']['age_min'] != null
          ? map['saved_search_data']['age_min'] as String
          : null,
      ageMax: map['saved_search_data']['age_max'] != null
          ? map['saved_search_data']['age_max'] as String
          : null,
      religion: map['saved_search_data']['candidate_religion'] != null
          ? map['saved_search_data']['candidate_religion'] as String
          : null,
    );
  }

  factory SavedSearchModel.fromSavedJson(Map<dynamic, dynamic> map) {
    return SavedSearchModel(
      id: map['saved_search_id'] != null ? map['saved_search_id'] as int : null,
      name: map['saved_search_name'] != null
          ? map['saved_search_name'] as String
          : null,
      userId:
          map['user_id'] != null ? int.parse(map['user_id'].toString()) : null,
      country: map['country'] != null
          ? map['country'] as String
          : null,
      currency: map['currency'] != null
          ? map['currency'] as String
          : null,
      offeredSalary: map['offered_salary'] != null
          ? int.parse(map['offered_salary'].toString())
          : null,
      agentFee: map['agent_fee'] != null
          ? int.parse(map['agent_fee'].toString())
          : null,
      startDate: map['start_date'] != null
          ? map['start_date'] as String
          : null,
      endDate: map['end_date'] != null
          ? map['end_date'] as String
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
      skillCooking: map['skill_cooking'] != null
          ? map['skill_cooking'] as bool
          : null,
      skillGeneralHousework: map['skill_general_housework'] != null
          ? map['skill_general_housework'] as bool
          : null,
      skillPetCare: map['skill_pet_care'] != null
          ? map['skill_pet_care'] as bool
          : null,
      skillHandicapCare: map['skill_handicap_care'] != null
          ? map['skill_handicap_care'] as bool
          : null,
      skillbedriddenCare: map['skill_bedridden_care'] != null
          ? map['skill_bedridden_care'] as bool
          : null,
      skillOthersSpecify: map['skill_others_specify'] != null
          ? map['skill_others_specify'] as String
          : null,
      restDayChoice: map['rest_day_choice'] != null
          ? int.parse(map['rest_day_choice'].toString())
          : null,
      workRestDays: map['work_rest_days'] != null
          ? map['work_rest_days'] as bool
          : null,
      showOnlyEntriesWithPics:
          map['show_only_entries_with_pics'] != null
              ? map['show_only_entries_with_pics'] as bool
              : null,
      createdAt: map['saved_search_creation_datetime'] != null
          ? map['saved_search_creation_datetime'] as String
          : null,
      displayOrder: map['saved_search_display_order'] != null
          ? map['saved_search_display_order'] as int
          : null,
      saveMySearch: map['save_my_search'] != null
          ? map['save_my_search'] as bool
          : null,
      ageMin: map['age_min'] != null
          ? map['age_min'] as String
          : null,
      ageMax: map['age_max'] != null
          ? map['age_max'] as String
          : null,
      religion: map['candidate_religion'] != null
          ? map['candidate_religion'] as String
          : null,
    );
  }
}

