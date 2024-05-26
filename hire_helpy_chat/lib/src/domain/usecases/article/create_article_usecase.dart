part of '../usecases.dart';

class CreateArticleUseCase implements UseCase<DataState<DataResponseModel>,ArticlesCreateRequestParams> {
  
  final ArticleRepository _articleRepository;
  
  CreateArticleUseCase(
     this._articleRepository,
  );
  
  @override
  Future<DataState<DataResponseModel>> call({ArticlesCreateRequestParams? params}) {
    return _articleRepository.createArticle(params!);
  }

}
