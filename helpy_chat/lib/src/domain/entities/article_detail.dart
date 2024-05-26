part of 'entities.dart';

class ArticleDetail extends Equatable {
  final int? articleId;
  final int? userId;
  final String? title;
  final String? content;
  final String? appSiloName;
  final String? category;
  final String? articleLanguage;
  int? downvote;
  int? upvote;
  final String? createdAt;
  final String? updatedAt;
  final int? viewDayCount;
  final int? viewTotalCount;
  final int? commentCount;
  final List<MediaFile>? media;
  final List<Comment>? comments;
  final ArticleCreator? creator;

  ArticleDetail({
    this.articleId,
    this.userId,
    this.title,
    this.content,
    this.appSiloName,
    this.category,
    this.articleLanguage,
    this.downvote,
    this.upvote,
    this.createdAt,
    this.updatedAt,
    this.viewDayCount,
    this.viewTotalCount,
    this.commentCount,
    this.media,
    this.comments,
    this.creator
  });

  @override
  List<Object?> get props => [
        articleId,
        userId,
        title,
        content,
        appSiloName,
        category,
        articleLanguage,
        downvote,
        upvote,
        createdAt,
        updatedAt,
        viewDayCount,
        viewTotalCount,
        commentCount,
      ];

  @override
  bool get stringify => true;
  
    Map<String, dynamic> toJson() => {
        "article_id": articleId,
        "user_id": userId,
        "title": title,
        "content": content,
        "article_creation_datetime": createdAt,
        "article_update_datetime": updatedAt,
        "up_vote_count": upvote,
        "down_vote_count": downvote,
        "view_day_count": viewDayCount,
        "view_total_count": viewTotalCount,
        "comment_count": commentCount,
        "category": category,
        "article_language": articleLanguage,
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
        "creator": creator?.toJson(),
      };
}
