part of '../usecases.dart';

class GetNewDetailUseCase implements UseCase<DataState<DataResponseModel>, NewsDetailRequestParams> {
  final ArticleRepository _articleRepository;
  GetNewDetailUseCase(this._articleRepository);

  @override
  Future<DataState<DataResponseModel>> call({NewsDetailRequestParams? params}) {
    return _articleRepository.newDetails(params!);
  }
}
