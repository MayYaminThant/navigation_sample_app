part of '../usecases.dart';

class GetClaimRewardUseCase
    implements
        UseCase<DataState<DataResponseModel>, RewardDetailRequestParams> {
  final RewardsRepository _rewardsRepository;
  GetClaimRewardUseCase(this._rewardsRepository);

  @override
  Future<DataState<DataResponseModel>> call(
      {RewardDetailRequestParams? params}) {
    return _rewardsRepository.claimRewards(params!);
  }
}
