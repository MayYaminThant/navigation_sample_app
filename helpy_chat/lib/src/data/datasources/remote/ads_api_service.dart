import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/models.dart';

part 'ads_api_service.g.dart';

@RestApi()
abstract class AdsApiService {
  factory AdsApiService(Dio dio, {String baseUrl}) = _AdsApiService;

  //Candidate Ads
  @POST('/candidate/ads')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> getAdsList(
      {@Header("Accept") String? acceptType,
      @Field("app_locale") String? appLocale,
      @Field("display_effect") String? displayType});

  //Candidate Ads
  @POST('/candidate/ads/ads')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> adsCount({
    @Header("Accept") String? acceptType,
    @Path("ads") String? ads,
  });
}
