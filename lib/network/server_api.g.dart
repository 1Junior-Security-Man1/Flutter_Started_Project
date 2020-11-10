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

  @override
  getUserTask(userId, taskId, redirectUrl) async {
    ArgumentError.checkNotNull(userId, 'userId');
    ArgumentError.checkNotNull(taskId, 'taskId');
    ArgumentError.checkNotNull(redirectUrl, 'redirectUrl');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'redirectUrl': redirectUrl};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/users/$userId/item/$taskId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UserTask.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getUserTasks(userId, page, size) async {
    ArgumentError.checkNotNull(userId, 'userId');
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(size, 'size');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'userId': userId,
      'page': page,
      'size': size
    };
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/user-items/list',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UserTasksResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  takeTask(userId, taskId) async {
    ArgumentError.checkNotNull(userId, 'userId');
    ArgumentError.checkNotNull(taskId, 'taskId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/user-items/$userId/reserve/$taskId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UserTask.fromJson(_result.data);
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
  getMySocialAccounts() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request(
        '/users/my-social-accounts',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Socials.fromJson(i as Map<String, dynamic>))
        .toList();
    return Future.value(value);
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
  getActivities(page, size) async {
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(size, 'size');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'page': page, 'size': size};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/notifications/list',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NotificationResponse.fromJson(_result.data);
    return Future.value(value);
  }
}
