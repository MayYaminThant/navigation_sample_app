part of 'models.dart';

class ReviewModel extends Review {
  const ReviewModel({
    int? userReviewId,
    int? byUserId,
    int? onUserId,
    String? review,
    int? reviewStarRating,
    String? reviewCreationDatetime,
    String? appSiloName,
    User? reviewer,
  }) : super(
    userReviewId: userReviewId,
    byUserId: byUserId,
    onUserId: onUserId,
    review: review,
    reviewStarRating: reviewStarRating,
    reviewCreationDatetime: reviewCreationDatetime,
    appSiloName: appSiloName,
    reviewer: reviewer
    );

  factory ReviewModel.fromJson(Map<dynamic, dynamic> map) {
    return ReviewModel(
      userReviewId: map['user_review_id'] != null ? map['user_review_id'] as int: null,
      byUserId: map['by_user_id'] != null ? map['by_user_id'] as int: null,
      onUserId: map['on_user_id'] != null ? map['on_user_id'] as int: null,
      review: map['review'] != null ? map['review'] as String: null,
      reviewStarRating: map['review_star_rating'] != null ? map['review_star_rating'] as int: null,
      reviewCreationDatetime: map['review_creation_datetime'] != null ? map['review_creation_datetime'] as String: null,
      appSiloName: map['app_silo_name'] != null? map['app_silo_name'] as String: null,
      reviewer: map['reviewer'] != null? UserModel.fromJson(map['reviewer']): null
    );
  }
}
