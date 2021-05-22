import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/CartProduct.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/BottomContainer.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/ImageSlider.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/Photoview.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/ProductviewBottomSheet.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  final FragNavigate fragNav;

  ProductView({this.product, this.fragNav});

  final Products product;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
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
                  height: MediaQuery.of(context).size.height - 90,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      CarouselWithIndicatorDemo(widget.product,
                          Test.fragNavigate, (index) => onTapeed(index), (t) {
                        setState(() {
                          currentIndex = t;
                        });
                      }),
                      ProductviewBottomSheet(this.getIndex, this.getLabels,
                          (color, size, quant) {
                        selectedColor = color;
                        selectedSize = size;
                        quantity = quant;
                      }, widget.product, currentIndex),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 40),
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
                                  return BottomContainer(
                                      getIndex, getLabels, setModelState,
                                      (color, size, quant) {
                                    selectedColor = color;
                                    selectedSize = size;
                                    quantity = quant;
                                    show();
                                  }, selectedColor, widget.product, quantity);
                                },
                              );
                            }).whenComplete(() {
                          setState(() {
                            selectedSize = null;
                            quantity = 1;
                          });
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
}
