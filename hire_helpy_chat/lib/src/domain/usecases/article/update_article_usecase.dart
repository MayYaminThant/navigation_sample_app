part of '../usecases.dart';

class UpdateArticleUseCase implements UseCase<DataState<DataResponseModel>, ArticleUpdateRequestParams>{
  final ArticleRepository _articleRepository;

  UpdateArticleUseCase(this._articleRepository);
  
  @override
  Future<DataState<DataResponseModel>> call({ArticleUpdateRequestParams? params}) {
    return _articleRepository.updateArticle(params!);
  }


}