// import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx/webviewx.dart';

class TestingWeb extends StatefulWidget {


  @override
  _TestingWebState createState() => _TestingWebState();
}

class _TestingWebState extends State<TestingWeb> {
 WebViewXController webviewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: FlatButton(
          child: Text("AD"),
          onPressed: (){
            _launchPrivacy();
          },
        ),
        // child: WebViewX(
        //   javascriptMode: JavascriptMode.unrestricted,
        //   onWebResourceError: (we){
        //     print(we);
        //   },
        //   height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        //   initialContent: "https://payments-test.cashfree.com/order/#rdCBgNwuPeanYFUPyCd1",
        //   initialSourceType: SourceType.URL_BYPASS,
        //   onWebViewCreated: (controller) => webviewController = controller,
        // ),
        // child: EasyWebView(
        //   src: "https://payments-test.cashfree.com/order/#rdCBgNwuPeanYFUPyCd1",
        //   convertToWidgets: true,
        //   webAllowFullScreen: true,
        //   onLoaded: (){
        //     print("WEb");
        //   },
        //
        // ),
      ),
    );
  }
 void _launchPrivacy() async {
   const urls =
       'https://payments-test.cashfree.com/order/#L1S6tYOfX1MoIPT5hWUA';
   var url = Uri.encodeFull(urls);
   // var url = Uri.encodeComponent(urls);
   try {
     if (await canLaunch(url)) {
       await launch(url, forceSafariVC: false, forceWebView: false);
     } else {
       throw 'Could not launch $url';
     }
   } catch (e) {
     await launch(url, forceSafariVC: false, forceWebView: false);
   }
 }
}
