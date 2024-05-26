part of '../usecases.dart';

class DeleteArticleCommentUseCase implements UseCase<DataState<DataResponseModel>,ArticlesDeleteCommentRequestParams> {
  final ArticleRepository _articleRepository;

  DeleteArticleCommentUseCase(this._articleRepository);
  
  @override
  Future<DataState<DataResponseModel>> call({ArticlesDeleteCommentRequestParams? params}) {
    return _articleRepository.deleteCommentListArticles(params!);
  }
}