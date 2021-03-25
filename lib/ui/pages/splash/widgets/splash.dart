import 'dart:async';
import 'package:bounty_hub_client/bloc/auth/authentication_event.dart';
import 'package:bounty_hub_client/bloc/auth/authorization_bloc.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_links/uni_links.dart';
import 'package:bounty_hub_client/utils/validation/string_utils.dart';

class SplashWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=> _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {

  @override
  void initState() {
    super.initState();
    getDeepLinks();
  }

  getDeepLinks() async {
    String email = parseUrl(await getInitialLink(), 'email');
    String confirmCode = parseUrl(await getInitialLink(), 'code');
    startNavigateWithDelay(email, confirmCode);
  }

  startNavigateWithDelay(String email, String confirmCode) async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, () {
      if(context != null) {
        BlocProvider.of<AuthenticationBloc>(context)
            .add(AppLoaded(deepLinkEmail: email, deepLinkConfirmCode: confirmCode));
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
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/page_bg.png'),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Image.asset('assets/images/bountyhub.png', width: MediaQuery.of(context).size.width / 3),
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
        )
    );
  }
}