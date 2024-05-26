import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/models.dart';

part 'connection_api_service.g.dart';

@RestApi()
abstract class ConnectionApiService {
  factory ConnectionApiService(Dio dio, {String baseUrl}) =
      _ConnectionApiService;

  //Connection Send Request
  @POST('/candidate/connections/send_request')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createSendequest({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field("receiver_user_id") int? receiverUserId,
  });

  //Connection My Requests
  @GET('/candidate/connections/my_requests')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> getMyRequests({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Connection Incoming Requests
  @GET('/candidate/connections/incomings')
  Future<HttpResponse<DataResponseModel>> getIncomingsRequests({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Connection Accept Request
  @POST('/candidate/connections/accept')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createAcceptRequest({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field("chat_request_id") int? requestId,
  });

  //Connection Reject Request
  @POST('/candidate/connections/reject')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> createRejectRequest({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Field("chat_request_id") int? requestId,
  });

  //Connection Delete My Requests
  @DELETE('/candidate/connections/my_requests/{chatRequest}')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> deleteMyRequest({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("chatRequest") int? chatRequestId,
  });

  //Candidate Connections
  @GET('/candidate/connections')
  Future<HttpResponse<DataResponseModel>> getConnections({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });

  //Candidate Unlink
  @DELETE('/candidate/connections/unlink/{chatConnectId}')
  Future<HttpResponse<DataResponseModel>> unlinkConnection({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("chatConnectId") int? chatConnectId,
  });
}
