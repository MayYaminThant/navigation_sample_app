// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommentArticle {
  List<Comment>? data;
  String? message;

  CommentArticle({this.data, this.message});

  CommentArticle.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Comment>[];
      json['data'].forEach((v) {
        data!.add(Comment.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Comment {
  int? id;
  int? userId;
  int? articleId;
  String? articleComment;
  String? articleCommentChildId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Commenter? commenter;
  List<Replies>? replies;

  Comment({
    this.id,
    this.userId,
    this.articleId,
    this.articleComment,
    this.articleCommentChildId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.commenter,
    this.replies,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['article_comment_id'];
    userId = json['user_id'];
    articleId = json['article_id'];
    articleComment = json['article_comment'];
    articleCommentChildId = json['article_comment_child_id'];
    createdAt = json['article_comment_creation_datetime'];
    updatedAt = json['article_comment_update_datetime'];
    deletedAt = json['article_comment_delete_datetime'];
    commenter = json['commenter'] != null
        ? Commenter.fromJson(json['commenter'])
        : null;
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
  }
  @override
  String toString() {
    return 'Comment{id: $id, userId: $userId, articleId: $articleId, articleComment: $articleComment, articleCommentChildId: $articleCommentChildId, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, commenter: $commenter, replies: $replies}';
  }
}

class Commenter {
  int? userId;

  String? firstName;
  String? lastName;
  String? avatar;

  Commenter({
    this.userId,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  Commenter.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar_s3_filepath'];
  }
}

class Replies {
  int? commenterId;
  int? userId;
  String? commenterType;
  String? commentableType;
  String? commentableId;
  String? comment;
  int? childId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Commenter? commenter;
  List<Replies>? replies;
  int? parentCommentId;

  Replies(
    this.commenterId, {
    this.userId,
    this.commenterType,
    this.commentableType,
    this.commentableId,
    this.comment,
    this.childId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.commenter,
    this.replies,
    this.parentCommentId,
  });

  Replies.fromJson(Map<String, dynamic> json) {
    commenterId = json['article_comment_id'];
    userId = json['user_id'];
    commenterType = json['commenter_type'];
    commentableType = json['commentable_type'];
    commentableId = json['commentable_id'];
    comment = json['article_comment'];
    childId = json['child_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    commenter = json['commenter'] != null
        ? Commenter.fromJson(json['commenter'])
        : null;
    if (json['replies'] != null) {
      replies = List<Replies>.from(
          json['replies'].map((replyJson) => Replies.fromJson(replyJson)));
    } else {
      replies = [];
    }
    parentCommentId = json['article_comment_child_id'];
  }

  Replies copyWith({
    int? commenterId,
    int? userId,
    String? commenterType,
    String? commentableType,
    String? commentableId,
    String? comment,
    int? childId,
    String? deletedAt,
    String? createdAt,
    String? updatedAt,
    Commenter? commenter,
    List<Replies>? replies,
    int? parentCommentId,
  }) {
    return Replies(
      commenterId ?? this.commenterId,
      userId: userId ?? this.userId,
      commenterType: commenterType ?? this.commenterType,
      commentableType: commentableType ?? this.commentableType,
      commentableId: commentableId ?? this.commentableId,
      comment: comment ?? this.comment,
      childId: childId ?? this.childId,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      commenter: commenter ?? this.commenter,
      replies: replies ?? this.replies,
      parentCommentId: parentCommentId ?? this.parentCommentId,
    );
  }

  @override
  String toString() {
    return 'Replies{commenterId: $commenterId, userId: $userId, commenterType: $commenterType, commentableType: $commentableType, commentableId: $commentableId, comment: $comment, childId: $childId, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt, commenter: $commenter, replies: $replies, parentCommentId: $parentCommentId}';
  }
}
