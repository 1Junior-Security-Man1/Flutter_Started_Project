import 'package:bounty_hub_client/data/models/api/request/auth_request.dart';
import 'package:bounty_hub_client/data/models/api/response/tasks_response.dart';
import 'package:bounty_hub_client/data/models/api/response/token_response.dart';
import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/network/interceptors/oauth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'server_api.g.dart';

@RestApi(baseUrl: "https://api.bountyhub.io/api")
abstract  class RestClient {

  factory RestClient({String baseUrl}){
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

    dio.options = BaseOptions(receiveTimeout: 30000, connectTimeout: 30000);
    return _RestClient(dio, baseUrl: baseUrl);
  }

  @POST("/users/authenticate")
  Future<void> authenticate(@Body() AuthRequest authRequest);

  @POST("/oauth/code")
  Future<TokenResponse> confirmCode(@Query('email') String email, @Query('code') String code, @Query('grant_type') String grantType);

  @GET("/items/filtered")
  Future<TasksResponse> getTasks(@Query('userId') String userId, @Query('page') int page, @Query('size') int size, @Query('status') String status, @Query('sort') String sort, @Query('running') bool running, @Query('accessMode') String accessMode);

  @GET("/items/{itemId}")
  Future<Task> getTask(@Path('itemId') String taskId);

  @GET("/campaigns/{campaignId}")
  Future<Campaign> getCampaign(@Path('campaignId') String campaignId);
}