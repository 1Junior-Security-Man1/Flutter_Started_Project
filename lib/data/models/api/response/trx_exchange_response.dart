class TrxExchangeResponse {
  List<Values> values;

  TrxExchangeResponse({
      this.values});

  TrxExchangeResponse.fromJson(dynamic json) {
    if (json["values"] != null) {
      values = [];
      json["values"].forEach((v) {
        values.add(Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (values != null) {
      map["values"] = values.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Values {
  String currencyCode;
  double value;

  Values({
      this.currencyCode, 
      this.value});

  Values.fromJson(dynamic json) {
    currencyCode = json["currencyCode"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["currencyCode"] = currencyCode;
    map["value"] = value;
    return map;
  }

}