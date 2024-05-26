part of '../usecases.dart';

class CreateDownvoteArticleUseCase implements UseCase<DataState<DataResponseModel>,ArticlesDownvoteRequestParams>{
  final ArticleRepository _articleRepository;

  CreateDownvoteArticleUseCase(this._articleRepository);
  
  @override
  Future<DataState<DataResponseModel>> call({ArticlesDownvoteRequestParams? params}) {
    return _articleRepository.createDownvoteArticles(params!);
  }
}