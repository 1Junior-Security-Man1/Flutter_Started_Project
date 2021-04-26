import 'package:flutter_starter/ui/pages/authorization/widgets/authorization.dart';
import 'package:flutter_starter/utils/ui/colors.dart';
import 'package:flutter/material.dart';

class AuthorizationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: AuthorizationWidget(),
    );
  }
}
