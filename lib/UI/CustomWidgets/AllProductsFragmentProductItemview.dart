import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';

class AllProductsFragmentProductItemView extends StatelessWidget {
  final List<Products> list;
  final double buttonSize;
  final Function OnTap;
  final int Index;

  List<Products> list1 = [
    Products(
        "1",
        "Dilbar main hu",
        "_Description",
        "Life is full of trouble",
        "_Categories",
        "_Color",
        "https://firebasestorage.googleapis.com/v0/b/crafty-fashions-assam.appspot.com/o/testinng%2FFOBP01_adobespark.png?alt=media&token=d5e84bfc-75e8-440e-9542-fcc6cee91c28",
        499,
        "_Size",
        "_Tags",
        "_Gender"),
    Products(
        "1",
        "Dilbar main hu",
        "_Description",
        "Life is full of trouble",
        "_Categories",
        "_Color",
        "https://firebasestorage.googleapis.com/v0/b/crafty-fashions-assam.appspot.com/o/testinng%2F2_adobespark.png?alt=media&token=29ac40a3-5557-4e89-ac0a-d87158f67f49",
        499,
        "_Size",
        "_Tags",
        "_Gender"),
    Products(
        "1",
        "Dilbar main hu",
        "_Description",
        "Life is full of trouble",
        "_Categories",
        "_Color",
        "https://firebasestorage.googleapis.com/v0/b/crafty-fashions-assam.appspot.com/o/testinng%2FFOBP01_adobespark.png?alt=media&token=d5e84bfc-75e8-440e-9542-fcc6cee91c28",
        499,
        "_Size",
        "_Tags",
        "_Gender"),
    Products(
        "1",
        "Dilbar main hu",
        "_Description",
        "Life is full of trouble",
        "_Categories",
        "_Color",
        "https://firebasestorage.googleapis.com/v0/b/crafty-fashions-assam.appspot.com/o/testinng%2F2%20(2)_adobespark.png?alt=media&token=eccd9f38-da48-4d17-90d0-52f7413b0800",
        499,
        "_Size",
        "_Tags",
        "_Gender"),
    Products(
        "1",
        "Dilbar main hu",
        "_Description",
        "Life is full of trouble",
        "_Categories",
        "_Color",
        "https://firebasestorage.googleapis.com/v0/b/crafty-fashions-assam.appspot.com/o/MONSTER%20SLAM%2F53.webp?alt=media&token=4449ac7e-1ea1-4bcc-b378-a845a57d122f",
        499,
        "_Size",
        "_Tags",
        "_Gender"),
    Products(
        "1",
        "Dilbar main hu",
        "_Description",
        "Life is full of trouble",
        "_Categories",
        "_Color",
        "https://firebasestorage.googleapis.com/v0/b/crafty-fashions-assam.appspot.com/o/MONSTER%20SLAM%2F53.webp?alt=media&token=4449ac7e-1ea1-4bcc-b378-a845a57d122f",
        499,
        "_Size",
        "_Tags",
        "_Gender"),
    Products(
        "1",
        "Dilbar main hu",
        "_Description",
        "Life is full of trouble",
        "_Categories",
        "_Color",
        "https://firebasestorage.googleapis.com/v0/b/crafty-fashions-assam.appspot.com/o/MONSTER%20SLAM%2F53.webp?alt=media&token=4449ac7e-1ea1-4bcc-b378-a845a57d122f",
        499,
        "_Size",
        "_Tags",
        "_Gender"),
  ];

  AllProductsFragmentProductItemView(
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
        decoration: BoxDecoration(
          color: Styles.bg_color,
          border: Border(
              bottom: BorderSide(
            color: Colors.black12,
            width: 0.6,
          )),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 30,
              fit: FlexFit.tight,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
                elevation: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/404.png",
                    image: list1[Index].Image.toString().split(",")[0],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 5.0, right: 3),
                child: Text(
                  list1[Index].Name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Halyard",
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: Styles.getPriceSize(context)),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 2.0, bottom: 2, right: 3),
                child: Text(
                  list1[Index].Short,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Halyard",
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 10),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 1.0,bottom: 1.0),
                child: Text(
                  "₹ ${list1[Index].Price}",
                  style: TextStyle(
                      fontSize: Styles.getPriceSize(context),
                      color: Styles.price_color,
                    fontWeight: FontWeight.w400,),
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
    if (type == "Desktop") {
      return MediaQuery.of(context).size.height / 40;
    } else if (type == "Mini") {
      return MediaQuery.of(context).size.height / 60;
    } else if (type == "Tablet") {
      return MediaQuery.of(context).size.height / 70;
    } else {
      return 10;
    }
  }

  getFontSizeAccordingToSize(BuildContext context) {
    var type = getDeviceType(context);
    if (type == "Desktop") {
      return 6;
    } else if (type == "Tablet" || type == "Mini") {
      return 4;
    } else {
      return 2;
    }
  }

  getDeviceType(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width > 1025) {
      return "Desktop";
    } else if (width > 412 && width < kTabletBreakpoint) {
      print("Mini");
      return "Mini";
    } else if (width > kMobileBreakpoint && width < 1025) {
      return "Tablet";
    } else {
      return "Mobile";
    }
  }


}
