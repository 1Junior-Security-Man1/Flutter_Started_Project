import 'package:bounty_hub_client/ui/pages/authorization/cubit/authorization_cubit.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bounty_hub_client/utils/validation/captcha.dart';

class CaptchaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: Text(
            AppStrings.completeCaptcha,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white,
                height: 1.3),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 80),
          height: 800,
          child: Captcha((String captchaCode) {
            context.bloc<AuthorizationCubit>().authenticate(captchaCode);
          }),
        ),
      ],
    );
  }
}