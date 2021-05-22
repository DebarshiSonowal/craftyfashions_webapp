import 'package:craftyfashions_webapp/UI/Activity/PhotoviewAsset.dart';
import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:flutter/material.dart';

import 'BottomContainer.dart';
import 'GroupButton.dart';

class ProductviewBottomSheet extends StatefulWidget {
  Function getIndex,getLabels;
  final Function(String,String) show;
  var product,selectedSize,quantity,selectedColor,currentIndex;

  ProductviewBottomSheet(this.getIndex, this.getLabels, this.show, this.product,
      this.selectedSize, this.quantity, this.selectedColor, this.currentIndex);

  @override
  _ProductviewBottomSheetState createState() => _ProductviewBottomSheetState();
}

class _ProductviewBottomSheetState extends State<ProductviewBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: MediaQuery.of(context).size.height/2.2,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 30),
                            child: Text(
                              widget.product.Name,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Text(
                            "₹${widget.product.Price}",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
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
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Text("${widget.product.Short}"),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Available Colors:",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: getPadding(context)),
                          child: GroupButton(
                            width: 85,
                            spacing: MediaQuery.of(context).size.height,
                            elevation: 5,
                            customShape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            absoluteZeroSpacing: true,
                            unSelectedColor:
                            Theme.of(context).canvasColor,
                            buttonLables:
                            widget.product.Color.split(","),
                            buttonValues:
                            widget.product.Color.split(","),
                            buttonTextStyle: ButtonTextStyle(
                                selectedColor: Colors.black,
                                unSelectedColor: Colors.black,
                                textStyle: TextStyle(fontSize: 12)),
                            radioButtonValue: (value) {
                              setState(() {
                                widget.selectedColor = value;
                                print("selected ${widget.selectedColor} $value");
                                // selectedSize = null;
                              });
                              print("selected ${widget.selectedColor}");
                            },
                            selectedColor: Styles.Log_sign,
                            defaultSelected:
                            widget.product.Color.split(",")[widget.currentIndex],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text("Size Chart",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                PhotoviewAsset(checkGender()==true?"Men":"Women")));
                      },
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          width: 300, height: 30),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(
                              Styles.Log_sign),
                        ),
                        child: Text(
                          'Order',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          print("AS ${widget.selectedColor}");
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              isDismissible: true,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setModelState) {
                                    return BottomContainer(widget.getIndex, widget.getLabels, setModelState,(color,size){
                                      widget.show(color,size);
                                    },
                                        this.widget.selectedColor, widget.product, widget.quantity);
                                  },
                                );
                              }).whenComplete(() {
                            setState(() {
                              widget.selectedSize = null;
                              widget.quantity = 1;
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  bool checkGender() {
    print(widget.product.Gender.toString());
    return widget.product.Gender.toString().trim() == "MALE";
  }

  getPadding(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if(width<=kTabletBreakpoint){
    return 1;
    }else if(width>1024){
      return MediaQuery.of(context).size.width/4;
    }else{
      return MediaQuery.of(context).size.width/5;
    }
}
}
