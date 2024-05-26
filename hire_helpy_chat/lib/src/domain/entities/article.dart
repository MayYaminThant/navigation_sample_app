part of 'entities.dart';

class Article extends Equatable {
  final int? articleId;
  final int? userId;
  final String? title;
  final String? content;
  final String? appSiloName;
  final String? category;
  final int? downvote;
  final int? upvote;
  final String? createdAt;
  final String? updatedAt;
  final int? viewDayCount;
  final int? viewTotalCount;
  final int? commentCount;
  final List<MediaFile>? media;

  const Article({
     this.articleId,
     this.userId,
     this.title,
     this.content,
     this.appSiloName,
     this.category,
     this.downvote,
     this.upvote,
     this.createdAt,
     this.updatedAt,
     this.viewDayCount,
     this.viewTotalCount,
     this.commentCount,
     this.media,
  });

  @override
  List<Object?> get props => [
        articleId,
        userId,
        title,
        content,
        appSiloName,
        category,
        downvote,
        upvote,
        createdAt,
        updatedAt,
        viewDayCount,
        viewTotalCount,
        commentCount,
        media,
      ];

  @override
  bool get stringify => true;
}
