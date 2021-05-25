
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
class ProductItemVIew extends StatelessWidget {
  const ProductItemVIew(
      {Key key,
      @required this.buttonSize,
      @required this.list,
      @required this.OnTap,
      @required this.Index})
      : super(key: key);

  final List<Products> list;
  final double buttonSize;
  final Function OnTap;
  final int Index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Card(
        margin: EdgeInsets.all(10),
        color: Colors.transparent,
        elevation: 3,
        child: Container(
          width: 200,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/404.png",
                    image: list[Index].Image.toString().split(",")[0],
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Text(
                  list[Index].Name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getImageSizeAccordingToSize(context)),
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(
                  "₹ ${list[Index].Price}",style: TextStyle(
                  fontSize: getPriceSize(context),
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  getImageSizeAccordingToSize(BuildContext context) {
    var type = getDeviceType(context);
    if(type == "Desktop"){
      return MediaQuery.of(context).size.height / 40;
    }else if(type == "Mini"){
      return MediaQuery.of(context).size.height / 60;
    }
    else if(type == "Tablet"){
      return MediaQuery.of(context).size.height / 70;
    }else{
      return 10;
    }
  }

  getFontSizeAccordingToSize(BuildContext context) {
    var type = getDeviceType(context);
    if(type == "Desktop"){
      return 6;
    }else if(type == "Tablet" || type == "Mini"){
      return 4;
    }else{
      return 2;
    }
  }

  getDeviceType(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width > 1025) {
      return "Desktop";
    }else if(width > 412 && width < kTabletBreakpoint){
      return "Mini";
    }
    else if (width > kMobileBreakpoint && width <1025) {
      return "Tablet";
    } else {
      return "Mobile";
    }
  }

  getPriceSize(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if(width >= 717){
      return MediaQuery.of(context).size.height / 45;
    }else{
      return MediaQuery.of(context).size.height / 60;
    }
  }
}
