part of 'models.dart';

class ConfigLanguageModel extends ConfigLanguage {
  const ConfigLanguageModel({
    String? languageName,
    String? language,
  }) : super(
    language: language,
    languageName: languageName
        );

  factory ConfigLanguageModel.fromJson(Map<dynamic, dynamic> map) {
    return ConfigLanguageModel(
      language: map['language'] != null ? map['language'] as String: null,
      languageName: map['language_name'] != null ? map['language_name'] as String: null,
    );
  }

}
