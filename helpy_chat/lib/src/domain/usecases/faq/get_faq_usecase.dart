part of '../usecases.dart';
//FAQ
class GetFaqUseCase
    implements UseCase<DataState<DataResponseModel>, FaqRequestParams> {
  final FaqsRepository _faqsRepository;
  GetFaqUseCase(this._faqsRepository);

  @override
  Future<DataState<DataResponseModel>> call({FaqRequestParams? params}) {
    return _faqsRepository.fetchFaq(params!);
  }
}