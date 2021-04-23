import 'package:flutter_starter/data/models/api/response/trx_exchange_response.dart';
import 'package:flutter_starter/data/models/entity/campaign/campaign.dart';

abstract class CampaignDataSource {

  Future<Campaign> getCampaign(String campaignId);

  Future<List<Campaign>> getAllCampaigns();

  Future<List<TrxExchangeResponse>> getTrxUsdExchange();
}