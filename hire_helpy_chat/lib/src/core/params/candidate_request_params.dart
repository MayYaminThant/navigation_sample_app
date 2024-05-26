part of 'params.dart';

//Create Candidate Search
class CandidateSearchCreateRequestParams {
  final String? token;
  final String? country;
  final String? currency;
  final int? offeredSalary;
  final String candidateNationality;
  final String? startDate;
  final String? endDate;
  final int? skillInfantCare;
  final int? skillSpecialNeedsCare;
  final int? skillElderlyCare;
  final int? skillCooking;
  final int? skillGeneralHousework;
  final int? skillPetCare;
  final int? skillHandicapCare;
  final int? skillBedriddenCare;
  final String? religion;
  final int? ageMin;
  final int? ageMax;
  final int? restDaysPerMonthChoice;
  final bool? workRestDays;
  final bool? showOnlyEntriesWithPics;
  final bool? saveMySearch;

  CandidateSearchCreateRequestParams({
    this.token,
    this.country,
    this.currency,
    this.offeredSalary,
    required this.candidateNationality,
    this.startDate,
    this.endDate,
    this.skillInfantCare,
    this.skillSpecialNeedsCare,
    this.skillElderlyCare,
    this.skillCooking,
    this.skillGeneralHousework,
    this.skillPetCare,
    this.skillHandicapCare,
    this.skillBedriddenCare,
    this.religion,
    this.ageMin,
    this.ageMax,
    this.restDaysPerMonthChoice,
    this.workRestDays,
    this.showOnlyEntriesWithPics,
    this.saveMySearch,
  });
}

//Candidate Public Profile
class CandidatePublicProfileRequestParams {
  final int? candidateId;

  CandidatePublicProfileRequestParams({
    this.candidateId,
  });
}
