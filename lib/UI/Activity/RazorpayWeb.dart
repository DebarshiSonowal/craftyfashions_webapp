import 'dart:convert';
import 'dart:html';

import 'package:craftyfashions_webapp/Helper/CartData.dart';
//conditional import
import 'package:craftyfashions_webapp/Helper/CashOrder.dart';
import 'package:craftyfashions_webapp/Helper/DioError.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/Order.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:craftyfashions_webapp/Utility/Users.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'UiFake.dart' if (dart.library.html) 'dart:ui' as ui;

class RazorPayWeb extends StatefulWidget {
  @override
  _RazorPayWebState createState() => _RazorPayWebState();
}

class _RazorPayWebState extends State<RazorPayWeb> {

  @override
  Widget build(BuildContext context) {

    //register view factory
    print("SG235");
     return Material(
       child: Scaffold(
           resizeToAvoidBottomInset : false,
           body: Builder(builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(bottom:50,),
          child: Provider.of<CartData>(context, listen: true).orderId != null
              ? HtmlElementView(viewType:'rzp-html',key: UniqueKey())
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

  getall (order) async{
   return await getTokenData(order);
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
        "NOT AVAILABLE");
  }

  getOrder(amount,context) {
    print("SGVAS");
    var order = CashOrder();
    order.customerName =
        Provider.of<CartData>(context, listen: false).user.name;
    order.customerEmail = 'debarkhisonowal@gmail.com';
    order.customerPhone = '8638372157';
    order.orderAmount = amount;
    order.stage = "PROD";
    return order;
  }

  getTokenData(CashOrder cashOrder) async {
    UsersModel usersModel = new UsersModel();
    return await usersModel.savePayment(cashOrder);
  }

  void getIt(order,context) async{
    print("SGVAS214");
    var data = await getall(order);
  setState(() {
    Map<String, String> options = {
      'paymentToken':
      data['body']['cftoken'].toString(),
      'appId':data['id'],
      'stage':data['status'],
      'price': (Provider.of<CartData>(context, listen: false).getPrice() * 100)
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
      order.orderId.toString()
          .substring(1, order.orderId.toString().length - 1),
      'orderNote': 'Crafty',
    };
    try {
      ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {
        IFrameElement element = IFrameElement();
        //Event Listener
        window.onMessage.forEach((element) {
          print('Event Received in callback: ${element.data}');
          if (element.data == 'MODAL_CLOSED') {
            print('Here');
            try {
              CartData.RESULT = "assets/raw/failed.json";
              CartData.TXT = "failed";
              Test.fragNavigate.putPosit(key: 'Result');
            } catch (e) {
              print(e);
            }
          } else if (element.data == 'SUCCESS') {
            print('PAYMENT SUCCESSFULL!!!!!!!${element.data} ');
            _handlePaymentSuccess(
                PaymentSuccessResponse(
                    element.data['data']['v1'].toString(),
                    element.data['data']['v2'].toString(),
                    element.data['data']['v3'].toString()),
                context);

          } else {
            _handlePaymentSuccess(
                PaymentSuccessResponse(
                    element.data['data']['v1'].toString(),
                    element.data['data']['v2'].toString(),
                    element.data['data']['v3'].toString()),
                context);
          }
        });
        window.onBlur.listen((e) {
          print(e.type);
          FocusManager.instance.primaryFocus.unfocus();
        });
        window.onFocus.listen((event) {
          print("Focus event ${event.type}");
        });

        window.onKeyUp.listen((event) {
          print("Keyboard event ${event.type}");
        });

        element.requestFullscreen();
        element.src = 'assets/Policy/RETURN AND REFUND POLICY_files/cashfree.html';
        element.style.border = 'none';
        element.dataset = options;
        element.sandbox;
        return element;
      });
    } catch (e) {
      print(e);
    }
  });
  }

  getWidget() async{
    await new Future.delayed(const Duration(seconds: 3));
    return ;
  }

  @override
  void initState() {
    CashOrder order = getOrder(Provider.of<CartData>(context, listen: false).getPrice(),context);
    getIt(order,context);
    super.initState();
  }
}
