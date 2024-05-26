part of 'models.dart';

class StarListModel extends StarList {
  const StarListModel({
    int? id,
    int? ofUserId,
    int? onUserId,
    String? starAddDateTime,
    int? starDisplayOrder,
    Employer? employer,
  }) : super(
    id: id,
    ofUserId: ofUserId,
    onUserId: onUserId,
    starAddDateTime: starAddDateTime,
    starDisplayOrder: starDisplayOrder,
    employer: employer
);

  factory StarListModel.fromJson(Map<dynamic, dynamic> map) {
    return StarListModel(
      id: map['star_id'] != null ? map['star_id'] as int: null,
      ofUserId: map['of_user_id'] != null ? map['of_user_id'] as int: null,
      onUserId: map['on_user_id'] != null ? map['on_user_id'] as int: null,
      starAddDateTime: map['star_add_datetime'] != null ? map['star_add_datetime'] as String: null,
      starDisplayOrder: map['star_display_order'] != null ? map['star_display_order'] as int: null,
      employer: map['employer'] != null ? EmployerModel.fromJson(map['employer']) : null,
    );
  }

}
