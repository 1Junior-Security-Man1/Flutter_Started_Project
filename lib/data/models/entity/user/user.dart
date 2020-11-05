import 'package:bounty_hub_client/data/models/entity/user/balance.dart';
import 'package:bounty_hub_client/data/models/entity/user/roles.dart';
import 'package:bounty_hub_client/data/models/entity/user/social.dart';

class User {
  String id;
  String userBusinessEntityType;
  String name;
  String gender;
  String locationCountryCode;
  String birthday;
  String birthdayFormat; // todo type?
  String usedClient;
  String usedClientName;
  String clientId;
  String clientType; // todo type?
  String client; // todo type?
  bool enabled;
  String banInfo; // todo type?
  String banDate; // todo type?
  String status;
  String email;
  String company; // todo type?
  List<Balances> balances;
  String referralCode;
  String referralMasterId;
  String referralUserItemId;
  String referralCampaignId;
  bool referralPaid;
  bool firstLogin;
  int age; // todo type?
  String language;
  String agency;
  String website; // todo type?
  String domain;
  String ustIdNum; // todo type?
  String wallet; // todo type?
  String campaignName; // todo type?
  String walletApiKey; // todo type?
  String shortId;
  int shortNumber;
  int experiencePoints;
  String userLevel; // todo type?
  List<Socials> socials;
  String priceForPost; // todo type?
  double smv;
  String tronWallet; // todo type?
  bool tronWalletInternal;
  int createdDate;
  int lastModifiedDate;
  String createdBy;
  String lastModifiedBy;
  List<String> images; // todo type?
  List<Roles> roles;
  bool isVerifyMicroItems;
  bool admin;
  String socialHashTag;
  String roleType;
  bool moderator;

  User(
      {this.id,
      this.userBusinessEntityType,
      this.name,
      this.gender,
      this.locationCountryCode,
      this.birthday,
      this.birthdayFormat,
      this.usedClient,
      this.usedClientName,
      this.clientId,
      this.clientType,
      this.client,
      this.enabled,
      this.banInfo,
      this.banDate,
      this.status,
      this.email,
      this.company,
      this.balances,
      this.referralCode,
      this.referralMasterId,
      this.referralUserItemId,
      this.referralCampaignId,
      this.referralPaid,
      this.firstLogin,
      this.age,
      this.language,
      this.agency,
      this.website,
      this.domain,
      this.ustIdNum,
      this.wallet,
      this.campaignName,
      this.walletApiKey,
      this.shortId,
      this.shortNumber,
      this.experiencePoints,
      this.userLevel,
      this.socials,
      this.priceForPost,
      this.smv,
      this.tronWallet,
      this.tronWalletInternal,
      this.createdDate,
      this.lastModifiedDate,
      this.createdBy,
      this.lastModifiedBy,
      this.images,
      this.roles,
      this.isVerifyMicroItems,
      this.admin,
      this.socialHashTag,
      this.roleType,
      this.moderator});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userBusinessEntityType = json['userBusinessEntityType'];
    name = json['name'];
    gender = json['gender'];
    locationCountryCode = json['locationCountryCode'];
    birthday = json['birthday'];
    birthdayFormat = json['birthdayFormat'];
    usedClient = json['usedClient'];
    usedClientName = json['usedClientName'];
    clientId = json['clientId'];
    clientType = json['clientType'];
    client = json['client'];
    enabled = json['enabled'];
    banInfo = json['banInfo'];
    banDate = json['banDate'];
    status = json['status'];
    email = json['email'];
    company = json['company'];
    if (json['balances'] != null) {
      balances = new List<Balances>();
      json['balances'].forEach((v) {
        balances.add(Balances.fromJson(Map.from(v)));
      });
    }
    referralCode = json['referralCode'];
    referralMasterId = json['referralMasterId'];
    referralUserItemId = json['referralUserItemId'];
    referralCampaignId = json['referralCampaignId'];
    referralPaid = json['referralPaid'];
    firstLogin = json['firstLogin'];
    age = json['age'];
    language = json['language'];
    agency = json['agency'];
    website = json['website'];
    domain = json['domain'];
    ustIdNum = json['ustIdNum'];
    wallet = json['wallet'];
    campaignName = json['campaignName'];
    walletApiKey = json['walletApiKey'];
    shortId = json['shortId'];
    shortNumber = json['shortNumber'];
    experiencePoints = json['experiencePoints'];
    userLevel = json['userLevel'];
    if (json['socials'] != null) {
      socials = new List<Socials>();
      json['socials'].forEach((v) {
        socials.add(new Socials.fromJson(Map.from(v)));
      });
    }
    priceForPost = json['priceForPost'];
    smv = json['smv'];
    tronWallet = json['tronWallet'];
    tronWalletInternal = json['tronWalletInternal'];
    createdDate = json['createdDate'];
    lastModifiedDate = json['lastModifiedDate'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    if (json['images'] != null) {
      images = new List<String>();
      json['images'].forEach((v) {
        images.add((v));
      });
    }
    if (json['roles'] != null) {
      roles = new List<Roles>();
      json['roles'].forEach((v) {
        roles.add(new Roles.fromJson(Map.from(v)));
      });
    }
    isVerifyMicroItems = json['isVerifyMicroItems'];
    admin = json['admin'];
    socialHashTag = json['socialHashTag'];
    roleType = json['roleType'];
    moderator = json['moderator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userBusinessEntityType'] = this.userBusinessEntityType;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['locationCountryCode'] = this.locationCountryCode;
    data['birthday'] = this.birthday;
    data['birthdayFormat'] = this.birthdayFormat;
    data['usedClient'] = this.usedClient;
    data['usedClientName'] = this.usedClientName;
    data['clientId'] = this.clientId;
    data['clientType'] = this.clientType;
    data['client'] = this.client;
    data['enabled'] = this.enabled;
    data['banInfo'] = this.banInfo;
    data['banDate'] = this.banDate;
    data['status'] = this.status;
    data['email'] = this.email;
    data['company'] = this.company;
    if (this.balances != null) {
      data['balances'] = this.balances.map((v) => v.toJson()).toList();
    }
    data['referralCode'] = this.referralCode;
    data['referralMasterId'] = this.referralMasterId;
    data['referralUserItemId'] = this.referralUserItemId;
    data['referralCampaignId'] = this.referralCampaignId;
    data['referralPaid'] = this.referralPaid;
    data['firstLogin'] = this.firstLogin;
    data['age'] = this.age;
    data['language'] = this.language;
    data['agency'] = this.agency;
    data['website'] = this.website;
    data['domain'] = this.domain;
    data['ustIdNum'] = this.ustIdNum;
    data['wallet'] = this.wallet;
    data['campaignName'] = this.campaignName;
    data['walletApiKey'] = this.walletApiKey;
    data['shortId'] = this.shortId;
    data['shortNumber'] = this.shortNumber;
    data['experiencePoints'] = this.experiencePoints;
    data['userLevel'] = this.userLevel;
    if (this.socials != null) {
      data['socials'] = this.socials.map((v) => v.toJson()).toList();
    }
    data['priceForPost'] = this.priceForPost;
    data['smv'] = this.smv;
    data['tronWallet'] = this.tronWallet;
    data['tronWalletInternal'] = this.tronWalletInternal;
    data['createdDate'] = this.createdDate;
    data['lastModifiedDate'] = this.lastModifiedDate;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v).toList();
    }
    if (this.roles != null) {
      data['roles'] = this.roles.map((v) => v.toJson()).toList();
    }
    data['isVerifyMicroItems'] = this.isVerifyMicroItems;
    data['admin'] = this.admin;
    data['socialHashTag'] = this.socialHashTag;
    data['roleType'] = this.roleType;
    data['moderator'] = this.moderator;
    return data;
  }
}
