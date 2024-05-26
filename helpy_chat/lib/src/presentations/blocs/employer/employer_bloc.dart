part of blocs;

class EmployerBloc extends BlocWithState<EmployerEvent, EmployerState> {
  // ignore: non_constant_identifier_names
  final CreateEmployerSearchUseCase _createEmployerSearchUseCase;
  final GetEmployerProfileUseCase _getEmployerProfileUseCase;

  EmployerBloc(
    this._createEmployerSearchUseCase,
    this._getEmployerProfileUseCase
  ) : super(EmployerInitialState());

  @override
  Stream<EmployerState> mapEventToState(EmployerEvent event) async* {
    if (event is InitializeEmployerEvent) yield* _getInitializeEmployer(event);

    if (event is EmployerSearchCreateRequested) {
      yield* _createEmployerSearch(event);
    }

    if (event is EmployerPublicProfileRequested) {
      yield* _getEmployerPublicProfile(event);
    }
  }

  Stream<EmployerState> _getInitializeEmployer(
      InitializeEmployerEvent event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerInitialState();
    });
  }

  //Employers list
  Stream<EmployerState> _createEmployerSearch(
      EmployerSearchCreateRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerSearchCreateLoading();
      final dataState = await _createEmployerSearchUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield EmployerSearchCreateSuccess(employerData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerSearchCreateFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerSearchCreateFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Employer Profile Profile
  Stream<EmployerState> _getEmployerPublicProfile(
      EmployerPublicProfileRequested event) async* {
    yield* runBlocProcess(() async* {
      yield EmployerPublicProfileLoading();
      final dataState = await _getEmployerProfileUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield EmployerPublicProfileSuccess(employerData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const EmployerPublicProfileFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield EmployerPublicProfileFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }
}
