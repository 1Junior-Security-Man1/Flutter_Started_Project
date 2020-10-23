import 'dart:async';
import 'package:bounty_hub_client/ui/pages/dashboard/dashboard.dart';
import 'package:bounty_hub_client/ui/pages/login/view/login_page.dart';
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
    var duration = new Duration(seconds: 2);
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
        builder: (context) => DashboardPage()
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash screen',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}