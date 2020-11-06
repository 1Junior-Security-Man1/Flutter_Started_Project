import 'package:bounty_hub_client/data/enums/enum_decode.dart';
import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/data/enums/social_status_types.dart';

class Socials {
  String id;
  SocialNetworkType type;
  String accountUri;
  SocialStatusType status;
  int countSubscribers;
  String updateSubscribeStatus;
  int updateSubscribersTime;
  int lastModifiedDate;
  String sentSocialReport;
  String accountUrl;
  String validateStatus;
  String newAccountUrl;

  Socials(
      {this.id,
      this.type,
      this.accountUri,
      this.status,
      this.countSubscribers,
      this.updateSubscribeStatus,
      this.updateSubscribersTime,
      this.lastModifiedDate,
      this.sentSocialReport,
      this.accountUrl,
      this.validateStatus,
      this.newAccountUrl});

  Socials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = enumDecode<SocialNetworkType>(
      socialNetworkTypeEnumMap,
      json['type'],
    );
    accountUri = json['accountUri'];
    status = enumDecode<SocialStatusType>(
      socialStatusTypeEnumMap,
      json['status'],
    );
    countSubscribers = json['countSubscribers'];
    updateSubscribeStatus = json['updateSubscribeStatus'];
    updateSubscribersTime = json['updateSubscribersTime'];
    lastModifiedDate = json['lastModifiedDate'];
    sentSocialReport = json['sentSocialReport'];
    accountUrl = json['accountUrl'];
    validateStatus = json['validateStatus'];
    newAccountUrl = json['newAccountUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = socialNetworkTypeEnumMap[this.type];
    data['accountUri'] = this.accountUri;
    data['status'] = socialStatusTypeEnumMap[this.status];
    data['countSubscribers'] = this.countSubscribers;
    data['updateSubscribeStatus'] = this.updateSubscribeStatus;
    data['updateSubscribersTime'] = this.updateSubscribersTime;
    data['lastModifiedDate'] = this.lastModifiedDate;
    data['sentSocialReport'] = this.sentSocialReport;
    data['accountUrl'] = this.accountUrl;
    data['validateStatus'] = this.validateStatus;
    data['newAccountUrl'] = this.newAccountUrl;
    return data;
  }
}
