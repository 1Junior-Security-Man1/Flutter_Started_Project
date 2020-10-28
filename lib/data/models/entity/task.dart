import 'package:bounty_hub_client/data/models/entity/task_category.dart';

class Task {
  String id;
  String ownerId;
  String description;
  String campaignId;
  String productName;
  String rewardType;
  double rewardAmount;
  String rewardCurrency;
  double budget;
  double leftBudget;
  String checkKey;
  String checkLink;
  bool onlyNewUsers;
  String achievementType;
  int confirmationDaysCount;
  String brief;
  String canDo;
  String forbiddenDo;
  bool running;
  String otherCategory;
  String otherType;
  bool autoCheck;
  String otherLink;
  List<Category> categories;
  int launchTime;
  double masterReward;
  bool hasPermissions;
  double finalRewardAmount;
  int participants;
  int numberInStock;
  double bhtAmount;
  String highlightDate;
  int waitingTimeToTaking;
  int experiencePoints;
  int campaignEndTime;
  String uri;

  Task.fromJson(dynamic json) {
    id = json["id"];
    ownerId = json["ownerId"];
    description = json["description"];
    campaignId = json["campaignId"];
    productName = json["productName"];
    rewardType = json["rewardType"];
    rewardAmount = json["rewardAmount"];
    rewardCurrency = json["rewardCurrency"];
    budget = json['budget'].toDouble();
    leftBudget = json['leftBudget'].toDouble();
    checkKey = json["checkKey"];
    checkLink = json["checkLink"];
    onlyNewUsers = json["onlyNewUsers"];
    achievementType = json["achievementType"];
    confirmationDaysCount = json["confirmationDaysCount"];
    brief = json["brief"];
    canDo = json["canDo"];
    forbiddenDo = json["forbiddenDo"];
    running = json["running"];
    otherCategory = json["otherCategory"];
    otherType = json["otherType"];
    autoCheck = json["autoCheck"];
    otherLink = json["otherLink"];
    launchTime = json["launchTime"];
    masterReward = json["masterReward"];
    hasPermissions = json["hasPermissions"];
    finalRewardAmount = json["finalRewardAmount"];
    participants = json["participants"];
    numberInStock = json["numberInStock"];
    bhtAmount = json["bhtAmount"];
    highlightDate = json["highlightDate"];
    waitingTimeToTaking = json["waitingTimeToTaking"];
    experiencePoints = json["experiencePoints"];
    campaignEndTime = json["campaignEndTime"];
    uri = json["uri"];
    if (json["categories"] != null) {
      categories = [];
      json["categories"].forEach((v) {
        categories.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["ownerId"] = ownerId;
    map["description"] = description;
    map["campaignId"] = campaignId;
    map["productName"] = productName;
    map["rewardType"] = rewardType;
    map["rewardAmount"] = rewardAmount;
    map["rewardCurrency"] = rewardCurrency;
    map["budget"] = budget;
    map["leftBudget"] = leftBudget;
    map["checkKey"] = checkKey;
    map["checkLink"] = checkLink;
    map["onlyNewUsers"] = onlyNewUsers;
    map["achievementType"] = achievementType;
    map["confirmationDaysCount"] = confirmationDaysCount;
    map["brief"] = brief;
    map["canDo"] = canDo;
    map["forbiddenDo"] = forbiddenDo;
    map["running"] = running;
    map["otherCategory"] = otherCategory;
    map["otherType"] = otherType;
    map["autoCheck"] = autoCheck;
    map["otherLink"] = otherLink;
    map["launchTime"] = launchTime;
    map["masterReward"] = masterReward;
    map["hasPermissions"] = hasPermissions;
    map["finalRewardAmount"] = finalRewardAmount;
    map["participants"] = participants;
    map["numberInStock"] = numberInStock;
    map["bhtAmount"] = bhtAmount;
    map["highlightDate"] = highlightDate;
    map["waitingTimeToTaking"] = waitingTimeToTaking;
    map["experiencePoints"] = experiencePoints;
    map["campaignEndTime"] = campaignEndTime;
    map["uri"] = uri;
    if (categories != null) {
      map["categories"] = categories.map((v) => v.toJson()).toList();
    }
    return map;
  }
}