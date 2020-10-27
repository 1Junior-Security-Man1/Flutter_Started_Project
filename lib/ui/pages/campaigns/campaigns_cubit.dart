import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/campaigns_repository.dart';
import 'package:bounty_hub_client/ui/pages/campaigns/campaigns_state.dart';

class CampaignCubit extends Cubit<CampaignsState> {

  final CampaignRepository _campaignRepository;

  CampaignCubit(this._campaignRepository) : super(CampaignsState());
}