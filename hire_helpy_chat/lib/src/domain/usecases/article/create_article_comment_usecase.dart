part of '../usecases.dart';

class CreateArticleCommentUseCase implements UseCase<DataState<DataResponseModel>,ArticlesCreateCommentCommentRequestParams>{
  final ArticleRepository _articleRepository;

  CreateArticleCommentUseCase(this._articleRepository);
  
  @override
  Future<DataState<DataResponseModel>> call({ArticlesCreateCommentCommentRequestParams? params}) {
    return _articleRepository.createCommentListArticles(params!);
  }


}