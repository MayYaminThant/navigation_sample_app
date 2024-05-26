part of '../usecases.dart';

class UpdateArticleCommentUseCase implements UseCase<DataState<DataResponseModel>,ArticlesUpDateCommentRequestParams>{
  final ArticleRepository _articleRepository;

  UpdateArticleCommentUseCase(this._articleRepository);
  
  @override
  Future<DataState<DataResponseModel>> call({ArticlesUpDateCommentRequestParams? params}) {
    return _articleRepository.updateCommentListArticles(params!);
  }
}