import 'package:flutter_starter/data/enums/social_networks_types.dart';
import 'package:flutter_starter/data/models/entity/task/task_category.dart';
import 'package:enum_to_string/enum_to_string.dart';

abstract class BaseTask {
  String id;
  double rewardAmount;
  double finalRewardAmount;
  double usdEquivalent;
  String productName;
  List<Category> categories;
  String rewardCurrency;
  String itemId;

  SocialNetworkType getSocialNetwork() {
    return categories != null &&
            categories.isNotEmpty &&
            categories.first.socialNetworkType != null
        ? EnumToString.fromString(SocialNetworkType.values,
            categories.first.socialNetworkType.toUpperCase())
        : SocialNetworkType.OTHER;
  }
}
