import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/models.dart';

part 'candidate_api_service.g.dart';

@RestApi()
abstract class CandidateApiService {
  factory CandidateApiService(Dio dio, {String baseUrl}) = _CandidateApiService;

  //Candidate Search
  @POST('/employer/search')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createCandidateSearch({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field("country") String? country,
    @Field("currency") String? currency,
    @Field("offered_salary") int? offeredSalary,
    @Field("candidate_nationality") String? candidateNationality,
    @Field("start_date") String? startDate,
    @Field("end_date") String? endDate,
    @Field("skill_infant_care") int? skillInfantCare,
    @Field("skill_special_needs_care") int? skillSpecialNeedsCare,
    @Field("skill_elderly_care") int? skillElderlyCare,
    @Field("skill_cooking") int? skillCooking,
    @Field("skill_general_housework") int? skillGeneralHousework,
    @Field("skill_pet_care") int? skillPetCare,
    @Field("skill_handicap_care") int? skillHandicapCare,
    @Field("skill_bedridden_care") int? skillBedriddenCare,
    @Field("dh_religion") String? religion,
    @Field("age_min") int? ageMin,
    @Field("age_max") int? ageMax,
    @Field("rest_day_per_month_choice") int? restDaysPerMonthChoice,
    @Field("work_rest_days") int? workRestDays,
    @Field("show_only_entries_with_pics") int? showOnlyEntriesWithPics,
    @Field("save_my_search") int? saveMySearch,
  });

  //Candidate Public Profile
  @GET('/candidate/public_profile/{candidateId}')
  Future<HttpResponse<DataResponseModel>> getPublicCandidateProfile(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Path("candidateId") int? userId});
}
