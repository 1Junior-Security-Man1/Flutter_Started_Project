import 'package:bounty_hub_client/network/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Captcha extends StatefulWidget{
  Function callback;
  Captcha(this.callback, {void Function(String secret) onCaptchaCompleted});

  @override
  State<StatefulWidget> createState() {
    return CaptchaState();
  }

}
class CaptchaState extends State<Captcha>{
  WebViewController webViewController;

  @override
  initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: WebView(
          initialUrl: Urls.captchaUrl,
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: Set.from([
            JavascriptChannel(
                name: 'Captcha',
                onMessageReceived: (JavascriptMessage message) {
                  widget.callback(message.message);
                })
          ]),
          onWebViewCreated: (WebViewController w) {
            webViewController = w;
          },
        )
    );
  }

}