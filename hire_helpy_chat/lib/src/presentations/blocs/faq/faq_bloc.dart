part of blocs;

//Faq
class FaqBloc extends BlocWithState<FaqEvent, FaqState> {
  final GetFaqUseCase _getFaqUseCase;
  FaqModel faqDataModel = FaqModel();
  int loadMorePage = 1;
  bool nextPageUrl = true;

  FaqBloc(this._getFaqUseCase) : super(FaqInitialState());

  void resetState() {
    faqDataModel = FaqModel();
    loadMorePage = 1;
    nextPageUrl = true;
  }

  @override
  Stream<FaqState> mapEventToState(FaqEvent event) async* {
    if (event is InitializeFaqEvent) {
      yield* _getInitializeFaq(event);
    }
    if (event is FaqsRequested) {
      yield* _faqs(event);
    }
    if (event is FaqsSearched) {
      yield* _faqSearch(event);
    }
  }

  Stream<FaqState> _getInitializeFaq(InitializeFaqEvent event) async* {
    yield* runBlocProcess(() async* {
      yield FaqInitialState();
    });
  }

  Stream<FaqState> _faqs(FaqsRequested event) async* {
    yield* runBlocProcess(() async* {
      if (loadMorePage == 1) {
        yield FaqsLoading();
      }
      final DataState<DataResponseModel> dataState = await _getFaqUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        if (loadMorePage == 1) {
          if (data != null) {
            if (data.data != null) {
              faqDataModel = FaqModel.fromMap(data.data!);
              if (faqDataModel.data != null) {
                if (faqDataModel.data!.data != null) {
                  if (faqDataModel.data!.nextPageUrl != null) {
                    faqDataModel.data!.data!.sort(
                        (a, b) => a.faqRankOrder!.compareTo(b.faqRankOrder!));
                    loadMorePage++;
                  } else {
                    nextPageUrl = false;
                  }
                }
              }
            }
          }
          yield FaqsSuccess(faqData: data!);
        } else {
          if (nextPageUrl == true) {
            if (data != null) {
              if (data.data != null) {
                final FaqModel loadmoredata = FaqModel.fromMap(data.data!);
                if (loadmoredata.data != null) {
                  final dataList = loadmoredata.data!.data ?? [];
                  for (var element in dataList) {
                    faqDataModel.data!.data!.add(element);
                  }
                  faqDataModel.data!.data!.sort(
                      (a, b) => a.faqRankOrder!.compareTo(b.faqRankOrder!));
                  if (loadmoredata.data!.nextPageUrl == null) {
                    nextPageUrl = false;
                  } else {
                    loadMorePage++;
                  }
                }
              }
            }
          }
          yield FaqsSuccess(faqData: data!);
        }
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const FaqsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield FaqsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  Stream<FaqState> _faqSearch(FaqsSearched event) async* {
    yield* runBlocProcess(() async* {
      final query = event.query;
      final results = faqDataModel.data!.data!
          .where((data) =>
              data.question!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      yield FaqsSearchSuccess(data: results);
    });
  }
}
