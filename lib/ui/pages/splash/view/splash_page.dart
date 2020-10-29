import 'package:bounty_hub_client/ui/pages/splash/splash_cubit.dart';
import 'package:bounty_hub_client/ui/pages/splash/view/splash_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  final bool authorized;

  const SplashPage(this.authorized);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SplashCubit(),
        child: SplashContent(authorized),
      ),
    );
  }
}