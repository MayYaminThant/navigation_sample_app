import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/models.dart';

part 'notification_api_service.g.dart';

@RestApi()
abstract class NotificationApiService {
  factory NotificationApiService(Dio dio, {String baseUrl}) =
      _NotificationApiService;

  //Employer Notifications
  @GET('/employer/notifications')
  Future<HttpResponse<DataResponseModel>> getEmployerNotifications(
      {@Header("Accept") String? acceptType,
      @Header("Authorization") String? token,
      @Query("per_page") String? perPage});

  //Employer Notification Read
  @POST('/employer/notifications/{notificationId}/read')
  Future<HttpResponse<DataResponseModel>> postEmployerNotificationsRead({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("notificationId") int? notificationId,
  });

  //Candidate Notification UnRead
  @POST('/employer/notifications/{notificationId}/unread')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> postEmployerNotificationsUnRead({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("notificationId") int? notificationId,
  });

  //Employer Notification Delete
  @DELETE('/employer/notifications/{notificationId}')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> deleteEmployerNotification({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
    @Path("notificationId") int? notificationId,
  });

  //Candidate All Notification Delete
  @DELETE('/employer/notifications')
  @FormUrlEncoded()
  Future<HttpResponse<DataResponseModel>> deleteAllEmployerNotification({
    @Header("Accept") String? acceptType,
    @Header("Authorization") String? token,
  });
}
