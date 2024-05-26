part of 'models.dart';

class EmploymentModel extends Employment {
  const EmploymentModel({
    int? id,
    int? candidateId,
    String? countryName,
    String? startDate,
    String? endDate,
    String? desc,
    bool? dhRelated,
  }) : super(
          id: id,
          candidateId: candidateId,
          countryName: countryName,
          startDate: startDate,
          endDate: endDate,
          desc: desc,
          dhRelated: dhRelated
        );

  factory EmploymentModel.fromJson(Map<dynamic, dynamic> map) {
    return EmploymentModel(
      id:
          map['employment_history_id'] != null ? map['employment_history_id'] as int : null,
      candidateId: map['user_id'] != null ? map['user_id'] as int: null,
      countryName: map['work_country_name'] != null ? map['work_country_name'] as String: null,
      startDate: map['employment_start_date'] != null ? map['employment_start_date'] as String: null,
      endDate: map['employment_end_date'] != null ? map['employment_end_date'] as String: null,
      desc: map['work_desc'] != null ? map['work_desc'] as String: null,
      dhRelated: map['dh_related'] != null ? map['dh_related'] as bool: false,
    );
  }

}
