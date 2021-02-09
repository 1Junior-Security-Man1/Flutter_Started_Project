import 'package:bounty_hub_client/data/models/api/response/trx_exchange_response.dart';
import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';

abstract class CampaignDataSource {

  Future<Campaign> getCampaign(String campaignId);

  Future<List<Campaign>> getAllCampaigns();

  Future<List<TrxExchangeResponse>> getTrxUsdExchange();
}