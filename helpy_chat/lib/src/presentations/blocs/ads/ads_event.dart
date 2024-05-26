part of blocs;

abstract class AdsEvent extends Equatable {
  const AdsEvent();

  @override
  List<Object> get props => [];
}

class InitializeAdsEvent extends AdsEvent {
  @override
  String toString() => "InitializePageEvent";
}

//Request Ads
class CandidateAdsListRequested extends AdsEvent {
  final AdsListRequestParams? params;
  
  const CandidateAdsListRequested({this.params});

  @override
  List<Object> get props => [];
}

//Request Fade Ads
class CandidateFadeAdsListRequested extends AdsEvent {
  final AdsListRequestParams? params;
  
  const CandidateFadeAdsListRequested({this.params});

  @override
  List<Object> get props => [];
}

//Request Fade Ads
class CandidateCountRequested extends AdsEvent {
  final AdsCountRequestParams? params;
  
  const CandidateCountRequested({this.params});

  @override
  List<Object> get props => [];
}
