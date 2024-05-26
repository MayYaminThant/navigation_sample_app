part of 'params.dart';

//Faq
class FaqRequestParams {
  final String? language;
  final String? bearerToken;
  final int? page;
  final String? keyword;

  FaqRequestParams({this.language, this.bearerToken, this.page, this.keyword});
}
