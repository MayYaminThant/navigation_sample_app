part of '../usecases.dart';

class CreateArticleComplainUseCase implements UseCase<DataState<DataResponseModel>, ArticleCreateComplainRequestParams>{
  final ArticleRepository _articleRepository;

  CreateArticleComplainUseCase(this._articleRepository);
  
  @override
  Future<DataState<DataResponseModel>> call({ArticleCreateComplainRequestParams? params}) {
    return _articleRepository.createArticleComplain(params!);
  }

}