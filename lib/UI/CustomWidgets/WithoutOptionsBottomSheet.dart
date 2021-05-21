import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'BottomCard.dart';
class WithoutOptionsBottomSheet extends StatelessWidget {
  Function saveDetails;
  TextEditingController addT1, addTtown, addTdis, addTstate, phT, pinT;

  WithoutOptionsBottomSheet(this.saveDetails, this.addT1, this.addTtown,
      this.addTdis, this.addTstate, this.phT, this.pinT);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
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
                            saveDetails(context);
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
