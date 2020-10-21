class AuthRequest {
  String _checkCode;
  String _captchaType;
  String _secret;
  String _email;
  String _domain;

  String get checkCode => _checkCode;
  String get captchaType => _captchaType;
  String get secret => _secret;
  String get email => _email;
  String get domain => _domain;

  AuthRequest(
      String email,
      String checkCode,
      String captchaType,
      String secret,
      String domain){
    _checkCode = checkCode;
    _captchaType = captchaType;
    _secret = secret;
    _email = email;
    _domain = domain;
}

  AuthRequest.fromJson(dynamic json) {
    _checkCode = json["checkCode"];
    _captchaType = json["captchaType"];
    _secret = json["secret"];
    _email = json["email"];
    _domain = json["domain"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["checkCode"] = _checkCode;
    map["captchaType"] = _captchaType;
    map["secret"] = _secret;
    map["email"] = _email;
    map["domain"] = _domain;
    return map;
  }

}