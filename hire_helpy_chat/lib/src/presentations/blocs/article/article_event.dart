part of blocs;

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class InitializeArticleEvent extends ArticleEvent {
  @override
  String toString() => "InitializePageEvent";
}

//Article Lists
class ArticlesListRequested extends ArticleEvent {
  final ArticlesListRequestParams? params;

  const ArticlesListRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Article Create
class ArticlesCreateRequested extends ArticleEvent {
  final ArticlesCreateRequestParams? params;

  const ArticlesCreateRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Article Get Comment List
class ArticlesGetCommentRequested extends ArticleEvent {
  final ArticlesCommentListRequestParams? params;

  const ArticlesGetCommentRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Article Create Comment
class ArticlesCreateCommentCommentRequested extends ArticleEvent {
  final ArticlesCreateCommentCommentRequestParams? params;

  const ArticlesCreateCommentCommentRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Article Update Comment
class ArticlesUpdateCommentRequested extends ArticleEvent {
  final ArticlesUpDateCommentRequestParams? params;

  const ArticlesUpdateCommentRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Article Reply Comment
class ArticlesReplyCommentRequested extends ArticleEvent {
  final ArticlesReplyCommentRequestParams? params;

  const ArticlesReplyCommentRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Article Delete Comment
class ArticlesDeleteCommentRequested extends ArticleEvent {
  final ArticlesDeleteCommentRequestParams? params;

  const ArticlesDeleteCommentRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Article Create Upvote article
class ArticlesCreateUpvoteRequested extends ArticleEvent {
  final ArticlesUpvoteRequestParams? params;

  const ArticlesCreateUpvoteRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Article Create Downvote article
class ArticlesCreateDownvoteRequested extends ArticleEvent {
  final ArticlesDownvoteRequestParams? params;

  const ArticlesCreateDownvoteRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Article Lists
class NewsListRequested extends ArticleEvent {
  final NewsListRequestParams? params;

  const NewsListRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}


//Article Create Complain
class ArticleCreateComplainRequested extends ArticleEvent {
  final ArticleCreateComplainRequestParams? params;

  const ArticleCreateComplainRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Comment Create Complain
class CommentCreateComplainRequested extends ArticleEvent {
  final ArticleCommentCreateComplainRequestParams? params;

  const CommentCreateComplainRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Article Delete
class ArticleDeleteRequested extends ArticleEvent {
  final ArticleDeleteRequestParams? params;

  const ArticleDeleteRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//Article Update
class ArticleUpdateRequested extends ArticleEvent {
  final ArticleUpdateRequestParams? params;

  const ArticleUpdateRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}



//Article Detail
class ArticlesDetailRequested extends ArticleEvent {
  final ArticlesCommentListRequestParams? params;

  const ArticlesDetailRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}

//New Detail
class NewsDetailRequested extends ArticleEvent {
  final NewsDetailRequestParams? params;

  const NewsDetailRequested({
    this.params,
  });

  @override
  List<Object> get props => [
        params!,
      ];
}