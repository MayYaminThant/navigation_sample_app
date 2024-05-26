part of 'models.dart';

class RestDayModel extends RestDay {
  const RestDayModel({
    int? restDayChoice,
    String? desc,
  }) : super(
    value: restDayChoice,
    label: desc
    );

  factory RestDayModel.fromJson(Map<dynamic, dynamic> map) {
    return RestDayModel(
      restDayChoice: map['rest_day_per_month_choice'] != null ? map['rest_day_per_month_choice'] as int: null,
      desc: map['desc'] != null ? map['desc'] as String: null,
    );
  }
}
