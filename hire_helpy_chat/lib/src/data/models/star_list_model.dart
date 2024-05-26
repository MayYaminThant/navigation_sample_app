part of 'models.dart';

class StarListModel extends StarList {
  const StarListModel({
    int? id,
    int? ofUserId,
    int? onUserId,
    String? starAddDateTime,
    int? starDisplayOrder,
    Candidate? candidate,
  }) : super(
    id: id,
    ofUserId: ofUserId,
    onUserId: onUserId,
    starAddDateTime: starAddDateTime,
    starDisplayOrder: starDisplayOrder,
    candidate: candidate
);

  factory StarListModel.fromJson(Map<dynamic, dynamic> map) {
    return StarListModel(
      id: map['star_id'] != null ? map['star_id'] as int: null,
      ofUserId: map['of_user_id'] != null ? map['of_user_id'] as int: null,
      onUserId: map['on_user_id'] != null ? map['on_user_id'] as int: null,
      starAddDateTime: map['star_add_datetime'] != null ? map['star_add_datetime'] as String: null,
      starDisplayOrder: map['star_display_order'] != null ? map['star_display_order'] as int: null,
      candidate: map['candidate'] != null ? CandidateModel.fromJson(map['candidate']) : null,
    );
  }

}
