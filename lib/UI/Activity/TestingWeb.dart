// import 'package:easy_web_view/easy_web_view.dart';
import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx/webviewx.dart';
import 'dart:html' as html;

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
            _launchPrivacy(context);
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
 void _launchPrivacy(context) async {
    var ul = Provider.of<CartData>(context, listen: false).paymentdata['url'].toString();
   var urls =
       ul.toString();
   var url = Uri.encodeFull(urls);
   // var url = Uri.encodeComponent(urls);
   try {
     if (await canLaunch(url)) {
       print(Provider.of<CartData>(context, listen: false).paymentdata);
       await launch(url, forceSafariVC: false, forceWebView: false,enableJavaScript: true,headers: Provider.of<CartData>(context, listen: false).paymentdata);
       // html.window.open(url, 'new tab',);
     } else {
       throw 'Could not launch $url';
     }
   } catch (e) {
     await launch(url, forceSafariVC: false, forceWebView: false);
   }
 }
}
