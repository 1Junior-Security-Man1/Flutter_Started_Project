import 'package:flutter_starter/data/models/entity/user/wallets.dart';

class Balances {
  String id;
  double amount;
  String currencyId;
  String currencyName;
  String userId;
  List<Wallets> wallets;
  bool withdrawEnabled;

  Balances(
      {this.id,
      this.amount,
      this.currencyId,
      this.currencyName,
      this.userId,
      this.wallets,
      this.withdrawEnabled});

  Balances.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    currencyId = json['currencyId'];
    currencyName = json['currencyName'];
    userId = json['userId'];
    if (json['wallets'] != null) {
      wallets = new List<Wallets>();
      json['wallets'].forEach((v) {
        wallets.add(Wallets.fromJson(Map.from(v)));
      });
    }
    withdrawEnabled = json['withdrawEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['currencyId'] = this.currencyId;
    data['currencyName'] = this.currencyName;
    data['userId'] = this.userId;
    if (this.wallets != null) {
      data['wallets'] = this.wallets.map((v) => v.toJson()).toList();
    }
    data['withdrawEnabled'] = this.withdrawEnabled;
    return data;
  }
}
