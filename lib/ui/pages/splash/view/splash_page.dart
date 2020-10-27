import 'dart:async';
import 'package:bounty_hub_client/ui/pages/campaigns/view/campaigns_page.dart';
import 'package:bounty_hub_client/ui/pages/login/view/login_page.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  final bool authorized;

  const SplashPage(this.authorized);

  @override
  State<StatefulWidget> createState()=> _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    startNavigateWithDelay();
  }

  startNavigateWithDelay() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, () {
      if(widget.authorized) {
        navigateToDashboardPage();
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

  navigateToDashboardPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => CampaignsPage()
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.backgroundColor,
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