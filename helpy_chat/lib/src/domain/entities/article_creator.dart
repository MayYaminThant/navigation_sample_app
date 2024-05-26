import 'dart:convert';

class ArticleCreator {
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? avatarFilepath;

  ArticleCreator(
      {this.userId, this.firstName, this.lastName, this.avatarFilepath});

  factory ArticleCreator.fromJson(Map<String, dynamic> json) {
    return ArticleCreator(
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatarFilepath: json['avatar_s3_filepath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleCreator.fromMap(Map<String, dynamic> json) =>
      ArticleCreator(
          userId: json["user_id"],
          firstName: json["first_name"],
          lastName: json["last_name"],
          avatarFilepath: json["avatar_s3_filepath"]);

  Map<String, dynamic> toMap() =>
      {
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "avatar_s3_filepath": avatarFilepath,
      };
}