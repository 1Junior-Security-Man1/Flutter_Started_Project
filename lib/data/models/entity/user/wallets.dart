class Wallets {
  String id;
  String walletId;
  String ownerId;
  String comment;

  Wallets({this.id, this.walletId, this.ownerId, this.comment});

  Wallets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletId = json['walletId'];
    ownerId = json['ownerId'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['walletId'] = this.walletId;
    data['ownerId'] = this.ownerId;
    data['comment'] = this.comment;
    return data;
  }
}