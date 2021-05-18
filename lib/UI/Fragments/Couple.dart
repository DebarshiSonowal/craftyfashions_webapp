import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/EmptyView.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/ProductItemView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ProductView.dart';

class Couple extends StatefulWidget {
  @override
  _CoupleState createState() => _CoupleState();
}

class _CoupleState extends State<Couple> {
  get buttonSize => 20.0;
  @override
  void initState() {
    super.initState();

  }
  //EmptyListWidget(
  //         title: 'No Items',
  //         subTitle: 'No Items added to the cart',
  //         image: 'assets/images/404.png',
  //         titleTextStyle: TextStyle(
  //           color: Color(0xff9da9c7),
  //         ),
  //         subtitleTextStyle: TextStyle(
  //           color: Color(0xffabb8d6),
  //         ))
  @override
  Widget build(BuildContext context) {
    return Provider.of<CartData>(context, listen: false)
        .couple
        .length == 0? Container(
        height: 100,
        child: EmptyView(
          txt: 'No Items\nNo Items added to the cart',
        )):Container(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.width/(2.5)),
                        child: GridView.count(
                            scrollDirection: Axis.vertical,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            shrinkWrap: true,
                            children: List.generate(
                                Provider.of<CartData>(context, listen: false)
                                    .couple
                                    .length, (index) {
                              return ProductItemVIew(
                                  buttonSize: buttonSize,
                                  list: Provider.of<CartData>(context, listen: false)
                                      .couple,
                                  OnTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                            ProductView(
                                              product: Provider.of<CartData>(context, listen: false)
                                                  .couple[index],
                                              fragNav: Test.fragNavigate,
                                            )));
                                  },
                                  Index: index);
                            })),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
