part of '../usecases.dart';

class GetArticleListUseCase implements UseCase<DataState<DataResponseModel>, ArticlesListRequestParams> {
  final ArticleRepository _articleRepository;
  GetArticleListUseCase(this._articleRepository);

  @override
  Future<DataState<DataResponseModel>> call({ArticlesListRequestParams? params}) {
    return _articleRepository.articleLists(params!);
  }
}
