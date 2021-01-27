class UserLevel {
  String id;
  String name;
  int minExperience;
  int maxExperience;
  double itemBonus;
  int microItemCommission;
  bool canWithdrawTokens;
  bool participateInVipCampaigns;
  bool priorityCheck;
  int position;
  String createdBy;
  dynamic userExperience;
  dynamic buyExperiencePoints;
  dynamic experiencePointCostInBHT;
  bool isUserLevel;
  dynamic waitingTime;

  UserLevel(
    {this.id,
      this.name,
      this.minExperience,
      this.maxExperience,
      this.itemBonus,
      this.microItemCommission,
      this.canWithdrawTokens,
      this.participateInVipCampaigns,
      this.priorityCheck,
      this.position,
      this.createdBy,
      this.userExperience,
      this.buyExperiencePoints,
      this.experiencePointCostInBHT,
      this.isUserLevel,
      this.waitingTime});

  UserLevel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minExperience = json['minExperience'];
    maxExperience = json['maxExperience'];
    itemBonus = json['itemBonus'];
    microItemCommission = json['microItemCommission'];
    canWithdrawTokens = json['canWithdrawTokens'];
    participateInVipCampaigns = json['participateInVipCampaigns'];
    priorityCheck = json['priorityCheck'];
    position = json['position'];
    createdBy = json['createdBy'];
    userExperience = json['userExperience'];
    buyExperiencePoints = json['buyExperiencePoints'];
    experiencePointCostInBHT = json['experiencePointCostInBHT'];
    isUserLevel = json['isUserLevel'];
    waitingTime = json['waitingTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['minExperience'] = this.minExperience;
    data['maxExperience'] = this.maxExperience;
    data['itemBonus'] = this.itemBonus;
    data['microItemCommission'] = this.microItemCommission;
    data['canWithdrawTokens'] = this.canWithdrawTokens;
    data['participateInVipCampaigns'] = this.participateInVipCampaigns;
    data['priorityCheck'] = this.priorityCheck;
    data['position'] = this.position;
    data['createdBy'] = this.createdBy;
    data['userExperience'] = this.userExperience;
    data['buyExperiencePoints'] = this.buyExperiencePoints;
    data['experiencePointCostInBHT'] = this.experiencePointCostInBHT;
    data['isUserLevel'] = this.isUserLevel;
    data['waitingTime'] = this.waitingTime;
    return data;
  }
}