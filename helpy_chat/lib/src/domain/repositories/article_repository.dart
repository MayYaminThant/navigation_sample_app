part of 'repositories.dart';

abstract class ArticleRepository {
  //Article List
  Future<DataState<DataResponseModel>> articleLists(
      ArticlesListRequestParams params);

  //Create Article
  Future<DataState<DataResponseModel>> createArticle(
      ArticlesCreateRequestParams params);
  
  //Article Detail
  Future<DataState<DataResponseModel>> getArticleDetail(
      ArticlesCommentListRequestParams params);
      
  Future<DataState<DataResponseModel>> createCommentListArticles(
      ArticlesCreateCommentCommentRequestParams params);
      
  Future<DataState<DataResponseModel>> updateCommentListArticles(
      ArticlesUpDateCommentRequestParams params);

  Future<DataState<DataResponseModel>> replyCommentListArticles(
      ArticlesReplyCommentRequestParams params);

  Future<DataState<DataResponseModel>> deleteCommentListArticles(
      ArticlesDeleteCommentRequestParams params);

  Future<DataState<DataResponseModel>> createUpvoteArticles(
      ArticlesUpvoteRequestParams params);
      
  Future<DataState<DataResponseModel>> createDownvoteArticles(
      ArticlesDownvoteRequestParams params);

  //News List
  Future<DataState<DataResponseModel>> newLists(
      NewsListRequestParams params);

  Future<DataState<DataResponseModel>> newDetails(
      NewsDetailRequestParams params);
  
  //Article Create Complain 
  Future<DataState<DataResponseModel>> createArticleComplain(
      ArticleCreateComplainRequestParams params);
  
  //Comment Create Complain 
  Future<DataState<DataResponseModel>> createCommentComplain(
      ArticleCommentCreateComplainRequestParams params);

  //Comment List
  Future<DataState<DataResponseModel>> getComments(
      ArticlesCommentListRequestParams params);

  //Article Delete
  Future<DataState<DataResponseModel>> deleteArticle(
      ArticleDeleteRequestParams params);

  //Article Update
  Future<DataState<DataResponseModel>> updateArticle(
      ArticleUpdateRequestParams params);
}
