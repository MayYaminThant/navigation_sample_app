part of '../usecases.dart';

class DeleteArticleUseCase implements UseCase<DataState<DataResponseModel>, ArticleDeleteRequestParams>{
  final ArticleRepository _articleRepository;

  DeleteArticleUseCase(this._articleRepository);
  
  @override
  Future<DataState<DataResponseModel>> call({ArticleDeleteRequestParams? params}) {
    return _articleRepository.deleteArticle(params!);
  }

}