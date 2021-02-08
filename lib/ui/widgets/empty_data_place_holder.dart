import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';

class EmptyDataPlaceHolder extends StatelessWidget {

  final String message;

  const EmptyDataPlaceHolder({Key key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/place_holder.png',
            width: 180,
            height: 180,
          ),
          Text(
            message != null ? message : AppStrings.emptyDataMessage,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textColor),
          ),
         ],
      ),
    );
  }
}