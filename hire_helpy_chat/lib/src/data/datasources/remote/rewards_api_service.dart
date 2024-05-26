import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/models.dart';

part 'rewards_api_service.g.dart';

@RestApi()
abstract class RewardApiSerice {
  factory RewardApiSerice(Dio dio, {String baseUrl}) = _RewardApiSerice;

  //Rewards
  @GET('/employer/rewards')
  Future<HttpResponse<DataResponseModel>> getRewards({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Query("app_locale") String? country,
    @Query("page") required int page,
  });

  //ClaimReward
  @GET('/employer')
  Future<HttpResponse<DataResponseModel>> claimReward({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("rewardId") int? rewardId,
  });

  //Reward Detail
  @GET('/employer/rewards/{rewardId}')
  Future<HttpResponse<DataResponseModel>> rewardDetail({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Query("app_locale") String? country,
    @Path("rewardId") required String rewardId,
  });
}
