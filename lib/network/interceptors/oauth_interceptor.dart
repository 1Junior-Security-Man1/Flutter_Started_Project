import 'package:bounty_hub_client/data/app_data.dart';
import 'package:bounty_hub_client/network/constants.dart';
import 'package:dio/dio.dart';

class OauthInterceptor extends InterceptorsWrapper {

  @override
  Future onRequest(RequestOptions options) async {
    if(options.path.contains('/users/authenticate') || options.path.contains('/oauth/code')) {
      options.headers["Authorization"] = Constants.basicToken;
    } else {
      final String accessToken = await AppData.instance.getAccessToken();
      if(accessToken != null && accessToken.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $accessToken";
        // TODO add refresh token
      }
    }
    return options;
  }
}