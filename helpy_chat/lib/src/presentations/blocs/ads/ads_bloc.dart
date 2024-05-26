part of blocs;

class AdsBloc extends BlocWithState<AdsEvent, AdsState> {
  // ignore: non_constant_identifier_names
  final GetAdsListUseCase _getAdsListUseCase;
  final GetAdsCountUseCase _getAdsCountUseCase;

  AdsBloc(
    this._getAdsListUseCase,
    this._getAdsCountUseCase,
  ) : super(AdsInitialState());

  @override
  Stream<AdsState> mapEventToState(AdsEvent event) async* {
    if (event is InitializeAdsEvent) yield* _getInitializeAds(event);

    if (event is CandidateAdsListRequested) yield* _getAdsList(event);

    if (event is CandidateFadeAdsListRequested) yield* _getFadeAdsList(event);

    if (event is CandidateCountRequested) yield* _adsCount(event);
  }

  Stream<AdsState> _getInitializeAds(InitializeAdsEvent event) async* {
    yield* runBlocProcess(() async* {
      yield AdsInitialState();
    });
  }

  //Get Ads List
  Stream<AdsState> _getAdsList(CandidateAdsListRequested event) async* {
    yield* runBlocProcess(() async* {
      yield AdsListLoading();
      final dataState = await _getAdsListUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield AdsListSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const AdsListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield AdsListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Get Fade Ads List
  Stream<AdsState> _getFadeAdsList(CandidateFadeAdsListRequested event) async* {
    yield* runBlocProcess(() async* {
      yield AdsFadeListLoading();
      final dataState = await _getAdsListUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield AdsFadeListSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const AdsFadeListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield AdsFadeListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //AdsCount
  Stream<AdsState> _adsCount(CandidateCountRequested event) async* {
    yield* runBlocProcess(() async* {
      yield AdsCountLoading();
      final dataState = await _getAdsCountUseCase(params: event.params);

      if (dataState is DataSuccess) {
        final DataResponseModel? getData = dataState.data;
        yield AdsCountSuccess(data: getData!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const AdsCountFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield AdsCountFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }
}
