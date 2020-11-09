import 'dart:async';

import 'file:///D:/Code/Code/Flutter/BountyHub/bounty_hub_client/lib/ui/pages/login/login_page.dart';
import 'package:bounty_hub_client/ui/pages/main/view/main_page.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatefulWidget {
  final bool authorized;

  const SplashContent(this.authorized);

  @override
  State<StatefulWidget> createState()=> _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {

  @override
  void initState() {
    super.initState();
    startNavigateWithDelay();
  }

  startNavigateWithDelay() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, () {
      if(widget.authorized) {
        navigateToMainPage();
      } else {
        navigateToLoginPage();
      }
    });
  }

  navigateToLoginPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginPage()
    )
    );
  }

  navigateToMainPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => MainPage()
    )
    );
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
                        child: Image.asset('assets/images/bountyhub.png', width: MediaQuery.of(context).size.width / 3,),
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