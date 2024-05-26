part of '../usecases.dart';

class CreateUpvoteArticleUseCase implements UseCase<DataState<DataResponseModel>,ArticlesUpvoteRequestParams>{
  final ArticleRepository _articleRepository;

  CreateUpvoteArticleUseCase(this._articleRepository);
  
  @override
  Future<DataState<DataResponseModel>> call({ArticlesUpvoteRequestParams? params}) {
    return _articleRepository.createUpvoteArticles(params!);
  }
}