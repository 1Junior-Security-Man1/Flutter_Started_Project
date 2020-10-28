class Category {
  String _id;
  String _name;
  dynamic _description;
  String _categoryType;
  String _socialNetworkType;
  bool _enabled;
  int _createdDate;
  int _lastModifiedDate;
  String _createdBy;
  String _lastModifiedBy;

  String get id => _id;

  String get name => _name;

  dynamic get description => _description;

  String get categoryType => _categoryType;

  String get socialNetworkType => _socialNetworkType;

  bool get enabled => _enabled;

  int get createdDate => _createdDate;

  int get lastModifiedDate => _lastModifiedDate;

  String get createdBy => _createdBy;

  String get lastModifiedBy => _lastModifiedBy;

  Category({
    String id,
    String name,
    dynamic description,
    String categoryType,
    String socialNetworkType,
    bool enabled,
    int createdDate,
    int lastModifiedDate,
    String createdBy,
    String lastModifiedBy}) {
    _id = id;
    _name = name;
    _description = description;
    _categoryType = categoryType;
    _socialNetworkType = socialNetworkType;
    _enabled = enabled;
    _createdDate = createdDate;
    _lastModifiedDate = lastModifiedDate;
    _createdBy = createdBy;
    _lastModifiedBy = lastModifiedBy;
  }

  Category.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _description = json["description"];
    _categoryType = json["categoryType"];
    _socialNetworkType = json["socialNetworkType"];
    _enabled = json["enabled"];
    _createdDate = json["createdDate"];
    _lastModifiedDate = json["lastModifiedDate"];
    _createdBy = json["createdBy"];
    _lastModifiedBy = json["lastModifiedBy"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["description"] = _description;
    map["categoryType"] = _categoryType;
    map["socialNetworkType"] = _socialNetworkType;
    map["enabled"] = _enabled;
    map["createdDate"] = _createdDate;
    map["lastModifiedDate"] = _lastModifiedDate;
    map["createdBy"] = _createdBy;
    map["lastModifiedBy"] = _lastModifiedBy;
    return map;
  }
}