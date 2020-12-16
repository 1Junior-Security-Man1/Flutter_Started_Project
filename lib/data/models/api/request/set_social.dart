class SetSocialRequest {
  String socialNetwork;
  String accountUrl;

  SetSocialRequest({this.socialNetwork, this.accountUrl});

  SetSocialRequest.fromJson(Map<String, dynamic> json) {
    socialNetwork = json['socialNetwork'];
    accountUrl = json['accountUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['socialNetwork'] = this.socialNetwork;
    data['accountUrl'] = this.accountUrl;
    return data;
  }
}