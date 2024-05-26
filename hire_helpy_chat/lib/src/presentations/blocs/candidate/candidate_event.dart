part of blocs;

abstract class CandidateEvent extends Equatable {
  const CandidateEvent();

  @override
  List<Object> get props => [];
}

class InitializeCandidateEvent extends CandidateEvent {
  @override
  String toString() => "InitializePageEvent";
}

//Candidate Search Create
class CandidateSearchCreateRequested extends CandidateEvent {
  final CandidateSearchCreateRequestParams? params;

  const CandidateSearchCreateRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}


//Candidate Public Profile
class CandidatePublicProfileRequested extends CandidateEvent {
  final CandidatePublicProfileRequestParams? params;

  const CandidatePublicProfileRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}
