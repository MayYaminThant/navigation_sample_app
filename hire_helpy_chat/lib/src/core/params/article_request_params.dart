part of 'params.dart';

//Articles
class ArticlesListRequestParams {
  final String? language;
  final String? sortBy;
  final int page;
  final String? token;

  ArticlesListRequestParams(
      {this.language, this.sortBy, required this.page, this.token});
}

//Article Create
class ArticlesCreateRequestParams {
  final String? token;
  final String? title;
  final List<File>? images;
  final String? content;
  final String? language;

  ArticlesCreateRequestParams(
      {this.token, this.title, this.images, this.content, this.language});
}

class ArticlesUploadFileRequestParams {
  final String? token;
  final File? image;

  ArticlesUploadFileRequestParams({
    this.token,
    this.image,
  });
}

class ArticlesCommentListRequestParams {
  final String? token;
  final int? articleId;
  final int? page;

  ArticlesCommentListRequestParams({
    this.token,
    this.articleId,
    this.page,
  });
}

class ArticlesCreateCommentCommentRequestParams {
  final String? token;
  final String? articleId;
  final String? message;
  final int? userId;

  ArticlesCreateCommentCommentRequestParams(
      {this.token, this.articleId, this.message, this.userId});
}

class ArticlesUpDateCommentRequestParams {
  final String? token;
  final int commentId;
  final String? messageUpdate;

  ArticlesUpDateCommentRequestParams(
      {this.token, required this.commentId, this.messageUpdate});
}

class ArticlesReplyCommentRequestParams {
  final String? token;
  final int commentId;
  final String? replyMessage;
  final int? userId;

  ArticlesReplyCommentRequestParams(
      {this.token,
      required this.commentId,
      required this.replyMessage,
      this.userId});
}

class ArticlesDeleteCommentRequestParams {
  final String? token;
  final int commentId;

  ArticlesDeleteCommentRequestParams({
    this.token,
    required this.commentId,
  });
}

class ArticlesUpvoteRequestParams {
  final String? token;
  final int? articleId;

  ArticlesUpvoteRequestParams({
    this.token,
    this.articleId,
  });
}

class ArticlesDownvoteRequestParams {
  final String? token;
  final int? articleId;

  ArticlesDownvoteRequestParams({
    this.token,
    this.articleId,
  });
}

class NewsListRequestParams {
  final String? appLocale;
  final int? page;

  NewsListRequestParams({this.appLocale, this.page});
}

class NewsDetailRequestParams {
  final int? newsId;

  NewsDetailRequestParams({
    this.newsId,
  });
}

//Article Create Complain
class ArticleCreateComplainRequestParams {
  final String? token;
  final int? articleId;

  ArticleCreateComplainRequestParams({
    this.token,
    this.articleId,
  });
}

//Comment Create Complain
class ArticleCommentCreateComplainRequestParams {
  final String? token;
  final int? commentId;

  ArticleCommentCreateComplainRequestParams({
    this.token,
    this.commentId,
  });
}

//Article Delete
class ArticleDeleteRequestParams {
  final String? token;
  final int? articleId;

  ArticleDeleteRequestParams({
    this.token,
    this.articleId,
  });
}

//Article Update
class ArticleUpdateRequestParams {
  final String? token;
  final int? articleId;
  final String? title;
  final String? content;
  final String? language;
  final List<File>? images;
  final String? media;

  ArticleUpdateRequestParams({
    this.token,
    this.articleId,
    this.title,
    this.content,
    this.language,
    this.images,
    this.media,
  });
}
