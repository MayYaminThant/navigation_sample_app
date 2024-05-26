part of '../usecases.dart';


class GetArticleCommentUseCase implements UseCase<DataState<DataResponseModel>, ArticlesCommentListRequestParams> {

  final ArticleRepository _articleRepository;

  GetArticleCommentUseCase(this._articleRepository);
  
  @override
  Future<DataState<DataResponseModel>> call({ArticlesCommentListRequestParams? params}) {
    return _articleRepository.getComments(params!);
  }

}