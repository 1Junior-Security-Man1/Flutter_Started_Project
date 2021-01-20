class ConfirmTaskResponse {
  String _link;

  String get link => _link;

  ConfirmTaskResponse({
      String link}){
    _link = link;
}

  ConfirmTaskResponse.fromJson(dynamic json) {
    _link = json["link"];
  }
}