// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://api.domain.io/api';
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
}
