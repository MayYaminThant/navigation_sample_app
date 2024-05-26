part of 'models.dart';

class ArticleDetailModel extends ArticleDetail {
  ArticleDetailModel(
      {final int? articleId,
      final int? userId,
      final String? title,
      final String? content,
      final String? appSiloName,
      final String? category,
      final String? articleLanguage,
      int? downvote,
      int? upvote,
      final String? createdAt,
      final String? updatedAt,
      final int? viewDayCount,
      final int? viewTotalCount,
      final int? commentCount,
      final List<MediaFile>? media,
      final List<Comment>? comments,
      final ArticleCreator? creator})
      : super(
            articleId: articleId,
            userId: userId,
            title: title,
            content: content,
            appSiloName: appSiloName,
            category: category,
            articleLanguage: articleLanguage,
            downvote: downvote,
            upvote: upvote,
            createdAt: createdAt,
            updatedAt: updatedAt,
            viewDayCount: viewDayCount,
            viewTotalCount: viewTotalCount,
            commentCount: commentCount,
            media: media,
            comments: comments,
            creator: creator);

  factory ArticleDetailModel.fromJson(Map<String, dynamic> json) {
    return ArticleDetailModel(
      articleId: json['article_id'],
      userId: json['user_id'],
      title: json['title'],
      content: json['content'],
      appSiloName: json['app_silo_name'],
      category: json['category'],
      articleLanguage: json['article_language'],
      downvote: json['down_vote_count'],
      upvote: json['up_vote_count'],
      createdAt: json['article_creation_datetime'],
      updatedAt: json['article_update_datetime'],
      viewDayCount: json['view_day_count'],
      viewTotalCount: json['view_total_count'],
      commentCount: json['comment_count'],
      media: json['media'] != null
          ? List<MediaFile>.from((json['media'] as List<dynamic>)
              .map((e) => MediaFileModel.fromJson(e as Map<String, dynamic>)))
          : null,
      comments: json['comments'] != null
          ? List<Comment>.from((json['comments'] as List<dynamic>)
              .map((e) => Comment.fromJson(e as Map<String, dynamic>)))
          : null,
      creator: json['creator'] != null
          ? ArticleCreator.fromJson(json['creator'] as Map<String, dynamic>)
          : null,
    );
  }
}
