import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/UI/Fragments/ProductView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ProductItemView.dart';

class AllProductsHoz extends StatelessWidget {
  const AllProductsHoz({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.only(left: 20, right: 37),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("All products"),
                    TextButton(
                        onPressed: () {
                          Test.fragNavigate.putPosit(key: 'All', force: true);
                        },
                        child: Text("Show all"))
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
}
