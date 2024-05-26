part of 'repositories.dart';

abstract class FaqsRepository {
  //Faq List
  Future<DataState<DataResponseModel>> fetchFaq(
      FaqRequestParams params);
}