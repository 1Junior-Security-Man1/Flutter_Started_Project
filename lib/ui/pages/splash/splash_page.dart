import 'package:flutter_starter/bloc/locale/locale_bloc.dart';
import 'package:flutter_starter/bloc/locale/locale_event.dart';
import 'package:flutter_starter/data/repositories/preferences_local_repository.dart';
import 'package:flutter_starter/ui/pages/splash/cubit/splash_cubit.dart';
import 'package:flutter_starter/ui/pages/splash/widgets/splash.dart';
import 'package:flutter_starter/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.microtask(() {
      context.bloc<SplashCubit>().fetchTrxUsdExchange();
      PreferencesLocalProvider().initPref().then((value) {
        context.bloc<LocaleBloc>().add(LoadSavedLocale());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentColor,
      body: SplashWidget(),
    );
  }
}