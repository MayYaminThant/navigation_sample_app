part of blocs;

class CandidateBloc extends BlocWithState<CandidateEvent, CandidateState> {
  // ignore: non_constant_identifier_names
  final CreateCandidateSearchUseCase _createCandidateSearchUseCase;
  final GetCandidateProfileUseCase _getCandidateProfileUseCase;

  CandidateBloc(
    this._createCandidateSearchUseCase,
    this._getCandidateProfileUseCase
  ) : super(CandidateInitialState());

  @override
  Stream<CandidateState> mapEventToState(CandidateEvent event) async* {
    if (event is InitializeCandidateEvent) {
      yield* _getInitializeCandidate(event);
    }

    if (event is CandidateSearchCreateRequested) {
      yield* _createCandidateSearch(event);
    }
    
     if (event is CandidatePublicProfileRequested) {
       yield* _getCandidatePublicProfile(event);
     }
  }

  Stream<CandidateState> _getInitializeCandidate(
      InitializeCandidateEvent event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateInitialState();
    });
  }

  //Candidates list
  Stream<CandidateState> _createCandidateSearch(
      CandidateSearchCreateRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidateSearchCreateLoading();
      final dataState = await _createCandidateSearchUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield CandidateSearchCreateSuccess(candidateData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidateSearchCreateFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidateSearchCreateFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Candidate Profile Profile
  Stream<CandidateState> _getCandidatePublicProfile(
      CandidatePublicProfileRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CandidatePublicProfileLoading();
      final dataState = await _getCandidateProfileUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield CandidatePublicProfileSuccess(candidateData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CandidatePublicProfileFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CandidatePublicProfileFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }
}
