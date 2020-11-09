class Roles {
  String id;
  String title;
  String description;
  bool enabled;

  Roles({this.id, this.title, this.description, this.enabled});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['enabled'] = this.enabled;
    return data;
  }
}