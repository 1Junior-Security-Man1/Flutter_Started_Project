import 'package:flutter_starter/data/models/api/request/auth_request.dart';
import 'package:flutter_starter/data/models/api/response/token_response.dart';
import 'package:flutter_starter/data/models/entity/user/user.dart';
import 'package:flutter_starter/network/interceptors/oauth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'server_api.g.dart';

@RestApi(baseUrl: "https://api.domain.io/api")
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

  @GET("/users/{userId}")
  Future<User> getUser({@Path('userId') String userId});

  @PUT("/users/{userId}")
  Future<void> putUser(@Path('userId') String userId, @Body() User updatedUser);
}
