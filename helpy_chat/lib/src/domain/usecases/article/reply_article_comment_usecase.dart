part of '../usecases.dart';

class ReplyArticleCommentUseCase implements UseCase<DataState<DataResponseModel>,ArticlesReplyCommentRequestParams> {
  final ArticleRepository _articleRepository;

  ReplyArticleCommentUseCase(this._articleRepository);
  
  @override
  Future<DataState<DataResponseModel>> call({ArticlesReplyCommentRequestParams? params}) {
    return _articleRepository.replyCommentListArticles(params!);
  }
}