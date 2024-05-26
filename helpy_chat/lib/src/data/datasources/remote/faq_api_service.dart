import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/models.dart';

part 'faq_api_service.g.dart';

@RestApi()
abstract class FaqApiSerice {
  factory FaqApiSerice(Dio dio, {String baseUrl}) = _FaqApiSerice;

  //faqs
  @GET('/candidate/faqs?language={language}&page={page}&keyword={keyword}')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> postFaqs({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("language") String? language,
    @Path("page") int? page,
    @Path("keyword") String? keyword,
  });
}
