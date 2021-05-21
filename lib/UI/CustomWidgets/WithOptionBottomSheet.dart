import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Models/Address.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'AddressOption.dart';
import 'BottomCard.dart';

class WithOptionBottomSheet extends StatelessWidget {
  Function defaultAddress, getAddress, showPaymentDialog;
  TextEditingController addT1, addTtown, addTdis, addTstate, phT, pinT;

  WithOptionBottomSheet(
      this.defaultAddress,
      this.getAddress,
      this.showPaymentDialog,
      this.addT1,
      this.addTtown,
      this.addTdis,
      this.addTstate,
      this.phT,
      this.pinT);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
            child: Text(
          'Please Select a address:',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )),
        Provider.of<CartData>(context, listen: false).user != null
            ? GestureDetector(
                onTap: () => defaultAddress(),
                child: AddressOption(
                    Provider.of<CartData>(context, listen: false).user.name,
                    Provider.of<CartData>(context, listen: false)
                        .profile
                        .phone
                        .toString(),
                    Provider.of<CartData>(context, listen: false)
                        .profile
                        .address
                        .toString(),
                    Provider.of<CartData>(context, listen: false)
                        .profile
                        .pincode
                        .toString()),
              )
            : Container(),
        Center(
            child: Text(
          'OR',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              showModalBottomSheet(
                  context: context,
                  isDismissible: true,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return BottomCard(
                        addT1, addTtown, addTdis, addTstate, phT, pinT, () {
                      if (addT1.text.isNotEmpty &&
                          addTtown.text.isNotEmpty &&
                          addTdis.text.isNotEmpty &&
                          addTstate.text.isNotEmpty &&
                          pinT.text.isNotEmpty &&
                          phT.text.isNotEmpty) {
                        if (pinT.text.length == 6) {
                          if (phT.text.length == 10) {
                            Provider.of<CartData>(context, listen: false)
                                .address = getAddress();
                            Provider.of<CartData>(context, listen: false)
                                .setAddress(Address(getAddress(),
                                    phT.text.toString(), pinT.text.toString()));
                            Navigator.pop(context);
                            showPaymentDialog();
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please enter valid phone no",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please enter valid pincode",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please enter required fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.black,
                            fontSize: 16.0);
                      }
                    });
                  });
            },
            child: Text('Add a new Address')),
      ],
    );
  }
}
