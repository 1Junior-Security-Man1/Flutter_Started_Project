import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/data/enums/user_task_status.dart';
import 'package:bounty_hub_client/data/models/entity/task/task_category.dart';
import 'package:bounty_hub_client/data/models/entity/user_task/user_task_payload.dart';
import 'package:enum_to_string/enum_to_string.dart';

class UserTask {
  String id;
  String itemId;
  String campaignId;
  String userId;
  String userItemStatus;
  String rewardType;
  double rewardAmount;
  String rewardCurrency;
  String description;
  String productName;
  int approveDate;
  bool autoCheck;
  List<Category> categories;
  double finalRewardAmount;
  String otherCategory;
  String otherType;
  bool deleted;
  String achievementType;
  String checkLink;
  dynamic imageId;
  UserTaskPayload payload;
  dynamic confirmationDaysCount;
  bool microItem;

  UserTask.fromJson(dynamic json) {
    id = json["id"];
    itemId = json["itemId"];
    campaignId = json["campaignId"];
    userId = json["userId"];
    userItemStatus = json["userItemStatus"];
    rewardType = json["rewardType"];
    rewardAmount = json["rewardAmount"];
    rewardCurrency = json["rewardCurrency"];
    description = json["description"];
    productName = json["productName"];
    approveDate = json["approveDate"];
    finalRewardAmount = json["finalRewardAmount"];
    autoCheck = json["autoCheck"];
    otherCategory = json["otherCategory"];
    otherType = json["otherType"];
    deleted = json["deleted"];
    achievementType = json["achievementType"];
    checkLink = json["checkLink"];
    imageId = json["imageId"];
    payload = json["payload"] != null ? UserTaskPayload.fromJson(json["payload"]) : null;
    if (json["categories"] != null) {
      categories = [];
      json["categories"].forEach((v) {
        categories.add(Category.fromJson(v));
      });
    }
    confirmationDaysCount = json["confirmationDaysCount"];
    microItem = json["microItem"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["itemId"] = itemId;
    map["campaignId"] = campaignId;
    map["userId"] = userId;
    map["userItemStatus"] = userItemStatus;
    map["rewardType"] = rewardType;
    map["rewardAmount"] = rewardAmount;
    map["rewardCurrency"] = rewardCurrency;
    map["description"] = description;
    map["finalRewardAmount"] = finalRewardAmount;
    map["productName"] = productName;
    map["approveDate"] = approveDate;
    map["autoCheck"] = autoCheck;
    map["otherCategory"] = otherCategory;
    map["otherType"] = otherType;
    map["deleted"] = deleted;
    map["achievementType"] = achievementType;
    map["checkLink"] = checkLink;
    map["imageId"] = imageId;
    map["confirmationDaysCount"] = confirmationDaysCount;
    map["microItem"] = microItem;
    if (categories != null) {
      map["categories"] = categories.map((v) => v.toJson()).toList();
    }
    return map;
  }

  UserTaskStatusType getTaskStatus() {
    return userItemStatus != null && userItemStatus.isNotEmpty
        ? EnumToString.fromString(UserTaskStatusType.values, userItemStatus.toUpperCase()) : UserTaskStatusType.IN_PROGRESS;
  }

  SocialNetworkType getSocialNetwork() {
    return categories != null && categories.isNotEmpty && categories.first.socialNetworkType != null
        ? EnumToString.fromString(SocialNetworkType.values, categories.first.socialNetworkType.toUpperCase()) : SocialNetworkType.OTHER;
  }
}