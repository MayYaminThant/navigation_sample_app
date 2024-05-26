part of 'entities.dart';

// ignore: must_be_immutable
class Employment extends Equatable {
  final int? id;
  final int? candidateId;
  final String? countryName;
  final String? startDate;
  final String? endDate;
  final String? desc;
  final bool? dhRelated;

  const Employment({this.id, this.candidateId, this.countryName, this.startDate, this.endDate, this.desc, this.dhRelated,});

  @override
  List<Object?> get props => [id, candidateId, countryName, startDate, endDate, desc, dhRelated];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
        "employment_history_id": id,
        "user_id": candidateId,
        "work_country_name": countryName,
        "employment_start_date": startDate,
        "employment_end_date": endDate,
        "work_desc": desc,
        "dh_related": dhRelated,
      };

}
