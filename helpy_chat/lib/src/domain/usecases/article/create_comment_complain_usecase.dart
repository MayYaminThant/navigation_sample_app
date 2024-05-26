part of '../usecases.dart';

class CreateCommentComplainUseCase implements UseCase<DataState<DataResponseModel>, ArticleCommentCreateComplainRequestParams>{
  final ArticleRepository _articleRepository;

  CreateCommentComplainUseCase(this._articleRepository);
  
  @override
  Future<DataState<DataResponseModel>> call({ArticleCommentCreateComplainRequestParams? params}) {
    return _articleRepository.createCommentComplain(params!);
  }

}