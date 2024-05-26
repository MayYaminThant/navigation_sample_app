part of 'entities.dart';

class Language extends Equatable {
  final int? id;
  final String? language;
  final String? desc;

  const Language({this.id, this.language, this.desc});

  @override
  List<Object?> get props => [id, language, desc];

  @override
  bool get stringify => true;
}
