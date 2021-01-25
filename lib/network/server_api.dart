import 'dart:io';
import 'package:bounty_hub_client/data/models/api/request/auth_request.dart';
import 'package:bounty_hub_client/data/models/api/request/set_social.dart';
import 'package:bounty_hub_client/data/models/api/response/company_list_response.dart';
import 'package:bounty_hub_client/data/models/api/response/confirm_task_response.dart';
import 'package:bounty_hub_client/data/models/api/response/image_response.dart';
import 'package:bounty_hub_client/data/models/api/response/notification_count_response.dart';
import 'package:bounty_hub_client/data/models/api/response/notification_response.dart';
import 'package:bounty_hub_client/data/models/api/response/tasks_response.dart';
import 'package:bounty_hub_client/data/models/api/response/token_response.dart';
import 'package:bounty_hub_client/data/models/api/response/user_tasks_response.dart';
import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/data/models/entity/user/social.dart';
import 'package:bounty_hub_client/data/models/entity/user/user.dart';
import 'package:bounty_hub_client/data/models/entity/user_task/user_task.dart';
import 'package:bounty_hub_client/network/interceptors/oauth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'server_api.g.dart';

@RestApi(baseUrl: "https://api.bountyhub.io/api")
abstract class RestClient {
  factory RestClient({String baseUrl}) {
    Dio dio = Dio();

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));

    dio.interceptors.add(OauthInterceptor());

    dio.options = BaseOptions(receiveTimeout: 60000, connectTimeout: 60000);
    return _RestClient(dio, baseUrl: baseUrl);
  }

  @POST("/users/authenticate")
  Future<void> authenticate(@Body() AuthRequest authRequest);

  @POST("/oauth/code")
  Future<TokenResponse> confirmCode(@Query('email') String email,
      @Query('code') String code, @Query('grant_type') String grantType);

  @GET("/items/filtered")
  Future<TasksResponse> getTasks(
      @Query('campaignsIds') String campaignsIds,
      @Query('socialType') String socialType,
      @Query('userId') String userId,
      @Query('page') int page,
      @Query('size') int size,
      @Query('status') String status,
      @Query('sort') String sort,
      @Query('running') bool running,
      @Query('accessMode') String accessMode);

  @GET("/items/{itemId}")
  Future<Task> getTask(@Path('itemId') String taskId);

  @GET("/campaigns/{campaignId}")
  Future<Campaign> getCampaign(@Path('campaignId') String campaignId);

  @GET("/campaigns/filtered?statusType=APPROVED&sort=position,desc&accessMode=PUBLIC")
  Future<CompanyListResponse> getAllCampaign();

  @GET("/users/{userId}/item/{taskId}")
  Future<UserTask> getUserTask(@Path('userId') String userId,
      @Path('taskId') String taskId, @Query('redirectUrl') String redirectUrl);

  @GET("/user-items/list")
  Future<UserTasksResponse> getUserTasks(
      @Query('campaignId') String campaignId,
      @Query('socialNetwork') String socialType,
      @Query('userId') String userId,
      @Query('page') int page,
      @Query('size') int size);

  @GET("/user-items/{userId}/complete/{userTaskId}")
  Future<String> confirmSocialParserTask(@Path('userId') String userId,
      @Path('userTaskId') String userTaskId, @Query('redirectUrl') String redirectUrl,
      @Query('comment') String comment, @Query('imageId') String imageId);

  @GET("/user-items/{userId}/complete/{userTaskId}")
  Future<ConfirmTaskResponse> confirmAutoCheckTask(@Path('userId') String userId,
      @Path('userTaskId') String userTaskId, @Query('redirectUrl') String redirectUrl,
      @Query('comment') String comment);

  @POST("/user-items/{userId}/reserve/{taskId}")
  Future<UserTask> takeTask(
      @Path('userId') String userId, @Path('taskId') String taskId);

  @POST("/images/upload/user")
  Future<ImageResponse> uploadImage(@Part() File image);

  @GET("/users/{userId}")
  Future<User> getUser({@Path('userId') String userId});

  @PUT("/users/{userId}")
  Future<void> putUser(@Path('userId') String userId, @Body() User updatedUser);

  @GET("/users/my-social-accounts")
  Future<List<Socials>> getMySocialAccounts();

  @POST("/users/set-social-account")
  Future<void> setSocial(@Body() SetSocialRequest body);

  @DELETE("/users/social/{id}/delete")
  Future<void> removeSocial(@Path('id') String id);

  @GET("/notifications/list")
  Future<NotificationResponse> getActivities(
      @Query('page') int page, @Query('size') int size);

  @GET("/notifications/unread")
  Future<NotificationCountResponse> getUnreadActivitiesCount();

  @PUT("/notifications/notification/{id}/read")
  Future<void> readNotification(@Path('id') id);

  @PUT("/user-items/{userId}/leave/{userTaskId}")
  Future<String> leaveTask(@Path('userId') String userId, @Path('userTaskId') String userTaskId);

  @POST("/user-items/retry")
  Future<UserTask> retryTask(@Query('userItemId') String userItemId);
}
