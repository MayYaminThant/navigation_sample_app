import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/models.dart';

part 'employer_api_service.g.dart';

@RestApi()
abstract class EmployerApiSerice {
  factory EmployerApiSerice(Dio dio, {String baseUrl}) = _EmployerApiSerice;

  //Employer Search
  @POST('/candidate')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createEmployerSearch(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Field("country") String? country,
      @Field("currency") String? currency,
      @Field("expected_salary") int? expectedSalary,
      // @Field("agent_fee") int? agentFee,
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
      @Field("rest_day_per_month_choice") int? restDayChoice,
      @Field("work_on_rest_day") int? workRestDays,
      @Field("show_only_entries_with_pics") int? showOnlyEntriesWithPics,
      @Field("save_my_search") int? saveMySearch,
      @Field("employer_religion") String? religion});

  //Employer Public Profile
  @GET('/employer')
  Future<HttpResponse<DataResponseModel>> getPublicEmployerProfile(
      {@Header("Accept") String? acceptType,
      @Path("employerId") int? employerId});
}
