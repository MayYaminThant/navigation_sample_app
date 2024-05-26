part of 'entities.dart';

class SavedSearch extends Equatable {
  final int? id;
  final String? name;
  final int? userId;
  final int? displayOrder;
  final String? createdAt;
  final String? country;
  final String? currency;
  final int? offeredSalary;
  final int? agentFee;
  final String? startDate;
  final String? endDate;
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
  final bool? workRestDays;
  final bool? showOnlyEntriesWithPics;
  final bool? saveMySearch;
  final String? ageMin;
  final String? ageMax;
  final String? religion;

  const SavedSearch({
    this.id,
    this.name,
    this.userId,
    this.displayOrder,
    this.createdAt,
    this.country,
    this.currency,
    this.offeredSalary,
    this.agentFee,
    this.startDate,
    this.endDate,
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
    this.workRestDays,
    this.showOnlyEntriesWithPics,
    this.saveMySearch,
    this.ageMin,
    this.ageMax,
    this.religion
  });

  @override
  List<Object?> get props => [
        id,
        name,
        userId,
        displayOrder,
        createdAt,
        country,
        currency,
        offeredSalary,
        agentFee,
        startDate,
        endDate,
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
        workRestDays,
        showOnlyEntriesWithPics,
        saveMySearch,
        ageMin,
        ageMax,
        religion
      ];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
        "saved_search_id": id,
        "saved_search_name": name,
        "user_id": userId,
        "country": country,
        "currency": currency,
        "offered_salary": offeredSalary,
        "agent_fee": agentFee,
        "start_date": startDate,
        "end_date": endDate,
        "skill_infant_care": skillInfantCare,
        "skill_special_needs_care": skillSpecialNeedsCare,
        "skill_elderly_care": skillElderlyCare,
        "skill_cooking": skillCooking,
        "skill_general_housework": skillGeneralHousework,
        "skill_pet_care": skillPetCare,
        "skill_handicap_care": skillHandicapCare,
        "skill_bedridden_care": skillbedriddenCare,
        "skill_others_specify": skillOthersSpecify,
        "rest_day_choice": restDayChoice,
        "work_rest_days": workRestDays,
        "show_only_entries_with_pics": showOnlyEntriesWithPics,
        "save_my_search": saveMySearch,
        "age_min": ageMin,
        "age_max": ageMax,
        "candidate_religion": religion
      };
}
