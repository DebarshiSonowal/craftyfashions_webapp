import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/CartProduct.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/Models/size.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/GroupButton.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/ImageSlider.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/Photoview.dart';
import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  final FragNavigate fragNav;

  ProductView({this.product, this.fragNav});

  final Products product;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>
    with TickerProviderStateMixin {
  get buttonSize => 30.0;
  var selectedColor;
  var selectedSize;
  var snackBar;
  var currentIndex = 0;
  int quantity = 1;
  int currentPhoto = 0;
  List<int> lst = [1, 22, 3];
  int Index;

  @override
  void initState() {
    selectedColor = widget.product.Color.toString().split(",")[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: Color(0xffe3e3e6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                      color: Color(0xffe3e3e6),
                      height: MediaQuery.of(context).size.height - 60,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          CarouselWithIndicatorDemo(
                              widget.product,
                              Test.fragNavigate,
                              (index) => onTapeed(index), (t) {
                            setState(() {
                              currentIndex = t;
                            });
                          }, Color(0xffececec)),
                          Container(
                            height: MediaQuery.of(context).size.height + 150,
                            decoration: BoxDecoration(
                              color: Color(0xffe3e3e6),
                            ),
                            child: CustomScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              slivers: [
                                SliverFillRemaining(
                                  hasScrollBody: false,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        elevation: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              new BoxShadow(
                                                color: Color(0xffE3E3E3),
                                                blurRadius: 5.0,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  widget.product.Name,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: Styles.font,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 8),
                                                child: Text(
                                                  "${widget.product.Short}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: Styles.font,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 8),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "₹${widget.product.Price}",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: Styles.font,
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "₹699",
                                                      style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontFamily: Styles.font,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 2),
                                                child: Text(
                                                  "inclusive of all taxes",
                                                  style: TextStyle(
                                                    color: Styles.price_color,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: Styles.font,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                child: Container(
                                                  color: Color(0xffE4E4E7),
                                                ),
                                                height: 0.2,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    top: 2,
                                                    bottom: 5),
                                                child: Text(
                                                  "Expected delivery time is 5-7 working days",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: Styles.font,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 1,
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              new BoxShadow(
                                                color: Color(0xffE3E3E3),
                                                blurRadius: 5.0,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5, left: 10),
                                                child: Text(
                                                  "Easy 15 days returns and exchanges",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: Styles.font,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5, left: 10),
                                                child: Text(
                                                  "Choose to return or exchange for a  different size (if available) within 15 days of delivery",
                                                  style: TextStyle(
                                                    fontFamily: Styles.font,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 1,
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10, bottom: 20),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              new BoxShadow(
                                                color: Color(0xffE3E3E3),
                                                blurRadius: 5.0,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Colors",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: Styles.font,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, top: 10),
                                                  child: GroupButton(
                                                    width: 85,
                                                    spacing:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    elevation: 5,
                                                    customShape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                    ),
                                                    absoluteZeroSpacing: true,
                                                    unSelectedColor:
                                                        Colors.white54,
                                                    buttonLables: widget
                                                        .product.Color
                                                        .split(","),
                                                    buttonValues: widget
                                                        .product.Color
                                                        .split(","),
                                                    buttonTextStyle:
                                                        ButtonTextStyle(
                                                            selectedColor:
                                                                Styles
                                                                    .price_color,
                                                            unSelectedColor:
                                                                Colors.black,
                                                            textStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        12)),
                                                    radioButtonValue: (value) {
                                                      setState(() {
                                                        selectedColor = value;
                                                        // selectedSize = null;
                                                      });
                                                      if (!getLabels().contains(
                                                          selectedSize)) {
                                                        selectedSize = null;
                                                      }
                                                    },
                                                    selectedColor:
                                                        Styles.Log_sign,
                                                    defaultSelected: widget
                                                        .product.Color
                                                        .split(
                                                            ",")[currentIndex],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 1,
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10, bottom: 20),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              new BoxShadow(
                                                color: Color(0xffE3E3E3),
                                                blurRadius: 5.0,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Size",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: Styles.font,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                  ),
                                                  Container(
                                                    child:
                                                        DropdownButton<String>(
                                                      focusColor: Colors.white,
                                                      value: selectedSize,
                                                      //elevation: 5,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      iconEnabledColor:
                                                          Colors.black,
                                                      items: getLabels().map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(
                                                            value,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      hint: Text(
                                                        "",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      onChanged:
                                                          (String value) {
                                                        setState(() {
                                                          selectedSize = value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Quantity:",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: Styles.font,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(
                                                          FontAwesomeIcons
                                                              .minus,
                                                          color: Colors.black,
                                                          size: 8,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            quantity == 1
                                                                ? Styles.showWarningToast(
                                                                    Colors
                                                                        .yellow,
                                                                    "Minimum is one",
                                                                    Colors
                                                                        .black,
                                                                    15)
                                                                : quantity--;
                                                          });
                                                        },
                                                      ),
                                                      Card(
                                                          elevation: 0,
                                                          color:
                                                              Styles.bg_color,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Text(
                                                              "${quantity}",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Halyard",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 16),
                                                            ),
                                                          )),
                                                      IconButton(
                                                        icon: Icon(
                                                          FontAwesomeIcons.plus,
                                                          color: Colors.black,
                                                          size: 8,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            quantity == 5
                                                                ? Styles.showWarningToast(
                                                                    Colors
                                                                        .yellow,
                                                                    "Miximum is 5",
                                                                    Colors
                                                                        .black,
                                                                    15)
                                                                : quantity++;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 1,
                                        child: Container(
                                          padding: EdgeInsets.only(top: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              new BoxShadow(
                                                color: Color(0xffE3E3E3),
                                                blurRadius: 5.0,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "SIZE CHART",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: Styles.font,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Container(
                                                height: 200,
                                                child: PhotoView(
                                                  backgroundDecoration:
                                                      BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  // ignore: unrelated_type_equality_checks
                                                  imageProvider:
                                                      checkGender() == true
                                                          ? AssetImage(
                                                              "assets/images/men.jpg",
                                                            )
                                                          : AssetImage(
                                                              'assets/images/women.jpg',
                                                            ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.5,
                                      ),
                                      Card(
                                        elevation: 1,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              new BoxShadow(
                                                color: Color(0xffE3E3E3),
                                                blurRadius: 5.0,
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                              "Fit: Regular Fit\nMaterial: 100% Cotton, Bio-Washed & Pre-Shrunk\nWash Care: Machine wash. Wash in cold water, use mild detergent, dry in shade , do not iron directly on print, do not bleach, do not tumble dry. Dry on flat surface as hanging may cause measurement variations.\nSizing: Please refer to the size chart to see which size fits you the best.\nPlease Note: Colors may slightly vary depending upon your screen brightness."),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: IconButton(
                              splashColor: Colors.white,
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: IconButton(
                              icon: Badge(
                                  showBadge: Provider.of<CartData>(context)
                                              .listLength ==
                                          0
                                      ? false
                                      : true,
                                  badgeContent: Text(
                                      "${Provider.of<CartData>(context).listLength}",
                                      style: TextStyle(color: Colors.white)),
                                  animationType: BadgeAnimationType.scale,
                                  child: Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.white,
                                  )),
                              onPressed: () {
                                Navigator.pop(context);
                                Test.fragNavigate
                                    .putPosit(key: 'Cart', force: true);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: MediaQuery.of(context).size.width, height: 50),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child: Text(
                      'Proceed',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: Styles.font,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (selectedSize == null) {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            isDismissible: true,
                            isScrollControlled: false,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setModelState) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: SingleChildScrollView(
                                      physics: NeverScrollableScrollPhysics(),
                                      child: Container(
                                        padding: EdgeInsets.only(top: 20),
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Flexible(
                                                    flex: 2,
                                                    child: Container(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Photoview(widget
                                                                      .product
                                                                      .Image
                                                                      .toString()
                                                                      .split(",")[
                                                                          getIndex()]
                                                                      .trim())));
                                                        },
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: widget
                                                              .product.Image
                                                              .toString()
                                                              .split(",")[
                                                                  getIndex()]
                                                              .trim(),
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      downloadProgress) =>
                                                                  SizedBox(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      child:
                                                                          SpinKitCubeGrid(
                                                                        color: Styles
                                                                            .price_color,
                                                                        size:
                                                                            50.0,
                                                                        controller: AnimationController(
                                                                            vsync:
                                                                                this,
                                                                            duration:
                                                                                const Duration(milliseconds: 1200)),
                                                                      )),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 3,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Flexible(
                                                              flex: 1,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    widget
                                                                        .product
                                                                        .Name
                                                                        .toString(),
                                                                    maxLines: 1,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Halyard",
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(right: 10),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Text(
                                                                              "Color",
                                                                              style: TextStyle(fontFamily: "Halyard", fontWeight: FontWeight.w400, fontSize: 16),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Text(
                                                                              "Price",
                                                                              style: TextStyle(fontFamily: "Halyard", fontWeight: FontWeight.w400, fontSize: 16),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Text(
                                                                              "Size",
                                                                              style: TextStyle(fontFamily: "Halyard", fontWeight: FontWeight.w400, fontSize: 16),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Text(
                                                                              "Quantity",
                                                                              style: TextStyle(fontFamily: "Halyard", fontWeight: FontWeight.w400, fontSize: 16),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            selectedColor,
                                                                            style: TextStyle(
                                                                                fontFamily: "Halyard",
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 16),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "₹${widget.product.Price}",
                                                                            style: TextStyle(
                                                                                fontFamily: "Halyard",
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 16),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "${selectedSize}",
                                                                            style: TextStyle(
                                                                                fontFamily: "Halyard",
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 16),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "${quantity}",
                                                                            style: TextStyle(
                                                                                fontFamily: "Halyard",
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 16),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 100,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ConstrainedBox(
                                                    constraints:
                                                        BoxConstraints.tightFor(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                (2),
                                                            height: 50),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Provider.of<CartData>(
                                                                context,
                                                                listen: false)
                                                            .addProduct(CartProduct(
                                                                selectedColor,
                                                                widget.product
                                                                    .Price,
                                                                widget.product
                                                                    .Image
                                                                    .toString()
                                                                    .split(",")[
                                                                        getIndex()]
                                                                    .trim(),
                                                                quantity,
                                                                selectedSize,
                                                                widget.product
                                                                    .Name,
                                                                widget.product
                                                                    .Id));
                                                        Navigator.pop(context);
                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Color(
                                                                      0xffE6E6E6)),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                          ))),
                                                      child: Text(
                                                        'Add',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17,
                                                            fontFamily:
                                                                Styles.font,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  ConstrainedBox(
                                                    constraints:
                                                        BoxConstraints.tightFor(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                (2),
                                                            height: 50),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        Test.fragNavigate
                                                            .putPosit(
                                                                key: 'Cart',
                                                                force: true);
                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Styles
                                                                      .price_color),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                          ))),
                                                      child: Text(
                                                        'Go to Cart',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17,
                                                            fontFamily:
                                                                Styles.font,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).whenComplete(() {
                          setState(() {});
                        });
                      } else {
                        Styles.showWarningToast(Colors.red,
                            "Please select a size", Colors.white, 18);
                      }
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }

  show() {
    Provider.of<CartData>(context, listen: false).addProduct(CartProduct(
        selectedColor,
        widget.product.Price,
        widget.product.Image.toString().split(",")[getIndex()].trim(),
        quantity,
        selectedSize,
        widget.product.Name,
        widget.product.Id));
    Styles.showSnackBar(context, Colors.green, Duration(seconds: 5),
        'Product Added', Colors.white, () {
      setState(() {
        Navigator.pop(context);
        widget.fragNav.putPosit(key: 'Cart');
      });
    });
  }

  getLabels() {
    var list = widget.product.Color.split(",");
    int i = list.indexOf(
        selectedColor == null ? list[0].toString() : selectedColor.toString());
    var lst = widget.product.Size.split(".");
    return lst[i].toString().split(",");
  }

  getIndex() {
    if (widget.product.Image.toString().split(",").length > -1 &&
        widget.product.Image.toString().split(",").length >
            widget.product.Color.toString().split(",").indexOf(selectedColor)) {
      return widget.product.Color.toString().split(",").indexOf(selectedColor);
    } else {
      return 0;
    }
  }

  onTapeed(int index) {
    print("Tapped");
    Index = index;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Photoview(
                widget.product.Image.toString().split(',')[index].trim())));
  }

  bool checkGender() {
    print(widget.product.Gender.toString());
    return widget.product.Gender.toString().trim() == "MALE" ? true : false;
  }

  getPadding(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width <= kTabletBreakpoint) {
      return 10;
    } else if (width > 1024) {
      return MediaQuery.of(context).size.width / 4;
    } else {
      return MediaQuery.of(context).size.width / 5;
    }
  }

  getSize(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width > 1024) {
      return MediaQuery.of(context).size.width / (5);
    } else if (width <= kTabletBreakpoint) {
      return MediaQuery.of(context).size.width / (6);
    } else {
      return MediaQuery.of(context).size.width / (3);
    }
  }
}
// Flexible(
// flex: 2,
// child: Container(
// // width: ,
// height:
// getSize(context),
// child: ElevatedButton(
// onPressed: () {
// if (selectedColor !=
// null &&
// selectedSize !=
// null) {
// Navigator.pop(
// context);
// } else {
// Styles.showWarningToast(
// Styles
//     .Log_sign,
// 'Please select a size',
// Colors.black,
// 16);
// }
// },
// child: Text(
// 'Next',
// style: TextStyle(
// color: Colors
//     .black,
// fontWeight:
// FontWeight
//     .bold,
// fontSize: 16),
// ),
// style: ButtonStyle(
// backgroundColor:
// MaterialStateProperty
//     .all(Styles
//     .Log_sign),
// ),
// ),
// ),
// ),
