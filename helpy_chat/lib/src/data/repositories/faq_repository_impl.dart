part of 'repositories_impl.dart';

class FaqRepositoryImpl implements FaqsRepository {
  final FaqApiSerice _faqApiSerice;

  const FaqRepositoryImpl(this._faqApiSerice);

  @override
  Future<DataState<DataResponseModel>> fetchFaq(FaqRequestParams params) async {
    try {
      final httpResponse = await _faqApiSerice.postFaqs(
        acceptType: 'application/json',
        language: params.language,
        page: params.page,
        keyword: params.keyword
      );
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(DataResponseModel.fromJson(
            httpResponse.response.data));
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
