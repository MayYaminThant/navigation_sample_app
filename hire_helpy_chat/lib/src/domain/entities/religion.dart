part of 'entities.dart';

class Religion extends Equatable {
  final String? religion;
  final String? religionDesc;

  const Religion({this.religion, this.religionDesc});

  @override
  List<Object?> get props => [religion, religionDesc];

  @override
  bool get stringify => true;
}
