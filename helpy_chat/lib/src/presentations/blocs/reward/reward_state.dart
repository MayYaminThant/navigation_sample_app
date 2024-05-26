part of blocs;


abstract class RewardState extends Equatable {
  const RewardState();

  @override
  List<Object> get props => [];
}

class RewardInitialState extends RewardState {
  @override
  String toString() => "InitializePageState";
}


//Reward Lists
class RewardsListLoading extends RewardState {}

class RewardsListSuccess extends RewardState {
  final DataResponseModel rewardData;

  const RewardsListSuccess({required this.rewardData});

  @override
  List<Object> get props => [rewardData];
}


class RewardsListSuccesswithFail extends RewardState {
  final DataResponseModel rewardData;

  const RewardsListSuccesswithFail({required this.rewardData});

  @override
  List<Object> get props => [rewardData];
}

class RewardsListFail extends RewardState {
  final String message;
  const RewardsListFail({required this.message});
}

//Claim Reward
class ClaimRewardLoading extends RewardState {}

class ClaimRewardSuccess extends RewardState {
  final DataResponseModel rewardData;

  const ClaimRewardSuccess({required this.rewardData});

  @override
  List<Object> get props => [rewardData];
}

class ClaimRewardSuccessWithFail extends RewardState {
  final DataResponseModel rewardData;

  const ClaimRewardSuccessWithFail({required this.rewardData});

  @override
  List<Object> get props => [rewardData];
}

class ClaimRewardFail extends RewardState {
  final String message;
  const ClaimRewardFail({required this.message});
}