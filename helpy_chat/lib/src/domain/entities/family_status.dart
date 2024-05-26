part of 'entities.dart';

class FamilyStatus extends Equatable {
  final int? id;
  final String? familyStatus;
  final String? desc;

  const FamilyStatus({this.id, this.familyStatus, this.desc});

  @override
  List<Object?> get props => [id, familyStatus, desc];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
        "family_status_type_id": id,
        "family_status": familyStatus,
        "desc": desc
      };
}
