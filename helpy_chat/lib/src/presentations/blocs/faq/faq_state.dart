part of blocs;

//Faq
abstract class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}

class FaqInitialState extends FaqState {
  @override
  String toString() => "InitializePageState";
}

class FaqsLoading extends FaqState {}

class FaqsSuccess extends FaqState {
  final DataResponseModel faqData;

  const FaqsSuccess({required this.faqData});

  @override
  List<Object> get props => [faqData];
}

class FaqsFail extends FaqState {
  final String message;
  const FaqsFail({required this.message});
}
