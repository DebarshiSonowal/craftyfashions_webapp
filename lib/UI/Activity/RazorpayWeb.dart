import 'dart:convert';
import 'dart:html';

//conditional import
import 'package:craftyfashions_webapp/Helper/DioError.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/Order.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:craftyfashions_webapp/Utility/Users.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'UiFake.dart' if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter/material.dart';

class RazorPayWeb extends StatefulWidget {
  RazorPayWeb();

  @override
  _RazorPayWebState createState() => _RazorPayWebState();
}

class _RazorPayWebState extends State<RazorPayWeb> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> options = {
      'key':
          Provider.of<CartData>(context, listen: false).razorpay.Id.toString(),
      'amount': (Provider.of<CartData>(context, listen: false).getPrice() * 100)
          .toString(),
      'address': Provider.of<CartData>(context, listen: false).profile.address,
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
      'order_id':
          Provider.of<CartData>(context, listen: false).orderId.toString(),
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
          // _handlePaymentSuccess(PaymentSuccessResponse(id:element.data));
          Navigator.pop(context);
        } else {
          _handlePaymentSuccess(
              PaymentSuccessResponse(
                  element.data['data']['v1'].toString(),
                  element.data['data']['v2'].toString(),
                  element.data['data']['v3'].toString()),
              context);
        }
      });

      element.requestFullscreen();
      element.src = 'assets/assets/Policy/payment.html';
      element.style.border = 'none';
      element.allowFullscreen=true;
      element.dataset = options;
      // element.onClick;
      element.id=UniqueKey().toString();
      document.addEventListener('touchstart', (en){
        print("AndA ${en.type}");
      });
      return element;
    });
     return Material(
       child: Scaffold(body: Builder(builder: (BuildContext context) {
        return Container(
          child: Provider.of<CartData>(context, listen: true).orderId != null
              ? SizedBox(
            height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: HtmlElementView(viewType: 'rzp-html',key: UniqueKey(),))
              : Center(
                  child: Text(
                    "Please try again",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
        );
    })),
     );
  }

  _handlePaymentSuccess(
      PaymentSuccessResponse response, BuildContext context) async {
    Styles.showWarningToast(Colors.green, "Successful", Colors.white, 15);
    Map data = {
      'orderId': response.orderId,
      'paymentId': response.paymentId,
      'signature': response.signature,
    };
    var body = json.encode(data);
    UsersModel usersModel = UsersModel();
    var b = await usersModel.saveOrder(body);
    if (b["result"].toString().trim() == "Successful") {
      try {
        UsersModel usersModel = UsersModel();
        var a = await usersModel.saveOrderDatabase(
            saveToDatabase(
                response.orderId,
                Provider.of<CartData>(context, listen: false).getPrice() * 100,
                response.paymentId,
                context),
            Provider.of<CartData>(context, listen: false).name == null
                ? Provider.of<CartData>(context, listen: false).user.name
                : Provider.of<CartData>(context, listen: false).name);
        if (a != null && a != "Unable to save order") {
          // Navigator.pop(context);
          CartData.removeALL(0, CartData.listLengths);
          CartData.RESULT = "assets/raw/successful.json";
          CartData.TXT = response.paymentId;
          Test.fragNavigate.putPosit(key: 'Result');
        } else {
          // Navigator.pop(context);
          Test.fragNavigate.putPosit(key: 'Result');
          CartData.RESULT = "assets/raw/failed.json";
          CartData.TXT = response.orderId;
          Test.fragNavigate.putPosit(key: 'Result');
        }
      } on DioError catch (e) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        print(errorMessage);
      }
    } else {
      // Navigator.pop(context);
      CartData.RESULT = "assets/raw/failed.json";
      CartData.TXT = "Payment ID" + response.orderId;
      Test.fragNavigate.putPosit(key: 'Result');
    }
  }

  _handlePaymentError(PaymentFailureResponse response) {}

  Order saveToDatabase(id, double amount, String status, BuildContext context) {
    return Order(
        Provider.of<CartData>(context, listen: false).Colours,
        "15-02-21",
        Provider.of<CartData>(context, listen: false).Names,
        Provider.of<CartData>(context, listen: false).user.email,
        status,
        Provider.of<CartData>(context, listen: false).ids,
        Provider.of<CartData>(context, listen: false)
            .Pictures
            .split(",")[0]
            .trim(),
        amount,
        Provider.of<CartData>(context, listen: false).quantity,
        Provider.of<CartData>(context, listen: false).Sizes,
        "Preparing",
        id,
        Provider.of<CartData>(context, listen: false).user.id,
        Provider.of<CartData>(context, listen: false).getAddress.address,
        Provider.of<CartData>(context, listen: false).getAddress.phone,
        Provider.of<CartData>(context, listen: false).getAddress.pin,
        "NOT AVAILABLE");
  }
}
