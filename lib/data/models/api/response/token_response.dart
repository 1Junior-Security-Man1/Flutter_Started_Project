class TokenResponse {
  String? _accessToken;
  String? _tokenType;
  int? _expiresIn;
  bool? _emailConfirmed;
  List<String>? _roles;
  String? _userId;
  String? _jti;

  String get accessToken => _accessToken!;
  String get tokenType => _tokenType!;
  int get expiresIn => _expiresIn!;
  bool get emailConfirmed => _emailConfirmed!;
  List<String> get roles => _roles!;
  String get userId => _userId!;
  String get jti => _jti!;

  TokenResponse({
      String? accessToken,
      String? tokenType,
      int? expiresIn,
      bool? emailConfirmed,
      List<String>? roles,
      String? userId,
      String? jti}){
    _accessToken = accessToken;
    _tokenType = tokenType;
    _expiresIn = expiresIn;
    _emailConfirmed = emailConfirmed;
    _roles = roles;
    _userId = userId;
    _jti = jti;
}

  TokenResponse.fromJson(dynamic json) {
    _accessToken = json["access_token"];
    _tokenType = json["token_type"];
    _expiresIn = json["expires_in"];
    _emailConfirmed = json["emailConfirmed"];
    _roles = json["roles"] != null ? json["roles"].cast<String>() : [];
    _userId = json["userId"];
    _jti = json["jti"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["access_token"] = _accessToken;
    map["token_type"] = _tokenType;
    map["expires_in"] = _expiresIn;
    map["emailConfirmed"] = _emailConfirmed;
    map["roles"] = _roles;
    map["userId"] = _userId;
    map["jti"] = _jti;
    return map;
  }
}