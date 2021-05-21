import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';


import 'CategoryItemView.dart';

class CategoryData extends StatefulWidget{
  Function showIndex;
  Function onTap;

  CategoryData(this.showIndex,this.onTap(T));

  @override
  _CategoryDataState createState() => _CategoryDataState();
}

class _CategoryDataState extends State<CategoryData> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.transparent,
          height: 150,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount:
            Provider.of<CartData>(context, listen: true).getCateg().length,
            itemBuilder: (BuildContext ctxt, int index) {
              return CategoryItemView(
                list: Provider.of<CartData>(context, listen: true).getCateg(),
                index: index,
                OnTap: () => widget.onTap(index),
              );
            },
          ),
        ),
        SizedBox(
          height: 15,
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 300.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            reverse: false,
          ),
          items:
          Provider.of<CartData>(context, listen: false).getAdImage().map((i) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () => widget.showIndex(
                      Provider.of<CartData>(context, listen: false)
                          .getAdImage()
                          .indexOf(i)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: CachedNetworkImage(
                      imageUrl: i,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child:SpinKitFadingCube(
                          color: Styles.Log_sign,
                          size: 50.0,
                          controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                        )
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
