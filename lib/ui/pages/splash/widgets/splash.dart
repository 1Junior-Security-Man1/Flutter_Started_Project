import 'dart:async';
import 'package:flutter_starter/bloc/auth/authentication_event.dart';
import 'package:flutter_starter/bloc/auth/authorization_bloc.dart';
import 'package:flutter_starter/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();
    startNavigateWithDelay();
  }

  startNavigateWithDelay() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, () {
      if (context != null) {
        BlocProvider.of<AuthenticationBloc>(context).add(AppLoaded());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: AppColors.white,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  child: Center(
                    child: Image.asset('assets/images/logo.png',
                        width: MediaQuery.of(context).size.width / 2),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    ));
  }
}
