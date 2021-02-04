import 'package:bounty_hub_client/bloc/auth/authentication_event.dart';
import 'package:bounty_hub_client/bloc/auth/authorization_bloc.dart';
import 'package:bounty_hub_client/ui/pages/welcome/widgets/social_button_widget.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=> _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: AppColors.white,
          child: Column(
            children: [
              Expanded(
                flex: 4,
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
                      margin: EdgeInsets.only(bottom: 80.0),
                      child: Center(
                        child: Image.asset('assets/images/bountyhub.png', width: MediaQuery.of(context).size.width / 3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 110.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('Log In / Register to',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Colors.white,
                              height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 85.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('BountyHub Platform',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.white,
                              height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialButtonWidget(asset: 'assets/images/email.png', onClick: () => {
                            BlocProvider.of<AuthenticationBloc>(context).add(SelectAuthenticationType(type: AuthenticationType.credentials))
                          }),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: SocialButtonWidget(asset: 'assets/images/social_media_facebook.png', enabled: false),
                          ),
                          SocialButtonWidget(asset: 'assets/images/social_media_google.png', enabled: false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Stack(
                    children: [
                      Container(
                        child: Center(
                          child: Text('OR CONTINUE AS GUEST',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.greyContentColor,
                              fontWeight: FontWeight.w700,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
