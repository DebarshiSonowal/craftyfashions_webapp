import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/AllProducts.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/CategoryData.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/LoadingAnimation.dart';
import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    print("Home page loading build");
    return kIsWeb
        ? SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Provider.of<CartData>(context, listen: true)
                            .getCateg()
                            .length ==
                        0
                    ? LoadingAnimation(
                        Provider.of<CartData>(context, listen: true)
                            .getCateg()
                            .length,
                        6,
                        MediaQuery.of(context).size.height / 3)
                    // ignore: missing_return
                    : CategoryData(showIndex, (index) {
                        if (Provider.of<CartData>(context, listen: false)
                                    .getCateg()[index]
                                    .name
                                    .toString()
                                    .trim() !=
                                'Men' &&
                            Provider.of<CartData>(context, listen: false)
                                    .getCateg()[index]
                                    .name
                                    .toString()
                                    .trim() !=
                                'Women') {
                          List<Products> list = [];
                          for (var i
                              in Provider.of<CartData>(context, listen: false)
                                  .allproducts) {
                            if (i.Gender.toString().trim().toUpperCase() ==
                                Provider.of<CartData>(context, listen: false)
                                    .getCateg()[index]
                                    .name
                                    .toString()
                                    .trim()
                                    .toUpperCase()) {
                              list.add(i);
                            }
                          }
                          Provider.of<CartData>(context, listen: false)
                              .setCouple(list);
                          Test.fragNavigate
                              .putPosit(key: 'Couple', force: true);
                        } else {
                          if (Provider.of<CartData>(context, listen: false)
                                  .getCateg()[index]
                                  .name
                                  .toString()
                                  .trim() ==
                              'Men') {
                            Test.fragNavigate.putPosit(key: 'Men', force: true);
                          } else {
                            Test.fragNavigate
                                .putPosit(key: 'Women', force: true);
                          }
                        }
                      }),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getAsset2(),
                        Flexible(
                            child: Text(
                          'Craft your own look\n with \nCrafty',
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Halyard",
                              fontSize: 24,
                              color: Colors.black),
                        ))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Products",
                        style: TextStyle(
                          fontFamily: "Halyard",
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            try {
                              Test.fragNavigate
                                  .putPosit(key: 'All', force: true);
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text(
                            "Show All",
                              style: TextStyle(
                                fontFamily: "Halyard",
                                color: Styles.price_color,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                          ))
                    ],
                  ),
                ),
                Provider.of<CartData>(context, listen: true)
                            .allproducts
                            .length ==
                        0
                    ? LoadingAnimation(
                        Provider.of<CartData>(context, listen: false)
                            .allproducts
                            .length,
                        5,
                        MediaQuery.of(context).size.height / 4)
                    : AllProducts(),
                SizedBox(
                  height: 15,
                ),
                Image.asset(
                  'assets/images/kk.jpg',
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 2,
                  color: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getAsset(),
                        Flexible(
                            child: Text(
                          'Stay Home\nStay Safe\nAnd order on Crafty 😉',
                          softWrap: true,
                          style: TextStyle(
                              fontFamily: "Halyard",
                              fontSize: 20,
                              color: Colors.red),
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            child: Text("No"),
          );
  }

  showIndex(int i) {
    List<Products> list = [];
    var tag = Provider.of<CartData>(context, listen: false).getAds()[i].tag;
    Test.specialTag = tag;
    Provider.of<CartData>(context, listen: false).setSpecialTag(tag);
    var all = Provider.of<CartData>(context, listen: false).allproducts;
    for (var i in all) {
      for (var j in i.Tags.toString().split(',')) {
        if (j.trim().toUpperCase() == tag.toString().trim().toUpperCase()) {
          list.add(i);
        }
      }
    }

    if (list.isNotEmpty) {
      setState(() {
        Provider.of<CartData>(context, listen: false).setSpecial(list);
      });
    } else {
      setState(() {
        Provider.of<CartData>(context, listen: false).setSpecial([]);
      });
    }
    Test.fragNavigate.putPosit(key: 'Special', force: true);
  }

  void addData(List<Products> data) {
    List<Products> men = [];
    List<Products> women = [];
    if (data != null) {
      for (var i in data) {
        if (i.Gender == "MALE") {
          men.add(i);
          print("MEN $i");
        } else {
          women.add(i);
          print("WOMEN $i");
        }
      }
      setState(() {
        Provider.of<CartData>(context, listen: false).setAllProduct(data);
        Provider.of<CartData>(context, listen: false).setMen(men);
        Provider.of<CartData>(context, listen: false).setWomen(women);
      });
    } else {
      print("empty");
    }
  }

  getAsset() {
    var width = MediaQuery.of(context).size.width;
    if (width < kTabletBreakpoint) {
      return Image.asset(
        "assets/images/mask.webp",
        height: 100,
        width: 120,
      );
    } else {
      return Lottie.asset('assets/raw/safe.json', height: 100, width: 120);
    }
  }

  getAsset2() {
    var width = MediaQuery.of(context).size.width;
    if (width < kTabletBreakpoint) {
      return Image.asset(
        "assets/images/shopping-cart.webp",
        height: 100,
        width: 120,
      );
    } else {
      return Lottie.asset('assets/raw/shoppingcart.json',
          height: 100, width: 120);
    }
  }

  getAsset3() {
    var width = MediaQuery.of(context).size.width;
    if (width < kTabletBreakpoint) {
      return Image.asset(
        "assets/images/favourite.webp",
        height: 100,
        width: 120,
      );
    } else {
      return Lottie.asset('assets/raw/like.json', height: 100, width: 120);
    }
  }
}
