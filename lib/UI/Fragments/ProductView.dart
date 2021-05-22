import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/CartProduct.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
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

  int quantity = 1;

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
          color: Styles.bg_color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      color: Colors.white70,
                      child: IconButton(
                        splashColor: Colors.white,
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Card(
                      color: Colors.white70,
                      child: LikeButton(
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
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 13,
                child: CarouselWithIndicatorDemo(widget.product,
                    Test.fragNavigate, (index) => onTapeed(index), (t) {
                  setState(() {
                    currentIndex = t;
                  });
                }),
              ),
              Flexible(
                flex:6,
                child: ProductviewBottomSheet(this.getIndex, this.getLabels,
                    (color, size) {
                  selectedColor = color;
                  selectedSize = size;
                  show();
                }, widget.product, this.selectedSize, widget.quantity,
                    selectedColor, currentIndex),
              )
            ],
          ),
        ),
      ),
    );
  }

  show() {
    Provider.of<CartData>(context, listen: false).addProduct(CartProduct(
        selectedColor,
        widget.product.Price,
        widget.product.Image.toString().split(",")[getIndex()].trim(),
        widget.quantity,
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
