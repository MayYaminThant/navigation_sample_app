/*
"data": [
      {
        "user_review_id": 1,
        "by_user_id": 1201,
        "on_user_id": 1001,
        "review": "I hate you. I love you. I hate that, I love you.",
        "review_star_rating": 5,
        "review_creation_datetime": "2023-08-08 16:40:46",
        "review_delete_datetime": null,
        "app_silo_name": "DH_Candidate"
      }
    ],
*/

part of 'entities.dart';

class Review extends Equatable {
  final int? userReviewId;
  final int? byUserId;
  final int? onUserId;
  final String? review;
  final int? reviewStarRating;
  final String? reviewCreationDatetime;
  final String? appSiloName;
  final User? reviewer;

  const Review({
    this.userReviewId,
    this.byUserId,
    this.onUserId,
    this.review,
    this.reviewStarRating,
    this.reviewCreationDatetime,
    this.appSiloName,
    this.reviewer
  });

  @override
  List<Object?> get props => [
        userReviewId,
        byUserId,
        onUserId,
        review,
        reviewStarRating,
        reviewCreationDatetime,
        appSiloName,
        reviewer
      ];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
        "user_review_id": userReviewId,
        "by_user_id": byUserId,
        "on_user_id": onUserId,
        "review": review,
        "review_star_rating": reviewStarRating,
        "review_creation_datetime": reviewCreationDatetime,
        "app_silo_name": appSiloName,
        "reviewer": reviewer
      };
}
