part of blocs;

//Faq
class FaqBloc extends BlocWithState<FaqEvent, FaqState> {
  final GetFaqUseCase _getFaqUseCase;

  FaqBloc(this._getFaqUseCase) : super(FaqInitialState());
  @override
  Stream<FaqState> mapEventToState(FaqEvent event) async* {
    if (event is InitializeFaqEvent) {
      yield* _getInitializeFaq(event);
    }
    if (event is FaqsRequested) {
      yield* _faqs(event);
    }
    if (event is FaqsSearchRequested) {
      yield* _faqsSearch(event);
    }
  }

  Stream<FaqState> _getInitializeFaq(InitializeFaqEvent event) async* {
    yield* runBlocProcess(() async* {
      yield FaqInitialState();
    });
  }

  Stream<FaqState> _faqs(FaqsRequested event) async* {
    yield* runBlocProcess(() async* {
      yield FaqsLoading();
      final DataState<DataResponseModel> dataState = await _getFaqUseCase(
        params: event.params,
      );
      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield FaqsSuccess(faqData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const FaqsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          superPrint(dataState.error!.response!.data);
          yield FaqsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  Stream<FaqState> _faqsSearch(FaqsSearchRequested event) async* {
    yield* runBlocProcess(() async* {
      yield FaqsLoading();
      final DataState<DataResponseModel> dataState = await _getFaqUseCase(
        params: event.params,
      );
      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield FaqsSuccess(faqData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const FaqsFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          superPrint(dataState.error!.response!.data);
          yield FaqsFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }
}
