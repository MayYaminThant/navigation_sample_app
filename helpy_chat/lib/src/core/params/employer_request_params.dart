part of 'params.dart';

//Create Employer Search
class EmployerSearchCreateRequestParams {
  final String? token;
  final int? userId;
  final String? country;
  final String? currency;
  final int? expectedSalary;
  final int? agentFee;
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
  final int? restDayChoice;
  final bool? workRestDays;
  final bool? showOnlyEntriesWithPics;
  final bool? saveMySearch;
  final String? religion;

  EmployerSearchCreateRequestParams(
      {this.token,
      this.userId,
      this.country,
      this.currency,
      this.expectedSalary,
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
      this.skillBedriddenCare,
      this.restDayChoice,
      this.workRestDays,
      this.showOnlyEntriesWithPics,
      this.saveMySearch,
      this.religion
      });
}

//Employer Public Profile
class EmployerPublicProfileRequestParams {
  final int? employerId;

  EmployerPublicProfileRequestParams({
    this.employerId,
  });
}
