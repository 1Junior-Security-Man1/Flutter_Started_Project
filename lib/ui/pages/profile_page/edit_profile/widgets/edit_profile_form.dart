import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:flutter/material.dart';

class EditProfileFormWidget extends StatelessWidget {
  final FocusNode node;
  final Widget child;

  const EditProfileFormWidget({
    Key key,
    this.child,
    this.node,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: child,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: node?.hasFocus?? false
                ? AppColors.participantsTextColor
                : AppColors.editProfileBorder),
        boxShadow: (node?.hasFocus??false) ? [WidgetsDecoration.appShadow] : [],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
