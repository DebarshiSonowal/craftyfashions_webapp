import 'package:cached_network_image/cached_network_image.dart';
import 'package:craftyfashions_webapp/Models/Categories.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CategoryItemView extends StatefulWidget {
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
  _CategoryItemViewState createState() => _CategoryItemViewState();
}

class _CategoryItemViewState extends State<CategoryItemView>  with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.OnTap,
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
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl:  widget.list[widget.index].image,
                progressIndicatorBuilder:
                    (context, url, downloadProgress) => SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child:SpinKitFadingCube(
                      color: Styles.price_color,
                      size: 50.0,
                      controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                    )
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(widget.list[widget.index].name,
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
