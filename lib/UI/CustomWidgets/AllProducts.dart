import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/UI/Fragments/ProductView.dart';
import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AllProductsFragmentProductItemview.dart';

class AllProducts extends StatelessWidget {
  AllProducts();

  get buttonSize => 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            childAspectRatio: (MediaQuery.of(context).size.width) /
                (MediaQuery.of(context).size.height + 30),
            mainAxisSpacing: 5,
            primary: true,
            shrinkWrap: true,
            semanticChildCount: 2,
            children: List.generate(
                Provider.of<CartData>(context, listen: false)
                    .allproducts
                    .sublist(0, 4)
                    .length, (index) {
              return AllProductsFragmentProductItemView(
                  buttonSize: buttonSize,
                  list:
                  Provider.of<CartData>(context, listen: false)
                      .allproducts
                      .sublist(0, 4),
                  OnTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductView(
                                  product: Provider.of<CartData>(context,
                                          listen: false)
                                      .allproducts[index],
                                  fragNav: Test.fragNavigate,
                                )));
                  },
                  Index: index);
            })));
  }
  getSize(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width > 1024) {
      return 200;
    } else if (width <= kMobileBreakpoint) {
      return 180;
    } else {
      return 300;
    }
  }
}
