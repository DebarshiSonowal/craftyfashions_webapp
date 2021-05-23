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
return Container();
  }


}
