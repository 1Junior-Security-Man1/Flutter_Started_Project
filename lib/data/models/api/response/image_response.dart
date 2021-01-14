class ImageResponse {
  String _id;
  dynamic _userId;
  int _position;
  dynamic _thumbnailFullName;
  String _createdDate;
  String _lastModifiedDate;

  String get id => _id;
  dynamic get userId => _userId;
  int get position => _position;
  dynamic get thumbnailFullName => _thumbnailFullName;
  String get createdDate => _createdDate;
  String get lastModifiedDate => _lastModifiedDate;

  ImageResponse({
      String id, 
      dynamic userId, 
      int position, 
      dynamic thumbnailFullName, 
      String createdDate, 
      String lastModifiedDate}){
    _id = id;
    _userId = userId;
    _position = position;
    _thumbnailFullName = thumbnailFullName;
    _createdDate = createdDate;
    _lastModifiedDate = lastModifiedDate;
}

  ImageResponse.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["userId"];
    _position = json["position"];
    _thumbnailFullName = json["thumbnailFullName"];
    _createdDate = json["createdDate"];
    _lastModifiedDate = json["lastModifiedDate"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["userId"] = _userId;
    map["position"] = _position;
    map["thumbnailFullName"] = _thumbnailFullName;
    map["createdDate"] = _createdDate;
    map["lastModifiedDate"] = _lastModifiedDate;
    return map;
  }

}