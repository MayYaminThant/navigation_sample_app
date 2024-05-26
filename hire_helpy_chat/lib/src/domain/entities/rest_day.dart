part of 'entities.dart';

class RestDay extends Equatable {
  final String? label;
  final int? value;

  const RestDay({this.label, this.value});

  @override
  List<Object?> get props => [label, value];

  @override
  bool get stringify => true;
}
