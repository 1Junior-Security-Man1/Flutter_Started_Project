// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://api.bountyhub.io/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getAuthenticateCode(authRequest) async {
    ArgumentError.checkNotNull(authRequest, 'authRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(authRequest?.toJson() ?? <String, dynamic>{});
    await _dio.request<void>('api/users/authenticate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }
}
