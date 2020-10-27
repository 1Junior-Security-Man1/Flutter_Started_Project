import 'package:bounty_hub_client/data/source/campaign_data_source.dart';
import 'package:bounty_hub_client/network/server_api.dart';

class CampaignRepository extends CampaignDataSource {

  final RestClient client;

  CampaignRepository(this.client);
}