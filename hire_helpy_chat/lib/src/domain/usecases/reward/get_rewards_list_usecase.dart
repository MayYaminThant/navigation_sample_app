part of '../usecases.dart';

class GetRewardsListUseCase implements UseCase<DataState<DataResponseModel>, RewardListRequestParams> {
  final RewardsRepository _rewardsRepository;
  GetRewardsListUseCase(this._rewardsRepository);

  @override
  Future<DataState<DataResponseModel>> call({RewardListRequestParams? params}) {
    return _rewardsRepository.rewardLists(params!);
  }
}
