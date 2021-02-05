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
  getTasks(queries) async {
    ArgumentError.checkNotNull(queries, 'queries');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
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
  getAllCampaign() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/campaigns/filtered?statusType=APPROVED&sort=position,desc&accessMode=PUBLIC',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CompanyListResponse.fromJson(_result.data);
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
  getUserTasks(campaignId, socialType, userId, page, size) async {
    ArgumentError.checkNotNull(campaignId, 'campaignId');
    ArgumentError.checkNotNull(socialType, 'socialType');
    ArgumentError.checkNotNull(userId, 'userId');
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(size, 'size');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'campaignId': campaignId,
      'socialNetwork': socialType,
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
  confirmAutoCheckTask(userId, userTaskId, redirectUrl, comment) async {
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
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/user-items/$userId/complete/$userTaskId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ConfirmTaskResponse.fromJson(_result.data);
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
  uploadImage(image) async {
    ArgumentError.checkNotNull(image, 'image');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.files.add(MapEntry(
        'image',
        MultipartFile.fromFileSync(image.path,
            filename: image.path.split(Platform.pathSeparator).last)));
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/images/upload/user',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ImageResponse.fromJson(_result.data);
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

  @override
  getUnreadActivitiesCount() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/notifications/unread',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NotificationCountResponse.fromJson(_result.data);
    return Future.value(value);
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

  @override
  retryTask(userItemId) async {
    ArgumentError.checkNotNull(userItemId, 'userItemId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'userItemId': userItemId};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/user-items/retry',
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
}
