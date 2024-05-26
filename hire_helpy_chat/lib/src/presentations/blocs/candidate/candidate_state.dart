part of blocs;

abstract class CandidateState extends Equatable {
  const CandidateState();

  @override
  List<Object> get props => [];
}

class CandidateInitialState extends CandidateState {
  @override
  String toString() => "InitializePageState";
}


//Candidate Search Create
class CandidateSearchCreateLoading extends CandidateState {}

class CandidateSearchCreateSuccess extends CandidateState {
  final DataResponseModel candidateData;

  const CandidateSearchCreateSuccess({required this.candidateData});

  @override
  List<Object> get props => [candidateData];
}

class CandidateSearchCreateFail extends CandidateState {
  final String message;
  const CandidateSearchCreateFail({required this.message});
}

//Candidate Public Profile
class CandidatePublicProfileLoading extends CandidateState {}

class CandidatePublicProfileSuccess extends CandidateState {
  final DataResponseModel candidateData;

  const CandidatePublicProfileSuccess({required this.candidateData});

  @override
  List<Object> get props => [candidateData];
}

class CandidatePublicProfileFail extends CandidateState {
  final String message;
  const CandidatePublicProfileFail({required this.message});
}
