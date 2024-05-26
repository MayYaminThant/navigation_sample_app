part of 'repositories.dart';

abstract class AdsRepository {

  //Ads
  Future<DataState<DataResponseModel>> getAdsList(AdsListRequestParams params);

}
