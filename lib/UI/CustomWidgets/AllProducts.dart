import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/UI/Fragments/ProductView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ProductItemView.dart';
class AllProducts extends StatelessWidget {
  const AllProducts({Key key}) : super(key: key);
  get buttonSize => 20.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 220,
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
            buttonSize: buttonSize,
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
                  MaterialPageRoute(builder: (context) =>
                      ProductView(
                          product: Provider.of<CartData>(context, listen: false)
                              .allproducts
                              .sublist(
                              0,
                              Provider.of<CartData>(context, listen: false)
                                  .allproducts
                                  .length ~/
                                  3)[index],
                          fragNav: Test.fragNavigate)));
            },
          );
        },
      ),
    );
  }
}
