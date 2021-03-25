import 'package:bounty_hub_client/ui/pages/authorization/widgets/authorization.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';

class AuthorizationPage extends StatelessWidget {

  final String confirmCode;
  final String email;

  AuthorizationPage({this.email, this.confirmCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: AuthorizationWidget(email: email, confirmCode: confirmCode),
    );
  }
}