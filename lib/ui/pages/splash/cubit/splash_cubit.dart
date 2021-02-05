import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/app_data.dart';
import 'package:bounty_hub_client/data/models/api/response/trx_exchange_response.dart';
import 'package:bounty_hub_client/data/repositories/campaigns_repository.dart';
import 'package:bounty_hub_client/ui/pages/splash/cubit/splash_state.dart';
import 'package:logger/logger.dart';

class SplashCubit extends Cubit<SplashState> {

  final CampaignRepository _campaignRepository;
  var logger = Logger();

  SplashCubit(this._campaignRepository) : super(InitialState());

  void fetchTrxUsdExchange() async {
    _campaignRepository.getTrxUsdExchange()
        .then((values) {
          var equivalent = values.firstWhere((response) =>
              isUsdToTrxElement(response)).values?.firstWhere((element) => element.currencyCode == 'USD', orElse: () => null)?.value;
          AppData.instance.saveTrxEquivalent(equivalent);
          logger.d('TRX to USD equivalent: ' + equivalent.toString());
        })
        .catchError((Object obj) {
          logger.e(obj);
        });
  }

  bool isUsdToTrxElement(TrxExchangeResponse response) {
    return response.values.firstWhere((item) => item.currencyCode == 'USD', orElse: () => null) != null;
  }
}