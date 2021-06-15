import 'package:flutter/material.dart';

import 'BottomSheetWidget.dart';

class UpdatedCartItem extends StatelessWidget {
  Function ShowPaymentOptions,SetSelectedAddress,addNewAddress;


  UpdatedCartItem(
      this.ShowPaymentOptions, this.SetSelectedAddress, this.addNewAddress);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      color: Colors.transparent,
      child: Wrap(
        children: [
          BottomSheetWidget(ShowPaymentOptions,SetSelectedAddress,addNewAddress),
        ],
      ),
    );
  }
}
