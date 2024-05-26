part of 'models.dart';

class LanguageModel extends Language {
  const LanguageModel({
    int? id,
    String? language,
    String? desc,
  }) : super(
    id: id,
    language: language,
    desc: desc
        );

  factory LanguageModel.fromJson(Map<dynamic, dynamic> map) {
    return LanguageModel(
      id: map['language_type_id'] != null ? map['language_type_id'] as int: null,
      language: map['language'] != null ? map['language'] as String: null,
      desc: map['desc'] != null ? map['desc'] as String: null,
    );
  }

}
