part of blocs;

abstract class EmployerEvent extends Equatable {
  const EmployerEvent();

  @override
  List<Object> get props => [];
}

class InitializeEmployerEvent extends EmployerEvent {
  @override
  String toString() => "InitializePageEvent";
}

//Employer Search Create
class EmployerSearchCreateRequested extends EmployerEvent {
  final EmployerSearchCreateRequestParams? params;

  const EmployerSearchCreateRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Employer Public Profile
class EmployerPublicProfileRequested extends EmployerEvent {
  final EmployerPublicProfileRequestParams? params;

  const EmployerPublicProfileRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}
