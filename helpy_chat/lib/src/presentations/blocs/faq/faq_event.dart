part of blocs;

//Faq
abstract class FaqEvent extends Equatable {
  const FaqEvent();

  @override
  List<Object> get props => [];
}

class InitializeFaqEvent extends FaqEvent {
  @override
  String toString() => "InitializePageEvent";
}

//Faq Lists
class FaqsRequested extends FaqEvent {
  final FaqRequestParams? params;

  const FaqsRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

class FaqsSearchRequested extends FaqEvent {
  final FaqRequestParams? params;

  const FaqsSearchRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}
