part of 'params.dart';

//Rewards List
class RewardListRequestParams {
  final String? appLocale;
  final int? page;
  final String? bearerToken;

  RewardListRequestParams({
    this.bearerToken,
    this.page,
    this.appLocale,
  });
}

//Rewards Detail
class RewardDetailRequestParams {
  final String? appLocale;
  final int? rewardId;
  final String? bearerToken;

  RewardDetailRequestParams({this.appLocale, this.rewardId, this.bearerToken});
}
