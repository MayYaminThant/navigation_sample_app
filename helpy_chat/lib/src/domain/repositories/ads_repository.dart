part of 'repositories.dart';

abstract class AdsRepository {
  //Ads
  Future<DataState<DataResponseModel>> getAdsList(AdsListRequestParams params);
//ads count
  Future<DataState<DataResponseModel>> adsCount(AdsCountRequestParams params);
}
