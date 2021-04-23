import 'package:flutter_starter/data/models/api/response/trx_exchange_response.dart';
import 'package:flutter_starter/data/models/entity/campaign/campaign.dart';
import 'package:flutter_starter/data/source/campaign_data_source.dart';
import 'package:flutter_starter/network/server_api.dart';

class CampaignRepository extends CampaignDataSource {

  final RestClient client;

  CampaignRepository(this.client);

  @override
  Future<Campaign> getCampaign(String campaignId) {
    return client.getCampaign(campaignId);
  }

  @override
  Future<List<Campaign>> getAllCampaigns() async {
    return (await client.getAllCampaign()).content;
  }

  @override
  Future<List<TrxExchangeResponse>> getTrxUsdExchange() {
    return client.getTrxExchange();
  }
}