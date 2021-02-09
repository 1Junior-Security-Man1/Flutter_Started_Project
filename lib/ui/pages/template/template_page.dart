import 'package:bounty_hub_client/data/repositories/auth_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/welcome/cubit/welcome_cubit.dart';
import 'package:bounty_hub_client/ui/pages/welcome/widgets/welcome.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemplatePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocProvider(
        create: (_) => WelcomeCubit(context.repository<AuthRepository>(), context.repository<UserRepository>()),
        child: WelcomeWidget(),
      ),
    );
  }
}