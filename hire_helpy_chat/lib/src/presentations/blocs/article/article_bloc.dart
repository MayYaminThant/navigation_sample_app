part of blocs;

class ArticleBloc extends BlocWithState<ArticleEvent, ArticleState> {
  // ignore: non_constant_identifier_names
  final GetArticleListUseCase _getArticleListUseCase;
  final CreateArticleUseCase _createArticleUseCase;
  final GetArticleCommentUseCase _getArticleCommentUseCase;
  final CreateArticleCommentUseCase _createArticleCommentUseCase;
  final UpdateArticleCommentUseCase _updateArticleCommentUseCase;
  final ReplyArticleCommentUseCase _replyArticleCommentUseCase;
  final DeleteArticleCommentUseCase _deleteArticleCommentUseCase;
  final CreateUpvoteArticleUseCase _createUpvoteArticleUseCase;
  final CreateDownvoteArticleUseCase _createDownvoteArticleUseCase;
  final GetNewListUseCase _getNewListUseCase;
  final CreateArticleComplainUseCase _createArticleComplainUseCase;
  final CreateCommentComplainUseCase _createCommentComplainUseCase;
  final GetArticleDetailUseCase _getArticleDetailUseCase;
  final GetNewDetailUseCase _getNewDetailUseCase;
  final DeleteArticleUseCase _deleteArticleUseCase;
  final UpdateArticleUseCase _updateArticleUseCase;

  ArticleBloc(
    this._getArticleListUseCase,
    this._createArticleUseCase,
    this._getArticleCommentUseCase,
    this._createArticleCommentUseCase,
    this._updateArticleCommentUseCase,
    this._replyArticleCommentUseCase,
    this._deleteArticleCommentUseCase,
    this._createUpvoteArticleUseCase,
    this._createDownvoteArticleUseCase,
    this._getNewListUseCase,
    this._createArticleComplainUseCase,
    this._createCommentComplainUseCase,
    this._getArticleDetailUseCase,
    this._getNewDetailUseCase,
    this._deleteArticleUseCase,
    this._updateArticleUseCase,
  ) : super(ArticleInitialState());

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is InitializeArticleEvent) {
      yield* _getInitializeArticle(event);
    }

    if (event is ArticlesListRequested) {
      yield* _articleList(event);
    }

    ///

    if (event is ArticlesCreateRequested) {
      yield* _articleCreate(event);
    }

    if (event is ArticlesGetCommentRequested) {
      yield* _articleGetCommentList(event);
    }

    if (event is ArticlesCreateCommentCommentRequested) {
      yield* _articleCreateComment(event);
    }

    if (event is ArticlesUpdateCommentRequested) {
      yield* _articleUpdateCommentList(event);
    }

    if (event is ArticlesReplyCommentRequested) {
      yield* _articleReplyComment(event);
    }

    if (event is ArticlesDeleteCommentRequested) {
      yield* _articleDeleteComment(event);
    }

    if (event is ArticlesCreateUpvoteRequested) {
      yield* _articleCreateUpvote(event);
    }

    if (event is ArticlesCreateDownvoteRequested) {
      yield* _articleCreateDownvote(event);
    }

    if (event is NewsListRequested) {
      yield* _newsList(event);
    }

    if (event is ArticleCreateComplainRequested) {
      yield* _articleCreateComplain(event);
    }

    if (event is CommentCreateComplainRequested) {
      yield* _commentCreateComplain(event);
    }

    if (event is ArticlesDetailRequested) {
      yield* _getArticleDetail(event);
    }

    if (event is NewsDetailRequested) {
      yield* _getNewsDetail(event);
    }

    if (event is ArticleDeleteRequested) {
      yield* _deleteArticle(event);
    }

    if (event is ArticleUpdateRequested) {
      yield* _updateArticle(event);
    }
  }

  Stream<ArticleState> _getInitializeArticle(
      InitializeArticleEvent event) async* {
    yield* runBlocProcess(() async* {
      yield ArticleInitialState();
    });
  }

  //Articles
  ArticleModel articleModel = ArticleModel();
  int loadMorePage = 1;
  int lenghtOfArticle = 0;
  int perPage = 0;
  int total = 0;
  bool nextPageUrl = true;

  void resetState() {
    articleModel = ArticleModel();
    loadMorePage = 1;
    nextPageUrl = true;
  }

  List<NewsDetail> newsDetailList = [];
  int loadMorePageNews = 1;
  bool nextPageUrlNews = true;

  void resetStateNews() {
    newsDetailList.clear();
    loadMorePageNews = 1;
    nextPageUrlNews = true;
  }

  //Articles list
  Stream<ArticleState> _articleList(ArticlesListRequested event) async* {
    yield* runBlocProcess(() async* {
      if (loadMorePage == 1) {
        yield ArticlesListLoading();
      }
      final dataState = await _getArticleListUseCase(
        params: event.params,
      );
      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        if (loadMorePage == 1) {
          if (data != null) {
            if (data.data != null) {
              articleModel = ArticleModel.fromMap(data.data!);
              if (articleModel.data != null) {
                if (articleModel.data!.data != null) {
                  if (articleModel.data!.nextPageUrl != null) {
                    loadMorePage++;
                  } else {
                    nextPageUrl = false;
                  }
                  lenghtOfArticle = articleModel.data!.to ?? 0;
                  perPage = articleModel.data!.perPage ?? 0;
                  total = articleModel.data!.total == null
                      ? 0
                      : articleModel.data!.total!;
                }
              }
            }
          }
          yield ArticlesListSuccess(articleData: data!);
        } else {
          if (nextPageUrl == true) {
            if (data != null) {
              if (data.data != null) {
                final ArticleModel loadmoredata =
                    ArticleModel.fromMap(data.data!);
                if (loadmoredata.data != null) {
                  final dataList = loadmoredata.data!.data ?? [];
                  for (var element in dataList) {
                    articleModel.data!.data!.add(element);
                  }
                  if (loadmoredata.data!.nextPageUrl == null) {
                    nextPageUrl = false;
                  } else {
                    loadMorePage++;
                  }
                  lenghtOfArticle = loadmoredata.data!.to ?? 0;
                  perPage = loadmoredata.data!.perPage ?? 0;
                  total = articleModel.data!.total == null
                      ? 0
                      : articleModel.data!.total!;
                }
              }
            }
          }
          yield ArticlesListSuccess(articleData: data!);
        }
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ArticlesListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ArticlesListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Articles Create
  Stream<ArticleState> _articleCreate(ArticlesCreateRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ArticlesCreateLoading();
      final dataState = await _createArticleUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ArticlesCreateSuccess(articleData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ArticlesCreateFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ArticlesCreateFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Articles Get Comment List
  Stream<ArticleState> _articleGetCommentList(
      ArticlesGetCommentRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ArticlesGetCommentListLoading();
      final dataState = await _getArticleCommentUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ArticlesGetCommentListSuccess(articleData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ArticlesGetCommentListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ArticlesGetCommentListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Articles Create Comment
  Stream<ArticleState> _articleCreateComment(
      ArticlesCreateCommentCommentRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ArticlesCreateCommentLoading();
      final dataState = await _createArticleCommentUseCase(
        params: event.params,
      );
      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ArticlesCreateCommentSuccess(articleData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ArticlesCreateCommentFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ArticlesCreateCommentFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Articles Update Comment
  Stream<ArticleState> _articleUpdateCommentList(
      ArticlesUpdateCommentRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ArticlesUpdateCommentLoading();
      final dataState = await _updateArticleCommentUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ArticlesUpdateCommentSuccess(articleData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ArticlesUpdateCommentFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ArticlesUpdateCommentFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Articles Reply Comment
  Stream<ArticleState> _articleReplyComment(
      ArticlesReplyCommentRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ArticlesReplyCommentLoading();
      final dataState = await _replyArticleCommentUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ArticlesReplyCommentSuccess(articleData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ArticlesReplyCommentFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ArticlesReplyCommentFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Articles Delete Comment
  Stream<ArticleState> _articleDeleteComment(
      ArticlesDeleteCommentRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ArticlesDeleteCommentLoading();
      final dataState = await _deleteArticleCommentUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ArticlesDeleteCommentSuccess(articleData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ArticlesDeleteCommentFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ArticlesDeleteCommentFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Articles Create Upvote
  Stream<ArticleState> _articleCreateUpvote(
      ArticlesCreateUpvoteRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ArticlesCreateUpvoteLoading();
      final dataState = await _createUpvoteArticleUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ArticlesCreateUpvoteSuccess(upVoteDate: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ArticlesCreateUpvoteFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ArticlesCreateUpvoteFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Articles Create Downvote
  Stream<ArticleState> _articleCreateDownvote(
      ArticlesCreateDownvoteRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ArticlesCreateDownvoteLoading();
      final dataState = await _createDownvoteArticleUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ArticlesCreateDownvoteSuccess(downVoteData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ArticlesCreateDownvoteFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ArticlesCreateDownvoteFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //News list
  Stream<ArticleState> _newsList(NewsListRequested event) async* {
    yield* runBlocProcess(() async* {
      if (loadMorePageNews == 1) {
        yield NewsListLoading();
      }
      final dataState = await _getNewListUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        if (loadMorePageNews == 1) {
          if (data != null) {
            if (data.data != null) {
              newsDetailList.clear();
              final String? lastPage = data.data!["data"]['next_page_url'];
              Iterable iterable = data.data!['data']["data"];
              for (var element in iterable) {
                newsDetailList.add(NewsDetailModel.fromJson(element));
              }
              if (lastPage != null) {
                loadMorePageNews++;
              } else {
                nextPageUrlNews = false;
              }
            }
          }
          yield NewsListSuccess(
            newsData: data!,
            country: event.params?.appLocale,
          );
        } else {
          if (nextPageUrlNews == true) {
            if (data != null) {
              if (data.data != null) {
                final String? lastPage = data.data!["data"]['next_page_url'];
                List<NewsDetail> loadmoredata = [];
                Iterable iterable = data.data!['data']["data"];
                for (var element in iterable) {
                  loadmoredata.add(NewsDetailModel.fromJson(element));
                }
                if (loadmoredata.isNotEmpty) {
                  for (var element in loadmoredata) {
                    newsDetailList.add(element);
                  }
                  if (lastPage == null) {
                    nextPageUrlNews = false;
                  } else {
                    loadMorePageNews++;
                  }
                }
              }
            }
          }
          yield NewsListSuccess(newsData: data!);
        }
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const NewsListFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield NewsListFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Article Create Complain
  Stream<ArticleState> _articleCreateComplain(
      ArticleCreateComplainRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ArticleCreateComplainLoading();
      final dataState = await _createArticleComplainUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ArticleCreateComplainSuccess(newsData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ArticleCreateComplainFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ArticleCreateComplainFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Comment Create Complain
  Stream<ArticleState> _commentCreateComplain(
      CommentCreateComplainRequested event) async* {
    yield* runBlocProcess(() async* {
      yield CommentCreateComplainLoading();
      final dataState = await _createCommentComplainUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield CommentCreateComplainSuccess(newsData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const CommentCreateComplainFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield CommentCreateComplainFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Articles Get Comment List
  Stream<ArticleState> _getArticleDetail(ArticlesDetailRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ArticleDetailLoading();
      final dataState = await _getArticleDetailUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ArticleDetailSuccess(articleData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ArticleDetailFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ArticleDetailFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //News Detail
  Stream<ArticleState> _getNewsDetail(NewsDetailRequested event) async* {
    yield* runBlocProcess(() async* {
      yield NewsDetailLoading();
      final dataState = await _getNewDetailUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield NewsDetailSuccess(articleData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const NewsDetailFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield NewsDetailFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Article Delete
  Stream<ArticleState> _deleteArticle(ArticleDeleteRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ArticleDeleteLoading();
      final dataState = await _deleteArticleUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ArticleDeleteSuccess(articleData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ArticleDeleteFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ArticleDeleteFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }

  //Article Update
  Stream<ArticleState> _updateArticle(ArticleUpdateRequested event) async* {
    yield* runBlocProcess(() async* {
      yield ArticleUpdateLoading();
      final dataState = await _updateArticleUseCase(
        params: event.params,
      );

      if (dataState is DataSuccess) {
        final DataResponseModel? data = dataState.data;
        yield ArticleUpdateSuccess(articleData: data!);
      } else if (dataState is DataFailed) {
        if (dataState.error!.response == null) {
          yield const ArticleUpdateFail(message: 'retry');
        } else if (dataState.error!.response!.statusCode! > 399) {
          yield ArticleUpdateFail(
              message: dataState.error!.response!.data['message'].toString());
        }
      }
    });
  }
}
