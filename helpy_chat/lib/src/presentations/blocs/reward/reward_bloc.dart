part of blocs;

class RewardBloc extends BlocWithState<RewardEvent, RewardState> {
  final GetRewardsListUseCase _getRewardListUseCase;
  final GetClaimRewardUseCase _getClaimRewardUseCase;
  int _currentPage = 0;
  int get currentPage => _currentPage;
  ClaimRewardModel? claimRewardModel;
  RewardDetailModel rewardDetailModel = RewardDetailModel();
  RewardListModel? rewardListModel;
  int loadMorePage = 1;
  bool nextPageUrl = true;

  void setCurrentPage(int index) {
    _currentPage = index;
  }

  void resetState() {
    claimRewardModel = null;
    rewardDetailModel = RewardDetailModel();
    _currentPage = 0;
    rewardListModel = null;
    loadMorePage = 1;
    nextPageUrl = true;
  }

  RewardBloc(this._getRewardListUseCase, this._getClaimRewardUseCase)
      : super(RewardInitialState());

  @override
  Stream<RewardState> mapEventToState(RewardEvent event) async* {
    if (event is InitializeRewardEvent) yield* _getInitializeReward(event);

    if (event is RewardsListRequested) yield* _rewardList(event);

    if (event is ClaimRewardRequested) yield* _claimReward(event);
  }

  Stream<RewardState> _getInitializeReward(InitializeRewardEvent event) async* {
    yield* runBlocProcess(() async* {
      yield RewardInitialState();
    });
  }

  //Rewards list
  Stream<RewardState> _rewardList(RewardsListRequested event) async* {
    yield* runBlocProcess(() async* {
      if (loadMorePage == 1) {
        yield RewardsListLoading();
      }
      final dataState = await _getRewardListUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        if (loadMorePage == 1) {
          if (data != null) {
            if (data.data != null) {
              rewardListModel = RewardListModel.fromMap(data.data!);
              if (rewardListModel != null) {
                if (rewardListModel!.data != null) {
                  if (rewardListModel!.data!.nextPageUrl != null) {
                    loadMorePage++;
                  } else {
                    nextPageUrl = false;
                  }
                }
              }
            }
          }
          yield RewardsListSuccess(rewardData: data!);
        } else {
          if (nextPageUrl == true) {
            if (data != null) {
              if (data.data != null) {
                final RewardListModel loadmoredata =
                    RewardListModel.fromMap(data.data!);
                if (loadmoredata.data != null) {
                  final dataList = loadmoredata.data!.data ?? [];
                  for (var element in dataList) {
                    rewardListModel!.data!.data!.add(element);
                  }
                  if (loadmoredata.data!.nextPageUrl == null) {
                    nextPageUrl = false;
                  }
                  else{
                    loadMorePage++;
                  }
                }
              }
            }
          }
          yield RewardsListSuccess(rewardData: data!);
        }
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const RewardsListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield RewardsListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Claim Reward
  Stream<RewardState> _claimReward(ClaimRewardRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ClaimRewardLoading();
      final dataState = await _getClaimRewardUseCase(
        params: event.params,
      );
      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        if (data != null) {
          claimRewardModel = ClaimRewardModel.fromMap(data.data!);
        }
        yield ClaimRewardSuccess(rewardData: data!);
      } else if (dataState is DataSuccessWithFail) {
        final DataResponseModel? data = dataState.data;
        if (data != null) {
          claimRewardModel = ClaimRewardModel.fromMap(data.data!);
        }
        yield ClaimRewardSuccessWithFail(rewardData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ClaimRewardFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ClaimRewardFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }
}
