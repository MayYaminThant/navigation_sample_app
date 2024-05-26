part of 'entities.dart';

class NewsDetail extends Equatable {
  final int? newsId;
  final String? title;
  final String? content;
  final String? appLocale;
  final String? category;
  final int? downvote;
  final int? upvote;
  final String? createdAt;
  final String? updatedAt;
  final String? newsExpirationDatetime;
  final int? viewDayCount;
  final int? viewTotalCount;
  final int? commentCount;
  final List<MediaFile>? media;

  const NewsDetail({
    this.newsId,
    this.title,
    this.content,
    this.appLocale,
    this.category,
    this.downvote,
    this.upvote,
    this.createdAt,
    this.updatedAt,
    this.newsExpirationDatetime,
    this.viewDayCount,
    this.viewTotalCount,
    this.commentCount,
    this.media,
  });

  @override
  List<Object?> get props => [
        newsId,
        title,
        content,
        appLocale,
        category,
        downvote,
        upvote,
        createdAt,
        updatedAt,
        newsExpirationDatetime,
        viewDayCount,
        viewTotalCount,
        commentCount,
      ];

  @override
  bool get stringify => true;
}
