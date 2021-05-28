import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentOptionsMethod extends StatefulWidget {
  var paymentMethod;
  Function(int) onTap;

  PaymentOptionsMethod({this.paymentMethod, this.onTap});

  @override
  _PaymentOptionsMethodState createState() => _PaymentOptionsMethodState();
}

class _PaymentOptionsMethodState extends State<PaymentOptionsMethod> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // height: MediaQuery.of(context).,
      padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Select a payment method",
              style: TextStyle(
                  fontFamily: "Halyard",
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1.5,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Color(0xffE3E3E3),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            radius: MediaQuery.of(context).size.width + 10,
                            splashColor: Colors.black,
                            enableFeedback: true,
                            onTap: () => widget.onTap(index),
                            child: Container(
                                height: 90,
                                width: MediaQuery.of(context).size.width - 10,
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    "${widget.paymentMethod[index]}",
                                    style: TextStyle(
                                        fontFamily: "Halyard",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Styles.price_color),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                enableFeedback: true,
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )),
                backgroundColor: MaterialStateProperty.all(Styles.price_color),
                shadowColor: MaterialStateProperty.all(Color(0xffE3E3E3)),
                elevation: MaterialStateProperty.all(4),
                overlayColor: MaterialStateProperty.resolveWith(
                  (states) {
                    return states.contains(MaterialState.pressed)
                        ? Color(0xffE3E3E3)
                        : null;
                  },
                ),
              ),
              child: Container(
                child: Center(
                  child: Text("Close",
                      style: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
