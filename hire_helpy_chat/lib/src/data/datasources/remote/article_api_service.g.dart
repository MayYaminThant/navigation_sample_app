// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ArticleApiSerice implements ArticleApiSerice {
  _ArticleApiSerice(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<DataResponseModel>> getArticles({
    acceptType,
    language,
    sortBy,
    page,
    token,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/employer/articles?language=${language}&sortBy=${sortBy}&page=${page}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> getArticleDetail({
    acceptType,
    token,
    articleId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/employer/articles/${articleId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createCommentCommentArticle({
    acceptType,
    token,
    articleId,
    message,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'article_id': articleId,
      'message': message,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/employer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> updateCommentArticle({
    acceptType,
    token,
    commentId,
    messageUpdate,
    method,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'comment_id': commentId,
      r'message': messageUpdate,
      r'_method': method,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/employer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> replyCommentArticle({
    acceptType,
    token,
    commentId,
    message,
    userId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'comment_id': commentId,
      'message': message,
      'user_id': userId,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/employer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> deleteCommentArticle({
    acceptType,
    token,
    commentId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'comment_id': commentId};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/employer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createUpvoteArticle({
    acceptType,
    token,
    articleId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/employer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createDownvoteArticle({
    acceptType,
    token,
    articleId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/employer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createArticleComplain({
    acceptType,
    token,
    articleId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/employer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createCommentComplain({
    acceptType,
    token,
    commentId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/employer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> getNews({
    acceptType,
    appLocale,
    page,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'app_locale': appLocale};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Accept': acceptType};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/employer/news?page=${page}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> getNewsDetail({
    acceptType,
    token,
    newsId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/employer/news/${newsId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> getComments({
    acceptType,
    token,
    page,
    articleId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/employer/articles/${articleId}/comments',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> deleteArticle({
    acceptType,
    token,
    articleId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/employer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> createArticle({
    acceptType,
    token,
    title,
    images,
    thumbnails,
    content,
    language,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (title != null) {
      _data.fields.add(MapEntry(
        'title',
        title,
      ));
    }
    if (images != null) {
      _data.files.addAll(images.map((i) => MapEntry(
          'images[]',
          MultipartFile.fromFileSync(
            i.path,
            filename: i.path.split(Platform.pathSeparator).last,
          ))));
    }
    if (thumbnails != null) {
      _data.files.addAll(thumbnails.map((i) => MapEntry(
          'thumbnails[]',
          MultipartFile.fromFileSync(
            i.path,
            filename: i.path.split(Platform.pathSeparator).last,
          ))));
    }
    if (content != null) {
      _data.fields.add(MapEntry(
        'content',
        content,
      ));
    }
    if (language != null) {
      _data.fields.add(MapEntry(
        'language',
        language,
      ));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              '/employer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<DataResponseModel>> updateArticle({
    acceptType,
    token,
    articleId,
    title,
    images,
    thumbnails,
    media,
    content,
    language,
    method,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': acceptType,
      r'Authorization': token,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (articleId != null) {
      _data.fields.add(MapEntry(
        'article_id',
        articleId.toString(),
      ));
    }
    if (title != null) {
      _data.fields.add(MapEntry(
        'title',
        title,
      ));
    }
    if (images != null) {
      _data.files.addAll(images.map((i) => MapEntry(
          'images[]',
          MultipartFile.fromFileSync(
            i.path,
            filename: i.path.split(Platform.pathSeparator).last,
          ))));
    }
    if (thumbnails != null) {
      _data.files.addAll(thumbnails.map((i) => MapEntry(
          'thumbnails[]',
          MultipartFile.fromFileSync(
            i.path,
            filename: i.path.split(Platform.pathSeparator).last,
          ))));
    }
    if (media != null) {
      _data.fields.add(MapEntry(
        'media',
        media,
      ));
    }
    if (content != null) {
      _data.fields.add(MapEntry(
        'content',
        content,
      ));
    }
    if (language != null) {
      _data.fields.add(MapEntry(
        'language',
        language,
      ));
    }
    if (method != null) {
      _data.fields.add(MapEntry(
        '_method',
        method,
      ));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DataResponseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              '/employer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DataResponseModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
