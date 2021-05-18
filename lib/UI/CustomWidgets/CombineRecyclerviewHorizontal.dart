
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/UI/Fragments/ProductView.dart';
import 'package:flutter/material.dart';
import 'package:fragment_navigate/navigate-bloc.dart';

import 'ProductItemView.dart';



class CombinerRecyclerView extends StatelessWidget {
  const CombinerRecyclerView({
    @required this.buttonSize,
    @required this.list,
    @required this.name, this.fragNav,
  });
  final FragNavigate fragNav;
  final double buttonSize;
  final List<Products>list;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$name:",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          color: Colors.transparent,
          height: 220,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return ProductItemVIew(
                buttonSize: buttonSize,
                list: list,
                Index: index,
                OnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          ProductView(product: list[index],fragNav: fragNav,)));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
