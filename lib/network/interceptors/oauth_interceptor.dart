import 'package:flutter_starter/app.dart';
import 'package:flutter_starter/bloc/auth/authentication_event.dart';
import 'package:flutter_starter/bloc/auth/authorization_bloc.dart';
import 'package:flutter_starter/data/app_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class OauthInterceptor extends InterceptorsWrapper {
  final log = Logger();

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains('/users/authenticate') ||
        options.path.contains('/oauth/code')) {
      options.headers["Authorization"] =
          'Basic ' + '<basic token>'; // add basic token here
      log.d('Basic token: ' + options.headers["Authorization"]);
    } else {
      final String? accessToken = await AppData.instance.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $accessToken";
      }
    }
    return options;
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      BlocProvider.of<AuthenticationBloc>(AppState.getContext())
          .add(LoggedOut());
    }
    return super.onError(err, handler);
  }
}