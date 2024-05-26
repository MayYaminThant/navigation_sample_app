part of 'repositories.dart';

abstract class RewardsRepository {
  //Rewards List
  Future<DataState<DataResponseModel>> rewardLists(
      RewardListRequestParams params);
  Future<DataState<DataResponseModel>> rewardDetail(
      RewardDetailRequestParams params);
  Future<DataState<DataResponseModel>> claimRewards(
      RewardDetailRequestParams params);
}
