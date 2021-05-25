import 'package:cached_network_image/cached_network_image.dart';
import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/EmptyView.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/ProductItemView.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'ProductView.dart';

class BlankPage extends StatefulWidget {
  const BlankPage({Key key}) : super(key: key);

  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> with TickerProviderStateMixin {
  var selectedSize = "1";

  @override
  Widget build(BuildContext context) {
    print(
        "price ${Provider.of<CartData>(context).noOfTotalItems * 699} and ${Provider.of<CartData>(context).getPrice()}");
    return Container(
      color: Color(0xffE3E3E3),
      child: Provider.of<CartData>(context, listen: true)
          .list
          .length>0?Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  color:Colors.white,
                  width: 150,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.shoppingBag),
                      Text("Shopping Cart"),
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Provider.of<CartData>(context, listen: true)
                          .list
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
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
                              height: 200,
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 12,
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 3,
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 8,
                                                      right: 14,
                                                      left: 14),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.fill,
                                                    imageUrl:
                                                        Provider.of<CartData>(
                                                                context)
                                                            .list[index]
                                                            .picture,
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                downloadProgress) =>
                                                            SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child: SpinKitCubeGrid(
                                                        color: Styles
                                                            .price_color,
                                                        size: 50.0,
                                                        controller: AnimationController(
                                                            vsync: this,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        1200)),
                                                      ),
                                                    ),
                                                    errorWidget: (context,
                                                            url, error) =>
                                                        Icon(Icons.error),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 5,
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 8),
                                                            child: Text(
                                                              "${Provider.of<CartData>(context).list[index].name}",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Halyard",
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          )),
                                                      Expanded(
                                                        flex: 8,
                                                        child: Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Color:",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Halyard",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w200,
                                                                        color: Colors
                                                                            .black45),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 16,
                                                                        bottom:
                                                                            12),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          "Size:  ",
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: TextStyle(
                                                                              fontFamily: "Halyard",
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w200,
                                                                              color: Colors.black45),
                                                                        ),
                                                                        Text(
                                                                          "${Provider.of<CartData>(context).list[index].size}",
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: TextStyle(
                                                                              fontFamily: "Halyard",
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w200,
                                                                              color: Colors.black),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Price: ",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Halyard",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w200,
                                                                        color: Colors
                                                                            .black45),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 7,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    "${Provider.of<CartData>(context).list[index].color}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Halyard",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w200,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        "Qty:  ",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "Halyard",
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w200,
                                                                            color: Colors.black45),
                                                                      ),
                                                                      DropdownButton<
                                                                          String>(
                                                                        focusColor:
                                                                            Colors.white,
                                                                        value: Provider.of<CartData>(context)
                                                                            .list[index]
                                                                            .quantity
                                                                            .toString(),
                                                                        //elevation: 5,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "Halyard",
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w200,
                                                                            color: Colors.black),
                                                                        iconEnabledColor:
                                                                            Colors.black,
                                                                        items: getLabels().map<
                                                                            DropdownMenuItem<
                                                                                String>>((String
                                                                            value) {
                                                                          return DropdownMenuItem<
                                                                              String>(
                                                                            value:
                                                                                value,
                                                                            child:
                                                                                Text(
                                                                              "${value}",
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                          );
                                                                        }).toList(),
                                                                        hint:
                                                                            Text(
                                                                          "",
                                                                          style: TextStyle(
                                                                              fontFamily: "Halyard",
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w200,
                                                                              color: Colors.black),
                                                                        ),
                                                                        onChanged:
                                                                            (String
                                                                                value) {
                                                                          setState(
                                                                              () {
                                                                            Provider.of<CartData>(context, listen: false).list[index].setQuantity =
                                                                                int.parse(value.toString());
                                                                          });
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    "${Provider.of<CartData>(context).list[index].payment}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Halyard",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w200,
                                                                        color: Styles
                                                                            .price_color),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 1, bottom: 1, left: 8, right: 8),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            width: .1,
                                            color: Color(0xffb2b2b2),
                                          ),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Provider.of<CartData>(context, listen: false)
                                              .removeProduct(index);
                                          Styles.showWarningToast(
                                              Styles.Log_sign, "Item removed", Colors.black, 15);
                                        },
                                        style: ButtonStyle(
                                          enableFeedback: true,
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shadowColor:
                                              MaterialStateProperty.all(
                                                  Color(0xffE3E3E3)),
                                          elevation:
                                              MaterialStateProperty.all(2),
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              20,
                                          child: Center(
                                            child: Text("Remove",
                                                style: TextStyle(
                                                    fontFamily: "Halyard",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w200,
                                                    color: Colors.black)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      }),
                ),
                Card(
                  elevation: 1.5,
                  child: Container(
                    height: 170,
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
                            padding: EdgeInsets.only(left: 10),
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
                                  padding:EdgeInsets.only(left: 10,right: 35),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total MRP",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Halyard",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w200,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "Delivery Charge",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Halyard",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w200,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "Discount on MRP",
                                            textAlign: TextAlign.start,
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
                                        CrossAxisAlignment
                                            .end,
                                        children: [
                                          Text(
                                            "₹${Provider.of<CartData>(context).noOfTotalItems * 699}",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontFamily: "Halyard",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "Free",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontFamily: "Halyard",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "${getDiscount(context).toInt()}%",
                                            textAlign: TextAlign.end,
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
                                  padding:EdgeInsets.only(left: 10,right: 35),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .end,
                                        children: [
                                          Text(
                                            "Total amount",
                                            style: TextStyle(
                                                fontFamily: "Halyard",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .end,
                                        children: [
                                          Text(
                                            "₹${Provider.of<CartData>(context).getPrice()}",
                                            style: TextStyle(
                                                fontFamily: "Halyard",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  "Yay ! You saved ₹${((Provider.of<CartData>(context).noOfTotalItems * 699)-(Provider.of<CartData>(context).getPrice()).toInt())}",
                                  style: TextStyle(
                                      fontFamily: "Halyard",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Styles.price_color),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(elevation: 1, child: allproducts()),
                // remaining stuffs
              ]),
            ),
          ),
          Card(
            elevation: 1,
            child: Container(

              decoration: BoxDecoration(
                color: Colors.white,
                // color: Color(0xffE3E3E3),
                boxShadow: [
                  new BoxShadow(
                    color: Color(0xffE3E3E3),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                top: 4,
              ),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          enableFeedback: true,
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                )
                            ),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xffE3E3E3)),
                          shadowColor:
                              MaterialStateProperty.all(Color(0xffE3E3E3)),
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
                            child: Text("Continue Shopping",
                                style: TextStyle(
                                    fontFamily: "Halyard",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 2,
                      child: Container(
                        margin: EdgeInsets.all(2),
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              isDismissible: true,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return Card(
                                  child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Card(
                                         child: Container(
                                           color: Color(0xff6d6d6d),
                                           child: Column(
                                             children: [
                                               Text(""),
                                             ],
                                           ),
                                         ),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        style: ButtonStyle(
                          enableFeedback: true,
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                )
                            ),
                          backgroundColor:
                              MaterialStateProperty.all(Styles.price_color),
                          shadowColor:
                              MaterialStateProperty.all(Color(0xffE3E3E3)),
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
                            child: Text("Select Address",
                                style: TextStyle(
                                    fontFamily: "Halyard",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ):EmptyView(txt: "Please add some items to the cart",),
    );
  }

  Widget allproducts() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: Color(0xffE3E3E3),
            blurRadius: 5.0,
          ),
        ],
      ),
      height: 270,
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 20,right:37),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("All products"),
                    TextButton(onPressed: () {
                      Test.fragNavigate
                          .putPosit(key: 'All', force: true);
                    }, child: Text("Show all"))
                  ],
                ),
              )),
          Expanded(
            flex: 8,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: Provider.of<CartData>(context, listen: true)
                  .allproducts
                  .sublist(
                      0,
                      Provider.of<CartData>(context, listen: false)
                              .allproducts
                              .length ~/
                          3)
                  .length,
              itemBuilder: (BuildContext ctxt, int index) {
                return ProductItemVIew(
                  buttonSize: 20,
                  list: Provider.of<CartData>(context, listen: true)
                      .allproducts
                      .sublist(
                          0,
                          Provider.of<CartData>(context, listen: false)
                                  .allproducts
                                  .length ~/
                              3),
                  Index: index,
                  OnTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductView(
                                product: Provider.of<CartData>(context,
                                        listen: false)
                                    .allproducts
                                    .sublist(
                                        0,
                                        Provider.of<CartData>(context,
                                                    listen: false)
                                                .allproducts
                                                .length ~/
                                            3)[index],
                                fragNav: Test.fragNavigate)));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  getDiscount(context) {
    int post = (Provider.of<CartData>(context).getPrice()).toInt();
    int pre = (Provider.of<CartData>(context).noOfTotalItems * 699);

    return (pre - post) / pre * 100;
  }

  getLabels() {
    return ['1', '2', '3', '4', '5'];
  }
}
