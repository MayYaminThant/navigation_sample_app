part of 'models.dart';

class FamilyStatusModel extends FamilyStatus {
  const FamilyStatusModel({
    int? id,
    String? familyStatus,
    String? desc,
  }) : super(
    id: id,
    familyStatus: familyStatus,
    desc: desc
        );

  factory FamilyStatusModel.fromJson(Map<dynamic, dynamic> map) {
    return FamilyStatusModel(
      id: map['family_status_type_id'] != null ? map['family_status_type_id'] as int: null,
      familyStatus: map['family_status'] != null ? map['family_status'] as String: null,
      desc: map['desc'] != null ? map['desc'] as String: null,
    );
  }

}
