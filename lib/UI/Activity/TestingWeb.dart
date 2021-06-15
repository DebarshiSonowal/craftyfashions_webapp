// import 'package:easy_web_view/easy_web_view.dart';
import 'dart:js';

import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx/webviewx.dart';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:js/js_util.dart' as js_util;
class TestingWeb extends StatefulWidget {


  @override
  _TestingWebState createState() => _TestingWebState();
}

class _TestingWebState extends State<TestingWeb> {
 WebViewXController webviewController;

 @override
  void initState() {
   super.initState();
//
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          image: new DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.dstATop),
            image: AssetImage('assets/images/doodleWall.jpg'),
          ),
        ),
        child: Card(
          elevation: 1,
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                new BoxShadow(
                  color: Color(0xffE3E3E3),
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: FlatButton(
              child: Text("Confirm"),
              onPressed: () async{
                // UsersModel usersModel = UsersModel();
                // await usersModel.syncCart(Provider.of<CartData>(context, listen: false).list,Provider.of<CartData>(context, listen: false).user.id);
                _launchPrivacy(context);
              },
            ),
          ),
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

       // html.window.open(url, 'deb').addEventListener("message", (event) {
       //   html.MessageEvent event2 = event;
       //   print("WEven ${event2.data}");
       // });
       // js.context.callMethod('open', [url],);
       Test.fragNavigate.putPosit('Home');
       var popupLogin = js_util.callMethod(html.window, "open", [
         url,
       ]);

       js_util.callMethod(popupLogin, "addEventListener", [
         "click",
         allowInterop((event) {
           print("addEventListener click");
         })
       ]);
       // await launch(url, forceSafariVC: false, forceWebView: false,enableJavaScript: true,headers: Provider.of<CartData>(context, listen: false).paymentdata,enableDomStorage: true).whenComplete(() => {
       //   print("Done"),
       //   Provider.of<CartData>(context).removeAll(0, Provider.of<CartData>(context).list.length),
       //   Test.fragNavigate.putPosit('Home')
       // });
       // html.window.open(url, 'new tab',);
     } else {
       throw 'Could not launch $url';
     }
   } catch (e) {
     await launch(url, forceSafariVC: false, forceWebView: false);
   }
 }
}
