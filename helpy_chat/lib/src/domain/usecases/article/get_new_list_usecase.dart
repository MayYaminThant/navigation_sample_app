part of '../usecases.dart';

class GetNewListUseCase implements UseCase<DataState<DataResponseModel>, NewsListRequestParams> {
  final ArticleRepository _articleRepository;
  GetNewListUseCase(this._articleRepository);

  @override
  Future<DataState<DataResponseModel>> call({NewsListRequestParams? params}) {
    return _articleRepository.newLists(params!);
  }
}
