part of 'models.dart';

class WorkPermitModel extends WorkPermit {
  const WorkPermitModel({
    int? id,
    int? userId,
    String? expiryDate
  }) : super(
    id: id,
    userId: userId,
    expiryDate: expiryDate
        );

  factory WorkPermitModel.fromJson(Map<dynamic, dynamic> map) {
    return WorkPermitModel(
      id: map['candidate_work_permit_id'] != null ? map['candidate_work_permit_id'] as int: null,
      userId: map['user_id'] != null ? map['user_id'] as int: null,
      expiryDate: map['work_permit_expiry_datetime'] != null ? map['work_permit_expiry_datetime'] as String: null,
    );
  }

}
