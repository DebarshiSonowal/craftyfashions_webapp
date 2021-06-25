import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:craftyfashions_webapp/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' as kIsWeb;

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
//Zakaria Jawas
//utsav
//Abby Ambrogi
  var RESULT;

  @override
  Widget build(BuildContext context) {
    setState(() {
      RESULT = CartData.RESULT;
    });
    print(CartData.RESULT);
    return Material(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffE3E3E6),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color(0xffFAFAFA),
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.1), BlendMode.dstATop),
                      image: AssetImage('assets/images/doodleWall.jpg'),
                    ),
                  ),
                ),
                Wrap(
                  children: [
                    Card(
                      elevation: 1.5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          boxShadow: [
                            new BoxShadow(
                              color: Color(0xffE3E3E3),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width - 40,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 12),
                                child: Icon(
                                  FontAwesomeIcons.smile,
                                  size: 65,
                                  color: getColor(),
                                ),
                              ),
                              Text(
                                getMsg(),
                                style: TextStyle(
                                    fontFamily: "Halyard",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: getColor()),
                              ),
                              getSecondMSg(),
                              getEmail(),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getButton(),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Test.fragNavigate.putPosit(key: 'Home');
                                        },
                                        style: ButtonStyle(
                                          enableFeedback: true,
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero,
                                          )),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Styles.price_color),
                                          shadowColor:
                                              MaterialStateProperty.all(
                                                  Color(0xffE3E3E3)),
                                          elevation:
                                              MaterialStateProperty.all(4),
                                          overlayColor:
                                              MaterialStateProperty.resolveWith(
                                            (states) {
                                              return states.contains(
                                                      MaterialState.pressed)
                                                  ? Color(0xffE3E3E3)
                                                  : null;
                                            },
                                          ),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 4,
                                              right: 4,
                                              top: 7,
                                              bottom: 7),
                                          child: Center(
                                            child: Text("Continue Shopping",
                                                style: TextStyle(
                                                    fontFamily: "Halyard",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  @override
  void initState() {
    // updateOrder();
    super.initState();
    print("AVAVvv ${getAsset()}");
//
  }

  getAsset() {
    if (CartData.TXT == "Successful") {
      return FontAwesomeIcons.smile;
    } else {
      return FontAwesomeIcons.sadTear;
    }
  }

  getSecondMSg() {
    if (CartData.TXT == "Successful") {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Order ID: ",
                style: TextStyle(
                    fontFamily: "Halyard",
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              Text(
                "${CartData.id}",
                style: TextStyle(
                    fontFamily: "Halyard",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Order Amount: ",
                style: TextStyle(
                    fontFamily: "Halyard",
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              Text(
                "${CartData.price}",
                style: TextStyle(
                    fontFamily: "Halyard",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),

        ],
      );
    } else {
      return Column(
        children: [
          Text(
            "We could not process your order.",
            style: TextStyle(
                fontFamily: "Halyard",
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.black54),
          ),
          Text(
            "We regret the inconvenience",
            style: TextStyle(
                fontFamily: "Halyard",
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.black54),
          ),
          Text(
            "Please Try Again",
            style: TextStyle(
                fontFamily: "Halyard",
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.black54),
          ),
        ],
      );
    }
  }

  getColor() {
    if (CartData.TXT == "Successful") {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  void updateOrder() async {
    UsersModel usersModel = UsersModel();
    var order = await usersModel.getOrdersforUser(
        Provider.of<CartData>(context, listen: false).user.id);
    if (order != null) {
      if (mounted) {
        setState(() {
                Provider.of<CartData>(context, listen: false).orders(order);
              });
      } else {
        Provider.of<CartData>(context, listen: false).orders(order);
      }
    }
  }

  getPadding() {
    var width = MediaQuery.of(context).size.width;
    kTabletBreakpoint > width
        ? EdgeInsets.only(top: MediaQuery.of(context).size.height / 4)
        : EdgeInsets.only(top: MediaQuery.of(context).size.width / 4);
  }

  String getMsg() {
    if (CartData.TXT == "Successful") {
      return "Order placed successfully";
    } else {
      return "Sorry";
    }
  }

  getEmail() {
    if (CartData.TXT== "Successful") {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: Container(
                color: Color(0xffE4E4E7),
              ),
              height: 1.5,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Text(
            "A confirmation email has been sent to",
            style: TextStyle(
                fontFamily: "Halyard",
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.black54),
          ),
          Text(
            "${Provider.of<CartData>(context).profile.email}",
            style: TextStyle(
                fontFamily: "Halyard",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        ],
      );
    }else {
      return Container();
    }
  }

  getButton() {
    if (CartData.TXT== "Successful") {
      return Expanded(
        child: ElevatedButton(
          onPressed: () {
            Test.fragNavigate.putPosit(key: 'Orders');
          },
          style: ButtonStyle(
            enableFeedback: true,
            shape: MaterialStateProperty.all<
                RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )),
            backgroundColor:
            MaterialStateProperty.all(
                Colors.white),
            shadowColor:
            MaterialStateProperty.all(
                Color(0xffE3E3E3)),
            elevation:
            MaterialStateProperty.all(4),
            overlayColor:
            MaterialStateProperty.resolveWith(
                  (states) {
                return states.contains(
                    MaterialState.pressed)
                    ? Color(0xffE3E3E3)
                    : null;
              },
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(
                left: 4,
                right: 4,
                top: 7,
                bottom: 7),
            child: Center(
              child: Text("View Order history",
                  style: TextStyle(
                      fontFamily: "Halyard",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ),
          ),
        ),
      );
    }else {
      return Expanded(
        child: ElevatedButton(
          onPressed: () {
            Test.fragNavigate.putPosit(key: 'Cart');
          },
          style: ButtonStyle(
            enableFeedback: true,
            shape: MaterialStateProperty.all<
                RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )),
            backgroundColor:
            MaterialStateProperty.all(
                Colors.white),
            shadowColor:
            MaterialStateProperty.all(
                Color(0xffE3E3E3)),
            elevation:
            MaterialStateProperty.all(4),
            overlayColor:
            MaterialStateProperty.resolveWith(
                  (states) {
                return states.contains(
                    MaterialState.pressed)
                    ? Color(0xffE3E3E3)
                    : null;
              },
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(
                left: 4,
                right: 4,
                top: 7,
                bottom: 7),
            child: Center(
              child: Text("Go back",
                  style: TextStyle(
                      fontFamily: "Halyard",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ),
          ),
        ),
      );
    }
  }
}
// Flexible(
//     flex: 1,
//     child: Center(
//       child: Text(
//         "Your order has been placed",
//         style: TextStyle(
//           fontSize: 14,
//         ),
//       ),
//     )),
// Flexible(
//     flex: 1,
//     child: Center(
//       child: Text(
//         "The Reference ID is ${CartData.TXT}",
//         style: TextStyle(
//           fontSize: 14,
//         ),
//       ),
//     )),
// Flexible(
//     flex: 1,
//     child: Center(
//       child: Text(
//         "Do not close this",
//         style: TextStyle(
//           fontSize: 14,
//         ),
//       ),
//     )),
// Flexible(
//     flex: 4,
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child:
//       ElevatedButton(onPressed: () {
//         if (RESULT!="assets/raw/loading.json") {
//           Test.fragNavigate.putPosit(key: 'Home');
//           RESULT="assets/raw/loading.json";
//         } else {
//           Styles.showWarningToast(Styles.bg_color, "Please Wait", Colors.black, 15);
//         }
//       }, child: Text("Next")),
//     )),
