import 'dart:convert';

import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'CartItems.dart';

class CartScreenn extends StatefulWidget {
  int item;
  Function save, onOrderInit;

  CartScreenn({this.item, this.save, this.onOrderInit});

  @override
  _CartScreennState createState() => _CartScreennState();
}

class _CartScreennState extends State<CartScreenn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffE2E2E5),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                      child: Text(
                    "Shopping Cart",
                    style: TextStyle(fontSize: 25),
                  )),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                    child: IconButton(
                      iconSize: 30,
                      splashRadius: 30,
                      onPressed: () {
                        setState(() {
                          Provider.of<CartData>(context, listen: false)
                              .removeAll(0, widget.item);
                          Styles.showWarningToast(Styles.Log_sign,
                              "All items removed", Colors.black, 15);
                        });
                      },
                      enableFeedback: true,
                      splashColor: Colors.redAccent,
                      icon: Icon(
                        FontAwesomeIcons.trash,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Want to add more?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      icon: Icon(
                        FontAwesomeIcons.plus,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Test.fragNavigate.putPosit(key: 'Home', force: true);
                      })
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              width: MediaQuery.of(context).size.width / (.5),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: Provider.of<CartData>(context).listLength,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (item) {
                      Styles.showWarningToast(
                          Styles.Log_sign, "Item removed", Colors.black, 15);
                      setState(() {
                        Provider.of<CartData>(context, listen: false)
                            .removeProduct(index);
                        var json = jsonEncode(
                            Provider.of<CartData>(context, listen: false)
                                .list
                                .map((e) => e.toJson())
                                .toList());
                        widget.save("data", json);
                      });
                    },
                    child: CartItem(
                      th: false,
                      index: index,
                      list: Provider.of<CartData>(context).list,
                      callback: () {
                        Styles.showWarningToast(
                            Styles.Log_sign, "Item removed", Colors.black, 15);
                        setState(() {
                          Provider.of<CartData>(context, listen: false)
                              .removeProduct(index);
                          var json = jsonEncode(
                              Provider.of<CartData>(context, listen: false)
                                  .list
                                  .map((e) => e.toJson())
                                  .toList());
                          widget.save("data", json);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Card(
              elevation: 1.5,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    new BoxShadow(
                      color: Color(0xffE3E3E3),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 2),
                        child: Row(
                          children: [
                            Text(
                              "(${Provider.of<CartData>(context).listLength}) Items",
                              style: TextStyle(
                                  fontFamily: "Halyard",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total MRP",
                                        style: TextStyle(
                                            fontFamily: "Halyard",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "Delivery Charge",
                                        style: TextStyle(
                                            fontFamily: "Halyard",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "Discount",
                                        style: TextStyle(
                                            fontFamily: "Halyard",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Styles.price_color),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "₹${Provider.of<CartData>(context).listLength * 699}",
                                        style: TextStyle(
                                            fontFamily: "Halyard",
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "Free",
                                        style: TextStyle(
                                            fontFamily: "Halyard",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "- ₹${(Provider.of<CartData>(context).listLength * 699) - Provider.of<CartData>(context).getPrice()}",
                                        style: TextStyle(
                                            fontFamily: "Halyard",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Styles.price_color),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 1, bottom: 1),
                              child: SizedBox(
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Total amount",
                                    style: TextStyle(
                                        fontFamily: "Halyard",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "₹${Provider.of<CartData>(context).getPrice()}",
                                    style: TextStyle(
                                        fontFamily: "Halyard",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    new BoxShadow(
                      color: Color(0xffE3E3E3),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: FlatButton(
                minWidth: MediaQuery.of(context).size.width,
                splashColor: Colors.white,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(6.0)),
                padding: EdgeInsets.all(8),
                color: Colors.deepOrangeAccent,
                onPressed: widget.onOrderInit,
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
