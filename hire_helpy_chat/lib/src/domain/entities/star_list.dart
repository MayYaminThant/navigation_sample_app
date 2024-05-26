/*
{star_id: 194, of_user_id: 201, on_user_id: 83, star_add_datetime: 2023-08-05T00:27:20.000000Z, star_display_order: 1, employer: 
*/

part of 'entities.dart';

class StarList extends Equatable {
  final int? id;
  final int? ofUserId;
  final int? onUserId;
  final String? starAddDateTime;
  final int? starDisplayOrder;
  final Candidate? candidate;

  const StarList({this.id, this.ofUserId, this.onUserId, this.starAddDateTime, this.starDisplayOrder, this.candidate});

  @override
  List<Object?> get props => [id, ofUserId, onUserId, starAddDateTime, starDisplayOrder, candidate];

  @override
  bool get stringify => true;
}
