part of blocs;

abstract class EmployerState extends Equatable {
  const EmployerState();

  @override
  List<Object> get props => [];
}

class EmployerInitialState extends EmployerState {
  @override
  String toString() => "InitializePageState";
}


//Employer Search Create
class EmployerSearchCreateLoading extends EmployerState {}

class EmployerSearchCreateSuccess extends EmployerState {
  final DataResponseModel employerData;

  const EmployerSearchCreateSuccess({required this.employerData});

  @override
  List<Object> get props => [employerData];
}

class EmployerSearchCreateFail extends EmployerState {
  final String message;
  const EmployerSearchCreateFail({required this.message});
}

//Employer Public Profile
class EmployerPublicProfileLoading extends EmployerState {}

class EmployerPublicProfileSuccess extends EmployerState {
  final DataResponseModel employerData;

  const EmployerPublicProfileSuccess({required this.employerData});

  @override
  List<Object> get props => [employerData];
}

class EmployerPublicProfileFail extends EmployerState {
  final String message;
  const EmployerPublicProfileFail({required this.message});
}
