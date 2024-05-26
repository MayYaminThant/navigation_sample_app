part of 'models.dart';

class NewsDetailModel extends NewsDetail {
   const NewsDetailModel({
    final int? newsId,
    final String? title,
    final String? content,
    final String? appLocale,
    final String? category,
    int? downvote,
    int? upvote,
    final String? createdAt,
    final String? updatedAt,
    final String? newsExpirationDatetime,
    final int? viewDayCount,
    final int? viewTotalCount,
    final int? commentCount,
    final List<MediaFile>? media,
    }) : super(
          newsId: newsId,
          title: title,
          content: content,
          appLocale: appLocale,
          category: category,
          downvote: downvote,
          upvote: upvote,
          createdAt: createdAt,
          updatedAt: updatedAt,
          newsExpirationDatetime: newsExpirationDatetime,
          viewDayCount: viewDayCount,
          viewTotalCount: viewTotalCount,
          commentCount: commentCount,
          media: media,
        );

  
  factory NewsDetailModel.fromJson(Map<String, dynamic> json) {
    return NewsDetailModel(
      newsId: json['news_id'],
      title: json['title'],
      content: json['content'],
      appLocale: json['app_locale'],
      category: json['category'],
      downvote: json['down_vote_count'],
      upvote: json['up_vote_count'],
      createdAt: json['news_creation_datetime'],
      updatedAt: json['news_update_datetime'],
      newsExpirationDatetime: json['news_expiration_datetime'],
      viewDayCount: json['view_day_count'],
      viewTotalCount: json['view_total_count'],
      commentCount: json['comment_count'],
      media: json['media'] != null ? List<MediaFile>.from((json['media'] as List<dynamic>).map((e) => MediaFileModel.fromJson(e as Map<String, dynamic>))) : null,
    );
  }

}
