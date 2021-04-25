import 'dart:io';
import 'package:flutter_starter/data/models/api/request/auth_request.dart';
import 'package:flutter_starter/data/models/api/request/set_social.dart';
import 'package:flutter_starter/data/models/api/response/token_response.dart';
import 'package:flutter_starter/data/models/entity/user/user.dart';
import 'package:flutter_starter/network/interceptors/oauth_interceptor.dart';
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

  @GET("/user-items/{userId}/complete/{userTaskId}")
  Future<String> confirmSocialParserTask(@Path('userId') String userId,
      @Path('userTaskId') String userTaskId, @Query('redirectUrl') String redirectUrl,
      @Query('comment') String comment, @Query('imageId') String imageId);

  @GET("/user-items/{userId}/confirm-complete/{userTaskId}")
  Future<String> reconfirmAutoCheckTask(@Path('userId') String userId,
      @Path('userTaskId') String userTaskId, @Query('redirectUrl') String redirectUrl,
      @Query('comment') String comment);

  @GET("/users/{userId}")
  Future<User> getUser({@Path('userId') String userId});

  @PUT("/users/{userId}")
  Future<void> putUser(@Path('userId') String userId, @Body() User updatedUser);

  @POST("/users/set-social-account")
  Future<void> setSocial(@Body() SetSocialRequest body);

  @DELETE("/users/social/{id}/delete")
  Future<void> removeSocial(@Path('id') String id);

  @PUT("/notifications/notification/{id}/read")
  Future<void> readNotification(@Path('id') id);

  @PUT("/user-items/{userId}/leave/{userTaskId}")
  Future<String> leaveTask(@Path('userId') String userId, @Path('userTaskId') String userTaskId);
}
