// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://api.bountyhub.io/api';
  }

  final Dio _dio;

  String baseUrl;

  @override
  authenticate(authRequest) async {
    ArgumentError.checkNotNull(authRequest, 'authRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(authRequest?.toJson() ?? <String, dynamic>{});
    await _dio.request<void>('/users/authenticate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }

  @override
  confirmCode(email, code, grantType) async {
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(code, 'code');
    ArgumentError.checkNotNull(grantType, 'grantType');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'email': email,
      'code': code,
      'grant_type': grantType
    };
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/oauth/code',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TokenResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  confirmSocialParserTask(
      userId, userTaskId, redirectUrl, comment, imageId) async {
    ArgumentError.checkNotNull(userId, 'userId');
    ArgumentError.checkNotNull(userTaskId, 'userTaskId');
    ArgumentError.checkNotNull(redirectUrl, 'redirectUrl');
    ArgumentError.checkNotNull(comment, 'comment');
    ArgumentError.checkNotNull(imageId, 'imageId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'redirectUrl': redirectUrl,
      'comment': comment,
      'imageId': imageId
    };
    final _data = <String, dynamic>{};
    final Response<String> _result = await _dio.request(
        '/user-items/$userId/complete/$userTaskId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return Future.value(value);
  }

  @override
  reconfirmAutoCheckTask(userId, userTaskId, redirectUrl, comment) async {
    ArgumentError.checkNotNull(userId, 'userId');
    ArgumentError.checkNotNull(userTaskId, 'userTaskId');
    ArgumentError.checkNotNull(redirectUrl, 'redirectUrl');
    ArgumentError.checkNotNull(comment, 'comment');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'redirectUrl': redirectUrl,
      'comment': comment
    };
    final _data = <String, dynamic>{};
    final Response<String> _result = await _dio.request(
        '/user-items/$userId/confirm-complete/$userTaskId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return Future.value(value);
  }

  @override
  getUser({userId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/users/$userId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = User.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  putUser(userId, updatedUser) async {
    ArgumentError.checkNotNull(userId, 'userId');
    ArgumentError.checkNotNull(updatedUser, 'updatedUser');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(updatedUser?.toJson() ?? <String, dynamic>{});
    await _dio.request<void>('/users/$userId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }

  @override
  setSocial(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body?.toJson() ?? <String, dynamic>{});
    await _dio.request<void>('/users/set-social-account',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }

  @override
  removeSocial(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/users/social/$id/delete',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }

  @override
  readNotification(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/notifications/notification/$id/read',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }

  @override
  leaveTask(userId, userTaskId) async {
    ArgumentError.checkNotNull(userId, 'userId');
    ArgumentError.checkNotNull(userTaskId, 'userTaskId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<String> _result = await _dio.request(
        '/user-items/$userId/leave/$userTaskId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return Future.value(value);
  }
}
