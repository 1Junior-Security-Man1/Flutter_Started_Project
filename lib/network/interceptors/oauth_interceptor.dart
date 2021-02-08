import 'package:bounty_hub_client/app.dart';
import 'package:bounty_hub_client/bloc/auth/authentication_event.dart';
import 'package:bounty_hub_client/bloc/auth/authorization_bloc.dart';
import 'package:bounty_hub_client/data/app_data.dart';
import 'package:bounty_hub_client/network/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OauthInterceptor extends InterceptorsWrapper {

  @override
  Future onRequest(RequestOptions options) async {
    if(options.path.contains('/users/authenticate') || options.path.contains('/oauth/code')) {
      options.headers["Authorization"] = Constants.basicToken;
    } else {
      final String accessToken = await AppData.instance.getAccessToken();
      if(accessToken != null && accessToken.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $accessToken";
      }
    }
    return options;
  }

  @override
  Future onError(DioError error) async {
    if (error.response?.statusCode == 401 && !await AppData.instance.isGuestMode()) {
      BlocProvider.of<AuthenticationBloc>(AppState.getContext()).add(LoggedOut());
    }
    return super.onError(error);
  }
}