import 'dart:convert';
import 'dart:html';
import 'dart:ui' as ui;
//conditional import
import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/DioError.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/Order.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:craftyfashions_webapp/Utility/Users.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'UiFake.dart' if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CashfreeWebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("HErte   ${Provider.of<CartData>(context, listen: false).paymentdata}");
    ui.platformViewRegistry.registerViewFactory("rzp-html",(int viewId) {
      IFrameElement element=IFrameElement();

      window.onMessage.forEach((element) {
        print('Event Received in callback: ${element.data}');
        if(element.data=='MODAL_CLOSED'){
          Navigator.pop(context);
        }else if(element.data=='SUCCESS'){
          print('PAYMENT SUCCESSFULL!!!!!!!');
        }
      });

      element.requestFullscreen();
      // element.src='assets/Policy/RETURN AND REFUND POLICY_files/cashfree.html';
      element.src="https://payments-test.cashfree.com/order/#rdCBgNwuPeanYFUPyCd1";
      element.style.border = 'none';
      element.height = '500';
      element.width = '500';
      element.dataset = Provider.of<CartData>(context, listen: false).paymentdata;
      return element;
    });
    return Scaffold(
        body: Builder(builder: (BuildContext context) {
          return Container(
            child: AbsorbPointer(
                absorbing: true,child: HtmlElementView(viewType: 'rzp-html')),
          );
        }));
  }
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
        "NOT AVAILABLE",
        Provider.of<CartData>(context, listen: false)
            .getIndivisualPrice());
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
          CartData.RESULT = "assets/raw/successful.json";
          CartData.TXT = "Successful";
          CartData.id = response.orderId.toString();
          CartData.price = (Provider.of<CartData>(context, listen: false).getPrice()).toString();
          Test.fragNavigate.putPosit(key: 'Result');
          CartData.removeALL(0, CartData.listLengths);
        } else {
          // Navigator.pop(context);
          // Test.fragNavigate.putPosit(key: 'Result');
          CartData.RESULT = "assets/raw/failed.json";
          CartData.TXT = "Failed";
          CartData.id = response.orderId.toString();
          CartData.price = (Provider.of<CartData>(context, listen: false).getPrice() * 100).toString();
          Test.fragNavigate.putPosit(key: 'Result');
        }
      } on DioError catch (e) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        print(errorMessage);
      }
    } else {
      // Navigator.pop(context);
      CartData.RESULT = "assets/raw/failed.json";
      CartData.TXT = "Failed";
      CartData.id = response.orderId.toString();
      CartData.price = (Provider.of<CartData>(context, listen: false).getPrice()).toString();
      Test.fragNavigate.putPosit(key: 'Result');
    }
  }


}