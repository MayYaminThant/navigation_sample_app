part of '../usecases.dart';

class GetAdsCountUseCase
    implements UseCase<DataState<DataResponseModel>, AdsCountRequestParams> {
  final AdsRepository _adsRepository;
  GetAdsCountUseCase(this._adsRepository);

  @override
  Future<DataState<DataResponseModel>> call({AdsCountRequestParams? params}) {
    return _adsRepository.adsCount(params!);
  }
}
