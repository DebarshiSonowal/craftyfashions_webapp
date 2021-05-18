import 'dart:html';
import 'dart:ui' as ui;

//conditional import
import 'package:provider/provider.dart';
import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'UiFake.dart' if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter/material.dart';

class RazorPayWeb extends StatelessWidget {
  var id;

  RazorPayWeb(this.id);

  @override
  Widget build(BuildContext context) {
    Map<String,String> options = {
      'key':
          Provider.of<CartData>(context, listen: false).razorpay.Id.toString(),
      'amount': (Provider.of<CartData>(context, listen: false).getPrice() * 100).toString(),
      'address': Provider.of<CartData>(context, listen: false)
          .profile
          .address,
      'phone': Provider.of<CartData>(context, listen: false)
          .profile
          .phone
          .toString(),
      'name':
          Provider.of<CartData>(context, listen: false).profile.name.toString(),
      'email': Provider.of<CartData>(context, listen: false)
          .profile
          .email
          .toString(),
      'order_id': id.toString(),
      'name': 'Crafty',
      'description': Provider.of<CartData>(context, listen: false).names,
    };
    //register view factory
    ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {
      IFrameElement element = IFrameElement();
//Event Listener
      window.onMessage.forEach((element) {
        print('Event Received in callback: ${element.data}');
        if (element.data == 'MODAL_CLOSED') {
          Navigator.pop(context);
        } else if (element.data == 'SUCCESS') {
          print('PAYMENT SUCCESSFULL!!!!!!!${element.data} ');
          Navigator.pop(context);
        }
      });

      element.requestFullscreen();
      element.src = 'assets/Policy/payment.html';
      element.style.border = 'none';
      element.dataset = options;
      return element;
    });
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return Container(
        child: HtmlElementView(viewType: 'rzp-html'),
      );
    }));
  }
}
