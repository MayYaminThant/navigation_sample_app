import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/models.dart';

part 'article_api_service.g.dart';

@RestApi()
abstract class ArticleApiSerice {
  factory ArticleApiSerice(Dio dio, {String baseUrl}) = _ArticleApiSerice;

  //Articles
  @GET('/employer/articles?language={language}&sortBy={sortBy}&page={page}')
  Future<HttpResponse<DataResponseModel>> getArticles({
    @Header("Accept") String? acceptType,
    @Path("language") String? language,
    @Path("sortBy") String? sortBy,
    @Path("page") int? page,
    @Header("Authorization") String? token,
  });

  //Get Comment List of Article for Candidate
  @GET('/employer/articles/{articleId}')
  Future<HttpResponse<DataResponseModel>> getArticleDetail({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("articleId") int? articleId,
  });

  //Create Comment Comment by Candidate
  @POST('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createCommentCommentArticle({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field("article_id") String? articleId,
    @Field("message") String? message,
  });

  //Update Comment by Candidate
  @PUT('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> updateCommentArticle({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Query("comment_id") int? commentId,
    @Query("message") String? messageUpdate,
    @Query("_method") String? method,
  });

  //Reply Comment by Candidate
  @POST('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> replyCommentArticle({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field("comment_id") int? commentId,
    @Field("message") String? message,
    @Field("user_id") int? userId,
  });

  //Delete Comment by Candidate
  @DELETE('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> deleteCommentArticle({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Query("comment_id") int? commentId,
  });

  //Save Upvote for Article
  @POST('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createUpvoteArticle({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("articleId") int? articleId,
  });

  //Save Downvote for Article
  @POST('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createDownvoteArticle({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("articleId") int? articleId,
  });

  //Create Article Complain
  @POST('/employer')
  Future<HttpResponse<DataResponseModel>> createArticleComplain({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("articleId") int? articleId,
  });

  //Create Comment Complain
  @POST('/employer')
  Future<HttpResponse<DataResponseModel>> createCommentComplain({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("comment") int? commentId,
  });

  //Get News List
  @GET('/employer/news?page={page}')
  Future<HttpResponse<DataResponseModel>> getNews({
    @Header("Accept") String? acceptType,
    @Query("app_locale") String? appLocale,
    @Path("page") int? page,
  });

  //Get News Detail
  @GET('/employer/news/{newsId}')
  Future<HttpResponse<DataResponseModel>> getNewsDetail({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("newsId") int? newsId,
  });

  //Get News Detail
  @GET('/employer/articles/{articleId}/comments')
  Future<HttpResponse<DataResponseModel>> getComments({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Query("page") int? page,
    @Path("articleId") int? articleId,
  });

  //Delete Article
  @DELETE('/employer')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> deleteArticle({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("articleId") int? articleId,
  });

  //Create Article
  @POST('/employer')
  @MultiPart()
  Future<HttpResponse<DataResponseModel>> createArticle({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Part(name: "title") String? title,
    @Part(name: 'images[]') List<File>? images,
    @Part(name: 'thumbnails[]') List<File>? thumbnails,
    @Part(name: "content") String? content,
    @Part(name: "language") String? language,
  });

  //Create Article
  @POST('/employer')
  @MultiPart()
  Future<HttpResponse<DataResponseModel>> updateArticle({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Part(name: "article_id") int? articleId,
    @Part(name: "title") String? title,
    @Part(name: 'images[]') List<File>? images,
    @Part(name: 'thumbnails[]') List<File>? thumbnails,
    @Part(name: "media") String? media,
    @Part(name: "content") String? content,
    @Part(name: "language") String? language,
    @Part(name: "_method") String? method,
  });
}
