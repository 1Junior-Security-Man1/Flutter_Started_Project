import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';
import 'package:bounty_hub_client/data/source/campaign_data_source.dart';
import 'package:bounty_hub_client/network/server_api.dart';

class CampaignRepository extends CampaignDataSource {

  final RestClient client;

  CampaignRepository(this.client);

  @override
  Future<Campaign> getCampaign(String campaignId) {
    return client.getCampaign(campaignId);
  }

  @override
  Future<List<Campaign>> getAllCampaign() async {
    return (await client.getAllCampaign()).content;
  }
}