import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';

abstract class CampaignDataSource {

  Future<Campaign> getCampaign(String campaignId);

  Future<List<Campaign>> getAllCampaign();
}