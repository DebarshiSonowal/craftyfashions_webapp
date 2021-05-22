import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:flutter/material.dart';


class AllProductsFragmentProductItemView extends StatelessWidget{

  final List<Products> list;
  final double buttonSize;
  final Function OnTap;
  final int Index;


  const AllProductsFragmentProductItemView(
      {Key key,
        @required this.buttonSize,
        @required this.list,
        @required this.OnTap,
        @required this.Index})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 12,
              child: Card(
                elevation: 10,
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/404.png",
                  image: list[Index].Image.toString().split(",")[0],
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  list[Index].Name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Halyard",
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
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
      print("Mini");
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
