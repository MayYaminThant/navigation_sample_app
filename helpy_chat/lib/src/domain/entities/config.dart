part of 'entities.dart';

class Config extends Equatable {
  final String? name;
  final String? value;

  const Config({this.name, this.value});

  @override
  List<Object?> get props => [name, value];

  @override
  bool get stringify => true;
}
