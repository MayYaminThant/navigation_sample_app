part of 'models.dart';

class AcademicQualificationModel extends AcademicQualification {
  const AcademicQualificationModel({
    String? qualification,
    String? qualificationDesc,
  }) : super(
    
    qualification: qualification,
qualificationDesc: qualificationDesc
        );

  factory AcademicQualificationModel.fromJson(Map<dynamic, dynamic> map) {
    return AcademicQualificationModel(
      qualification: map['qualification'] != null ? map['qualification'] as String: null,
      qualificationDesc: map['qualification_desc'] != null ? map['qualification_desc'] as String: null,
    );
  }

}
