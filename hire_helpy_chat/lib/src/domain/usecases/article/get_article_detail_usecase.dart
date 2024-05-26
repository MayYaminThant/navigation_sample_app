part of '../usecases.dart';


class GetArticleDetailUseCase implements UseCase<DataState<DataResponseModel>, ArticlesCommentListRequestParams> {

  final ArticleRepository _articleRepository;

  GetArticleDetailUseCase(this._articleRepository);
  
  @override
  Future<DataState<DataResponseModel>> call({ArticlesCommentListRequestParams? params}) {
    return _articleRepository.getArticleDetail(params!);
  }
}