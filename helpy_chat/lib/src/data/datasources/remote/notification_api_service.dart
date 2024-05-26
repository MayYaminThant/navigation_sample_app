import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/models.dart';

part 'notification_api_service.g.dart';

@RestApi()
abstract class NotificationApiService {
  factory NotificationApiService(Dio dio, {String baseUrl}) =
      _NotificationApiService;

  //Candidate Notifications
  @GET('/candidate/notifications')
  Future<HttpResponse<DataResponseModel>> getCandidateNotifications(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Query("per_page") String? perPage});

  //Candidate Notification Read
  @POST('/candidate/notifications/{notificationId}/read')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> postCandidateNotificationsRead({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("notificationId") int? notificationId,
  });

  //Candidate Notification UnRead
  @POST('/candidate/notifications/{notificationId}/unread')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> postCandidateNotificationsUnRead({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("notificationId") int? notificationId,
  });

  //Candidate Notification Delete
  @DELETE('/candidate/notifications/{notificationId}')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> deleteCandidateNotification({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("notificationId") int? notificationId,
  });

  //Candidate All Notification Delete
  @DELETE('/candidate/notifications')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> deleteAllCandidateNotification({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });
}
