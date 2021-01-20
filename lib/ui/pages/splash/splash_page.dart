import 'package:bounty_hub_client/bloc/locale/locale_bloc.dart';
import 'package:bounty_hub_client/bloc/locale/locale_event.dart';
import 'package:bounty_hub_client/data/repositories/preferences_local_repository.dart';
import 'package:bounty_hub_client/ui/pages/splash/cubit/splash_cubit.dart';
import 'package:bounty_hub_client/ui/pages/splash/widgets/splash_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    PreferencesLocalProvider().initPref().then((value) {
      context.bloc<LocaleBloc>().add(LoadSavedLocale());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SplashCubit(),
        child: SplashContent(),
      ),
    );
  }
}