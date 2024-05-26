part of blocs;

abstract class AdsState extends Equatable {
  const AdsState();

  @override
  List<Object> get props => [];
}

class AdsInitialState extends AdsState {
  @override
  String toString() => "InitializePageState";
}

//Adss 
class AdsListLoading extends AdsState {}

class AdsListSuccess extends AdsState {
  final DataResponseModel data;

  const AdsListSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class AdsListFail extends AdsState {
  final String message;
  const AdsListFail({required this.message});
}

//Fade Ads 
class AdsFadeListLoading extends AdsState {}

class AdsFadeListSuccess extends AdsState {
  final DataResponseModel data;

  const AdsFadeListSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class AdsFadeListFail extends AdsState {
  final String message;
  const AdsFadeListFail({required this.message});
}

