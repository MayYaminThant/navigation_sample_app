part of 'entities.dart';

class ConfigLanguage extends Equatable {
  final String? languageName;
  final String? language;

  const ConfigLanguage({this.languageName, this.language});

  @override
  List<Object?> get props => [languageName, language];

  @override
  bool get stringify => true;
}
