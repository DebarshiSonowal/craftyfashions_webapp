import 'package:cached_network_image/cached_network_image.dart';
import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Photoview.dart';

class BottomContainer extends StatefulWidget {
  Function getIndex, getLabels, setModelState;

  // Function(T) show;
  final Function(String, String,int) show;
  var product;
  int quantity;
  var selectedColor, selectedSize;

  BottomContainer(this.getIndex, this.getLabels, this.setModelState, this.show,
      this.selectedColor, this.product, this.quantity);

  @override
  _BottomContainerState createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
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
                                .split(",")[widget.getIndex()]
                                .trim())));
                  },
                  child: CachedNetworkImage(
                    imageUrl: widget.product.Image
                        .toString()
                        .split(",")[widget.getIndex()]
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
                              Text(widget.selectedColor),
                              Text(
                                "₹${widget.product.Price}",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "${widget.selectedSize}",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "${widget.quantity}",
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
                            if (widget.selectedColor != null &&
                                widget.selectedSize != null) {
                              Navigator.pop(context);
                              widget.show(
                                  widget.selectedColor, widget.selectedSize,widget.quantity);
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
