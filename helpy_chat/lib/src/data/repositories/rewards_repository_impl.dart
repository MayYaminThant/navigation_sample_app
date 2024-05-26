part of 'repositories_impl.dart';

class RewardsRepositoryImpl implements RewardsRepository {
  final RewardApiSerice _rewardApiSerice;

  const RewardsRepositoryImpl(this._rewardApiSerice);

  @override
  Future<DataState<DataResponseModel>> rewardLists(
      RewardListRequestParams params) async {
    try {
      final httpResponse = await _rewardApiSerice.getRewards(
          acceptType: 'application/json',
          country: params.appLocale,
          token: "Bearer ${params.bearerToken}",
          page: params.page ?? 1);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> claimRewards(
      RewardDetailRequestParams params) async {
    try {
      final httpResponse = await _rewardApiSerice.claimReward(
          acceptType: 'application/json',
          rewardId: params.rewardId,
          token: "Bearer ${params.bearerToken}");
      if (httpResponse.response.statusCode == 200 ||
          httpResponse.response.statusCode == 422) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 || e.response?.statusCode == 401) {
        return DataSuccessWithFail(
            DataResponseModel.fromJson(e.response!.data));
      } else {
        return DataFailed(e);
      }
    }
  }

  @override
  Future<DataState<DataResponseModel>> rewardDetail(
      RewardDetailRequestParams params) async {
    try {
      final httpResponse = await _rewardApiSerice.rewardDetail(
          acceptType: 'application/json',
          country: params.appLocale,
          rewardId: "${params.rewardId}",
          token: "Bearer ${params.bearerToken}");
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
