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
  getTasks(userId, page, size, status, sort, running, accessMode) async {
    ArgumentError.checkNotNull(userId, 'userId');
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(size, 'size');
    ArgumentError.checkNotNull(status, 'status');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(running, 'running');
    ArgumentError.checkNotNull(accessMode, 'accessMode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'userId': userId,
      'page': page,
      'size': size,
      'status': status,
      'sort': sort,
      'running': running,
      'accessMode': accessMode
    };
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/items/filtered',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TasksResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getTask(taskId) async {
    ArgumentError.checkNotNull(taskId, 'taskId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/items/$taskId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Task.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getCampaign(campaignId) async {
    ArgumentError.checkNotNull(campaignId, 'campaignId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/campaigns/$campaignId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Campaign.fromJson(_result.data);
    return Future.value(value);
  }
}
