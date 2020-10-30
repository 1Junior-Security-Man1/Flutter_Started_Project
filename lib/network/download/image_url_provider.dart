import 'package:bounty_hub_client/network/constants.dart';

String getImageUrl(String imageId) {
  return Constants.baseApiUrl + '/api/images/' + imageId + '/download';
}
