part of 'repositories_impl.dart';

class AdsRepositoryImpl implements AdsRepository {
  final AdsApiService _adsApiService;

  const AdsRepositoryImpl(this._adsApiService);
  
  @override
  Future<DataState<DataResponseModel>> getAdsList(AdsListRequestParams params) async{
    try {
      final httpResponse = await _adsApiService.getAdsList(
        acceptType: 'application/json',
        appLocale: params.appLocale,
        displayType: params.displayType
      );

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
