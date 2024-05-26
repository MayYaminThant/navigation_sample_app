part of blocs;

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitialState extends ArticleState {
  @override
  String toString() => "InitializePageState";
}

//Article Lists
class ArticlesListLoading extends ArticleState {}

class ArticlesListSuccess extends ArticleState {
  final DataResponseModel articleData;

  const ArticlesListSuccess({required this.articleData});

  @override
  List<Object> get props => [articleData];
}

class ArticlesListFail extends ArticleState {
  final String message;
  const ArticlesListFail({required this.message});
}

//Article Create
class ArticlesCreateLoading extends ArticleState {}

class ArticlesCreateSuccess extends ArticleState {
  final DataResponseModel articleData;

  const ArticlesCreateSuccess({required this.articleData});

  @override
  List<Object> get props => [articleData];
}

class ArticlesCreateFail extends ArticleState {
  final String message;
  const ArticlesCreateFail({required this.message});
}

//Article Get Comment List
class ArticlesGetCommentListLoading extends ArticleState {}

class ArticlesGetCommentListSuccess extends ArticleState {
  final DataResponseModel articleData;

  const ArticlesGetCommentListSuccess({required this.articleData});

  @override
  List<Object> get props => [articleData];
}

class ArticlesGetCommentListFail extends ArticleState {
  final String message;
  const ArticlesGetCommentListFail({required this.message});
}

//Article Create Comment Comment
class ArticlesCreateCommentLoading extends ArticleState {}

class ArticlesCreateCommentSuccess extends ArticleState {
  final DataResponseModel articleData;

  const ArticlesCreateCommentSuccess({required this.articleData});

  @override
  List<Object> get props => [articleData];
}

class ArticlesCreateCommentFail extends ArticleState {
  final String message;
  const ArticlesCreateCommentFail({required this.message});
}

//Article Update Comment
class ArticlesUpdateCommentLoading extends ArticleState {}

class ArticlesUpdateCommentSuccess extends ArticleState {
  final DataResponseModel articleData;

  const ArticlesUpdateCommentSuccess({required this.articleData});

  @override
  List<Object> get props => [articleData];
}

class ArticlesUpdateCommentFail extends ArticleState {
  final String message;
  const ArticlesUpdateCommentFail({required this.message});
}

//Article Reply Comment
class ArticlesReplyCommentLoading extends ArticleState {}

class ArticlesReplyCommentSuccess extends ArticleState {
  final DataResponseModel articleData;

  const ArticlesReplyCommentSuccess({required this.articleData});

  @override
  List<Object> get props => [articleData];
}

class ArticlesReplyCommentFail extends ArticleState {
  final String message;
  const ArticlesReplyCommentFail({required this.message});
}

//Article Delete Comment
class ArticlesDeleteCommentLoading extends ArticleState {}

class ArticlesDeleteCommentSuccess extends ArticleState {
  final DataResponseModel articleData;

  const ArticlesDeleteCommentSuccess({required this.articleData});

  @override
  List<Object> get props => [articleData];
}

class ArticlesDeleteCommentFail extends ArticleState {
  final String message;
  const ArticlesDeleteCommentFail({required this.message});
}

//Article Create Upvote
class ArticlesCreateUpvoteLoading extends ArticleState {}

class ArticlesCreateUpvoteSuccess extends ArticleState {
  final DataResponseModel upVoteDate;

  const ArticlesCreateUpvoteSuccess({required this.upVoteDate});

  @override
  List<Object> get props => [upVoteDate];
}

class ArticlesCreateUpvoteFail extends ArticleState {
  final String message;
  const ArticlesCreateUpvoteFail({required this.message});
}

//Article Create Downvote
class ArticlesCreateDownvoteLoading extends ArticleState {}

class ArticlesCreateDownvoteSuccess extends ArticleState {
  final DataResponseModel downVoteData;

  const ArticlesCreateDownvoteSuccess({required this.downVoteData});

  @override
  List<Object> get props => [downVoteData];
}

class ArticlesCreateDownvoteFail extends ArticleState {
  final String message;
  const ArticlesCreateDownvoteFail({required this.message});
}

//News Lists
class NewsListLoading extends ArticleState {}

class NewsListSuccess extends ArticleState {
  final DataResponseModel newsData;

  const NewsListSuccess({required this.newsData});

  @override
  List<Object> get props => [newsData];
}

class NewsListFail extends ArticleState {
  final String message;
  const NewsListFail({required this.message});
}

//Article Create Complain
class ArticleCreateComplainLoading extends ArticleState {}

class ArticleCreateComplainSuccess extends ArticleState {
  final DataResponseModel newsData;

  const ArticleCreateComplainSuccess({required this.newsData});

  @override
  List<Object> get props => [newsData];
}

class ArticleCreateComplainFail extends ArticleState {
  final String message;
  const ArticleCreateComplainFail({required this.message});
}

//Comment Create Complain
class CommentCreateComplainLoading extends ArticleState {}

class CommentCreateComplainSuccess extends ArticleState {
  final DataResponseModel newsData;

  const CommentCreateComplainSuccess({required this.newsData});

  @override
  List<Object> get props => [newsData];
}

class CommentCreateComplainFail extends ArticleState {
  final String message;
  const CommentCreateComplainFail({required this.message});
}

//Article Detail
class ArticleDetailLoading extends ArticleState {}

class ArticleDetailSuccess extends ArticleState {
  final DataResponseModel articleData;

  const ArticleDetailSuccess({required this.articleData});

  @override
  List<Object> get props => [articleData];
}

class ArticleDetailFail extends ArticleState {
  final String message;
  const ArticleDetailFail({required this.message});
}

//News Detail
class NewsDetailLoading extends ArticleState {}

class NewsDetailSuccess extends ArticleState {
  final DataResponseModel articleData;

  const NewsDetailSuccess({required this.articleData});

  @override
  List<Object> get props => [articleData];
}

class NewsDetailFail extends ArticleState {
  final String message;
  const NewsDetailFail({required this.message});
}


//Article Delete
class ArticleDeleteLoading extends ArticleState {}

class ArticleDeleteSuccess extends ArticleState {
  final DataResponseModel articleData;

  const ArticleDeleteSuccess({required this.articleData});

  @override
  List<Object> get props => [articleData];
}

class ArticleDeleteFail extends ArticleState {
  final String message;
  const ArticleDeleteFail({required this.message});
}

//Article Update
class ArticleUpdateLoading extends ArticleState {}

class ArticleUpdateSuccess extends ArticleState {
  final DataResponseModel articleData;

  const ArticleUpdateSuccess({required this.articleData});

  @override
  List<Object> get props => [articleData];
}

class ArticleUpdateFail extends ArticleState {
  final String message;
  const ArticleUpdateFail({required this.message});
}
