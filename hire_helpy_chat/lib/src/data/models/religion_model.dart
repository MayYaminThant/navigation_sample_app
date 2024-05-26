part of 'models.dart';

class ReligionModel extends Religion {
  const ReligionModel({
    String? religion,
    String? religionDesc,
  }) : super(
    religion: religion,
    religionDesc: religionDesc
        );

  factory ReligionModel.fromJson(Map<dynamic, dynamic> map) {
    return ReligionModel(
      religion: map['religion'] != null ? map['religion'] as String: null,
      religionDesc: map['religion_desc'] != null ? map['religion_desc'] as String: null,
    );
  }

}
