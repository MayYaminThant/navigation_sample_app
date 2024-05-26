import 'dart:convert';

import 'package:intl/intl.dart';

class ArticleModel {
  final Data? data;
  final String? message;

  ArticleModel({
    this.data,
    this.message,
  });

  factory ArticleModel.fromJson(String str) =>
      ArticleModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArticleModel.fromMap(Map<String, dynamic> json) => ArticleModel(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
  final int? currentPage;
  final List<Datum>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class ArticleCreator {
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? avatarFilepath;

  ArticleCreator(
      {this.userId, this.firstName, this.lastName, this.avatarFilepath});

  factory ArticleCreator.fromJson(String str) =>
      ArticleCreator.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArticleCreator.fromMap(Map<String, dynamic> json) => ArticleCreator(
      userId: json["user_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      avatarFilepath: json["avatar_s3_filepath"]);

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "avatar_s3_filepath": avatarFilepath,
      };
}

class Datum {
  final int? articleId;
  final int? userId;
  final String? title;
  final String? content;
  final String? articleCreationDatetime;
  final String? articleUpdateDatetime;
  final int? upVoteCount;
  final int? downVoteCount;
  final int? viewDayCount;
  final int? viewTotalCount;
  final int? commentCount;
  final String? category;
  final String? articleLanguage;
  final List<Media>? media;
  final ArticleCreator? creator;

  Datum(
      {this.articleId,
      this.userId,
      this.title,
      this.content,
      this.articleCreationDatetime,
      this.articleUpdateDatetime,
      this.upVoteCount,
      this.downVoteCount,
      this.viewDayCount,
      this.viewTotalCount,
      this.commentCount,
      this.category,
      this.articleLanguage,
      this.media,
      this.creator});

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
      articleId: json["article_id"],
      userId: json["user_id"],
      title: json["title"],
      content: json["content"],
      articleCreationDatetime: json["article_creation_datetime"] == null
          ? null
          : DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(json["article_creation_datetime"])),
      articleUpdateDatetime: json["article_update_datetime"] == null
          ? null
          : DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(json["article_update_datetime"])),
      upVoteCount: json["up_vote_count"],
      downVoteCount: json["down_vote_count"],
      viewDayCount: json["view_day_count"],
      viewTotalCount: json["view_total_count"],
      commentCount: json["comment_count"],
      category: json["category"],
      articleLanguage: json["article_language"],
      media: json["media"] == null
          ? []
          : List<Media>.from(json["media"]!.map((x) => Media.fromMap(x))),
      creator: json["creator"] == null
          ? null
          : ArticleCreator.fromMap(json["creator"]));

  Map<String, dynamic> toMap() => {
        "article_id": articleId,
        "user_id": userId,
        "title": title,
        "content": content,
        "article_creation_datetime": articleCreationDatetime,
        "article_update_datetime": articleUpdateDatetime,
        "up_vote_count": upVoteCount,
        "down_vote_count": downVoteCount,
        "view_day_count": viewDayCount,
        "view_total_count": viewTotalCount,
        "comment_count": commentCount,
        "category": category,
        "article_language": articleLanguage,
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toMap())),
        "creator": creator == null ? null : creator!.toMap()
      };
}

class Media {
  final int? mediaId;
  final int? articleId;
  final String? mediaType;
  final String? mediaFilepath;
  final String? mediaThumbnailFilepath;
  final int? mediaDisplayOrder;
  final DateTime? mediaCreationDatetime;

  Media({
    this.mediaId,
    this.articleId,
    this.mediaType,
    this.mediaFilepath,
    this.mediaThumbnailFilepath,
    this.mediaDisplayOrder,
    this.mediaCreationDatetime,
  });

  factory Media.fromJson(String str) => Media.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Media.fromMap(Map<String, dynamic> json) => Media(
        mediaId: json["media_id"],
        articleId: json["article_id"],
        mediaType: json["media_type"],
        mediaFilepath: json["media_filepath"],
        mediaThumbnailFilepath: json["media_thumbnail_filepath"],
        mediaDisplayOrder: json["media_display_order"],
        mediaCreationDatetime: json["media_creation_datetime"] == null
            ? null
            : DateTime.parse(json["media_creation_datetime"]),
      );

  Map<String, dynamic> toMap() => {
        "media_id": mediaId,
        "article_id": articleId,
        "media_type": mediaType,
        "media_filepath": mediaFilepath,
        "media_thumbnail_filepath": mediaThumbnailFilepath,
        "media_display_order": mediaDisplayOrder,
        "media_creation_datetime": mediaCreationDatetime?.toIso8601String(),
      };
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
