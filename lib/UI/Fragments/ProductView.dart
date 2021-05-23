import 'package:cached_network_image/cached_network_image.dart';
import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/CartProduct.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
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

class _ProductViewState extends State<ProductView> with TickerProviderStateMixin {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        splashColor: Colors.white,
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      LikeButton(
                        size: buttonSize,
                        circleColor: CircleColor(
                            start: Color(0xff00ddff), end: Color(0xff0099cc)),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            FontAwesomeIcons.heart,
                            color: isLiked ? Colors.red : Colors.grey,
                            size: buttonSize,
                          );
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.black45,
                  height: MediaQuery.of(context).size.height - 100,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      CarouselWithIndicatorDemo(widget.product,
                          Test.fragNavigate, (index) => onTapeed(index), (t) {
                        setState(() {
                          currentIndex = t;
                        });
                      }),
                      Container(
                        height: MediaQuery.of(context).size.height / (1),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
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
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Text(
                                          "₹${widget.product.Price}",
                                          style: TextStyle(
                                            color: Styles.price_color,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: Styles.font,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Description:",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: Styles.font,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text("${widget.product.Short}"),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Available Colors:",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: Styles.font,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: getPadding(context)),
                                        child: GroupButton(
                                          width: 85,
                                          spacing: MediaQuery.of(context)
                                              .size
                                              .height,
                                          elevation: 5,
                                          customShape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          absoluteZeroSpacing: true,
                                          unSelectedColor: Colors.white54,
                                          buttonLables:
                                              widget.product.Color.split(","),
                                          buttonValues:
                                              widget.product.Color.split(","),
                                          buttonTextStyle: ButtonTextStyle(
                                              selectedColor: Styles.price_color,
                                              unSelectedColor: Colors.black,
                                              textStyle:
                                                  TextStyle(fontSize: 12)),
                                          radioButtonValue: (value) {
                                            setState(() {
                                              selectedColor = value;
                                              // selectedSize = null;
                                            });
                                            if (!getLabels()
                                                .contains(selectedSize)) {
                                              selectedSize = null;
                                            }
                                          },
                                          selectedColor: Styles.Log_sign,
                                          defaultSelected: widget.product.Color
                                              .split(",")[currentIndex],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Quantity:",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: Styles.font,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 140,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          flex: 4,
                                          child: Card(
                                            child: IconButton(
                                              icon: Icon(
                                                FontAwesomeIcons.minus,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  quantity == 1
                                                      ? Styles.showWarningToast(
                                                          Colors.yellow,
                                                          "Minimum is one",
                                                          Colors.black,
                                                          15)
                                                      : quantity--;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                            flex: 4,
                                            child: Card(
                                                elevation: 0,
                                                color: Styles.bg_color,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${quantity}",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ))),
                                        Flexible(
                                          flex: 4,
                                          child: Card(
                                            child: IconButton(
                                              icon: Icon(
                                                FontAwesomeIcons.plus,
                                                color: Colors.green,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  quantity == 5
                                                      ? Styles.showWarningToast(
                                                          Colors.yellow,
                                                          "Miximum is 5",
                                                          Colors.black,
                                                          15)
                                                      : quantity++;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Available Sizes:",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: Styles.font,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: CustomRadioButton(
                                          width: 65,
                                          elevation: 5,
                                          customShape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          absoluteZeroSpacing: true,
                                          unSelectedColor: Colors.white54,
                                          buttonLables: getLabels(),
                                          buttonValues: getLabels(),
                                          buttonTextStyle: ButtonTextStyle(
                                              selectedColor: Styles.price_color,
                                              unSelectedColor: Colors.black,
                                              textStyle:
                                                  TextStyle(fontSize: 12)),
                                          radioButtonValue: (value) {
                                            selectedSize = value;
                                          },
                                          selectedColor: Styles.Log_sign,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 6,
                                    child: Container(
                                      height: 200,
                                      child: PhotoView(
                                        backgroundDecoration: BoxDecoration(
                                          color: Color(0xffe3e3e6),
                                        ),
                                        // ignore: unrelated_type_equality_checks
                                        imageProvider: checkGender() == true
                                            ? AssetImage(
                                                "assets/images/men.jpg",
                                              )
                                            : AssetImage(
                                                'assets/images/women.jpg',
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 60),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      child: Text(
                        'Order',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: Styles.font,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (selectedSize != null) {
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              isDismissible: true,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setModelState) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: MediaQuery.of(context).size.height / 1.7,
                                          color: Color(0xffe3e3e6),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 2,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => Photoview(widget.product.Image
                                                                .toString()
                                                                .split(",")[getIndex()]
                                                                .trim())));
                                                  },
                                                  child: CachedNetworkImage(
                                                    imageUrl: widget.product.Image
                                                        .toString()
                                                        .split(",")[getIndex()]
                                                        .trim(),
                                                    height: MediaQuery.of(context).size.height / (2),
                                                    progressIndicatorBuilder:
                                                        (context, url, downloadProgress) => SizedBox(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child: SpinKitCubeGrid(
                                                          color: Styles.Log_sign,
                                                          size: 50.0,
                                                          controller: AnimationController(
                                                              vsync: this,
                                                              duration: const Duration(milliseconds: 1200)),
                                                        )),
                                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Flexible(
                                                          flex: 1,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                widget.product.Name.toString(),
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ),
                                                              Text(selectedColor),
                                                              Text(
                                                                "₹${widget.product.Price}",
                                                                style: TextStyle(
                                                                  color: Colors.red,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${selectedSize}",
                                                                style: TextStyle(
                                                                  color: Colors.red,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${quantity}",
                                                                style: TextStyle(
                                                                  color: Colors.red,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Flexible(
                                                      flex: 2,
                                                      child: Container(
                                                        // width: ,
                                                        height: getSize(context),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            if (selectedColor != null &&
                                                                selectedSize != null) {
                                                              Navigator.pop(context);
                                                            } else {
                                                              Styles.showWarningToast(Styles.Log_sign,
                                                                  'Please select a size', Colors.black, 16);
                                                            }
                                                          },
                                                          child: Text(
                                                            'Next',
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16),
                                                          ),
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                            MaterialStateProperty.all(Styles.Log_sign),
                                                          ),
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
                            setState(() {

                            });
                          });
                        } else {
                          Styles.showWarningToast(Colors.red,
                              "Please select a size", Colors.white, 18);
                        }
                      },
                    ),
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
    print(list);
    int i = list.indexOf(
        selectedColor == null ? list[0].toString() : selectedColor.toString());
    print(list
        .indexOf(selectedColor == null ? list[0].toString() : selectedColor)
        .toString());
    var lst = widget.product.Size.split(".");
    return lst[i].toString().split(",");
  }

  getIndex() {
    if (widget.product.Image.toString().split(",").length > -1 &&
        widget.product.Image.toString().split(",").length >
            widget.product.Color.toString().split(",").indexOf(selectedColor)) {
      print(widget.product.Image.toString().split(",").length);
      print(widget.product.Color.toString().split(",").indexOf(selectedColor));
      print(
          "DW ${widget.product.Color.toString().split(",").indexOf(selectedColor)}");
      return widget.product.Color.toString().split(",").indexOf(selectedColor);
    } else {
      print(selectedColor);
      print(widget.product.Image.toString().split(",").length);
      print(widget.product.Color.toString().split(",").indexOf(selectedColor));
      print("DW 0");
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
