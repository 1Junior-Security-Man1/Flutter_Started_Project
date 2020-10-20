import 'package:bounty_hub_client/data/models/api/request/auth_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'server_api.g.dart';

@RestApi(baseUrl: "https://api.bountyhub.io/api/")
abstract  class RestClient {

  factory RestClient({String baseUrl}){
    Dio dio = Dio();
    dio.options = BaseOptions(receiveTimeout: 30000, connectTimeout: 30000);
    return _RestClient(dio, baseUrl: baseUrl);
  }

  @POST("api/users/authenticate")
  Future<void> getAuthenticateCode(@Body() AuthRequest authRequest);
}