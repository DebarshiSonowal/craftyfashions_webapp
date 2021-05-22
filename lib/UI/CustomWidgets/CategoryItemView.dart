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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 200,
        width: MediaQuery.of(context).size.width/2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 10,
              child: Image.network(
                list[index].image,
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(list[index].name,
                    style: TextStyle(
                      fontFamily: "Halyard",
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                    ))),
          ],
        ),
      ),
    );
  }
}
