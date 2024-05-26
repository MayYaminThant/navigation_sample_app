part of '../usecases.dart';

class GetAdsListUseCase implements UseCase<DataState<DataResponseModel>, AdsListRequestParams> {
  final AdsRepository _adsRepository;
  GetAdsListUseCase(this._adsRepository);

  @override
  Future<DataState<DataResponseModel>> call({AdsListRequestParams? params}) {
    return _adsRepository.getAdsList(params!);
  }
}
