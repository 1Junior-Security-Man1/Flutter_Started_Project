import 'package:flutter_starter/network/constants.dart';

String getImageUrl(String imageId) {
  return Constants.baseApiUrl + '/api/images/' + (imageId??'') + '/download';
}
