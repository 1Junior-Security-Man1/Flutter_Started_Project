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
        child: Text(
          message != null ? message :AppStrings.emptyDataMessage,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textColor),
        ),
    );
  }
}