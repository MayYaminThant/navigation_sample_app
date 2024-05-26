part of blocs;

abstract class RewardEvent extends Equatable {
  const RewardEvent();

  @override
  List<Object> get props => [];
}

class InitializeRewardEvent extends RewardEvent {
  @override
  String toString() => "InitializePageEvent";
}

//Reward Lists
class RewardsListRequested extends RewardEvent {
  final RewardListRequestParams? params;

  const RewardsListRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

class ClaimRewardRequested extends RewardEvent {
  final RewardDetailRequestParams? params;

  const ClaimRewardRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}
