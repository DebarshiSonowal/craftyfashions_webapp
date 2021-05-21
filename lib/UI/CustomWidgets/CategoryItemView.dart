import 'package:craftyfashions_webapp/Models/Categories.dart';
import 'package:flutter/material.dart';

class CategoryItemView extends StatelessWidget {
  const CategoryItemView(
      {Key key,
      @required this.list,
      @required this.OnTap,
      @required this.index})
      : super(key: key);

  final Function OnTap;
  final List<Categories> list;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Card(
        margin: EdgeInsets.all(9),
        color: Colors.transparent,
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 130,
          width: 150,
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 4,
                child: Image.network(
                  list[index].image,
                ),
              ),
              Flexible(flex: 1, child: Text(list[index].name))
            ],
          ),
        ),
      ),
    );
  }
}
