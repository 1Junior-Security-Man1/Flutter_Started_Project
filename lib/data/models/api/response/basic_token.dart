class BasicToken {
  String token;

  BasicToken({
      this.token});

  BasicToken.fromJson(dynamic json) {
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["token"] = token;
    return map;
  }

}