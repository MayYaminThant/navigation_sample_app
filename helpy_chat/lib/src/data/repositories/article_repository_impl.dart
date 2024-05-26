part of 'repositories_impl.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleApiSerice _articleApiService;

  const ArticleRepositoryImpl(this._articleApiService);

  @override
  Future<DataState<DataResponseModel>> articleLists(
      ArticlesListRequestParams params) async {
    try {
      final httpResponse = await _articleApiService.getArticles(
        acceptType: 'application/json',
        language: params.language,
        sortBy: params.sortBy,
        page: params.page,
        token: params.token != null ? 'Bearer ${params.token}' : null,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> createArticle(
      ArticlesCreateRequestParams params) async {
    try {
      List<File> images = params.images ?? [];
      List<File> thumbnails =
          params.images != null ? await generateThumbnails(params.images!) : [];
      final httpResponse = await _articleApiService.createArticle(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          title: params.title,
          content: params.content,
          images: images.isNotEmpty ? [images.first] : [],
          thumbnails: thumbnails.isNotEmpty ? [thumbnails.first] : [],
          language: params.language);
      superPrint(httpResponse.data.data);
      final String articleID =
          "${httpResponse.data.data!["data"]["article_id"]}";
      superPrint(articleID);
      if (images.length > 1) {
        images.removeAt(0);
        thumbnails.removeAt(0);
        for (int i = 0; i < images.length; i++) {
          final httpResponseUpload =
              await _articleApiService.singleFileUploadArticle(
                  acceptType: 'application/json',
                  token: 'Bearer ${params.token}',
                  articleId: articleID,
                  image: images[i],
                  thumbnail: thumbnails[i]);
          superPrint(httpResponseUpload.data.data);
        }
      }

      if (httpResponse.response.statusCode == 201) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> createCommentListArticles(
      ArticlesCreateCommentCommentRequestParams params) async {
    try {
      final httpResponse = await _articleApiService.createCommentCommentArticle(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        articleId: params.articleId,
        message: params.message,
      );

      if (httpResponse.response.statusCode == 200 ||
          httpResponse.response.statusCode == 201) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> deleteCommentListArticles(
      ArticlesDeleteCommentRequestParams params) async {
    try {
      final httpResponse = await _articleApiService.deleteCommentArticle(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        commentId: params.commentId,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> getArticleDetail(
      ArticlesCommentListRequestParams params) async {
    try {
      final httpResponse = await _articleApiService.getArticleDetail(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        articleId: params.articleId,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> replyCommentListArticles(
      ArticlesReplyCommentRequestParams params) async {
    try {
      final httpResponse = await _articleApiService.replyCommentArticle(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        commentId: params.commentId,
        message: params.replyMessage,
        userId: params.userId,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> updateCommentListArticles(
      ArticlesUpDateCommentRequestParams params) async {
    try {
      final httpResponse = await _articleApiService.updateCommentArticle(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          commentId: params.commentId,
          messageUpdate: params.messageUpdate,
          method: "PUT");

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> createUpvoteArticles(
      ArticlesUpvoteRequestParams params) async {
    try {
      final httpResponse = await _articleApiService.createUpvoteArticle(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        articleId: params.articleId,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> createDownvoteArticles(
      ArticlesDownvoteRequestParams params) async {
    try {
      final httpResponse = await _articleApiService.createDownvoteArticle(
        acceptType: 'application/json',
        token: 'Bearer ${params.token}',
        articleId: params.articleId,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> newLists(
      NewsListRequestParams params) async {
    try {
      final httpResponse = await _articleApiService.getNews(
          acceptType: 'application/json',
          appLocale: params.appLocale,
          page: params.page);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> newDetails(
      NewsDetailRequestParams params) async {
    try {
      final httpResponse = await _articleApiService.getNewsDetail(
        acceptType: 'application/json',
        newsId: params.newsId,
      );
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> createArticleComplain(
      ArticleCreateComplainRequestParams params) async {
    try {
      final httpResponse = await _articleApiService.createArticleComplain(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          articleId: params.articleId);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DataResponseModel>> createCommentComplain(
      ArticleCommentCreateComplainRequestParams params) async {
    try {
      final httpResponse = await _articleApiService.createCommentComplain(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          commentId: params.commentId);

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  //Comment Lists
  @override
  Future<DataState<DataResponseModel>> getComments(
      ArticlesCommentListRequestParams params) async {
    try {
      final httpResponse = await _articleApiService.getComments(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          articleId: params.articleId,
          page: params.page);

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  //Article Delete
  @override
  Future<DataState<DataResponseModel>> deleteArticle(
      ArticleDeleteRequestParams params) async {
    try {
      final httpResponse = await _articleApiService.deleteArticle(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          articleId: params.articleId);

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  //Article Update
  @override
  Future<DataState<DataResponseModel>> updateArticle(
      ArticleUpdateRequestParams params) async {
    try {
      List<File> images = params.images ?? [];
      List<File> thumbnails =
          params.images != null ? await generateThumbnails(params.images!) : [];
      final httpResponse = await _articleApiService.updateArticle(
          acceptType: 'application/json',
          token: 'Bearer ${params.token}',
          articleId: params.articleId,
          title: params.title,
          content: params.content,
          language: params.language,
          media: params.media,
          images: images.isNotEmpty ? [images.first] : [],
          thumbnails: thumbnails.isNotEmpty ? [thumbnails.first] : [],
          method: 'PUT');
      superPrint(httpResponse.data.data);
      if (images.length > 1) {
        images.removeAt(0);
        thumbnails.removeAt(0);
        for (int i = 0; i < images.length; i++) {
          final httpResponseUpload =
              await _articleApiService.singleFileUploadArticle(
                  acceptType: 'application/json',
                  token: 'Bearer ${params.token}',
                  articleId: "${params.articleId}",
                  image: images[i],
                  thumbnail: thumbnails[i]);
          superPrint(httpResponseUpload.data.data);
        }
      }
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(
            DataResponseModel.fromJson(httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
