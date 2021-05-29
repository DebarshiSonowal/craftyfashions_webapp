import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Models/Address.dart';
import 'package:craftyfashions_webapp/Models/Profile.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewAddressPage extends StatefulWidget {
  NewAddressPage({Key key}) : super(key: key);

  @override
  _NewAddressPageState createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  var email,
      name,
      pin,
      phone,
      address,
      addressline1,
      town_village,
      district,
      state;

  final double paddingNo = 5.0;

  String nm, ids;

  Profile profile;

  bool enabled = false;

  var nT = TextEditingController();

  var pinT = TextEditingController();

  var phT = TextEditingController();

  var addT1 = TextEditingController();

  var addTtown = TextEditingController();

  var addTdis = TextEditingController();

  var addTstate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF2F2F2),
      padding: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "CONTACT DETAILS",
            style: TextStyle(
                fontFamily: "Halyard",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            elevation: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // color: Color(0xffE3E3E3),
                boxShadow: [
                  new BoxShadow(
                    color: Color(0xffE3E3E3),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: nT,
                    onChanged: (text) {},
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        fontFamily: "Halyard",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: Styles.log_sign_text, fontFamily: Styles.font),
                      labelText: "Full Name",
                      filled: true,
                      fillColor: Color(0xffd4d4d4),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    maxLength: 10,
                    controller: phT,
                    keyboardType: TextInputType.phone,
                    style:
                        TextStyle(color: Colors.black, fontFamily: Styles.font),
                    onChanged: (txt) {
                      // enabled = checknull(
                      //     Provider.of<CartData>(context, listen: false)
                      //         .profile);
                      phone = txt;
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      labelText: "Phone",
                      filled: true,
                      fillColor: Color(0xffd4d4d4),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "ADDRESS",
            style: TextStyle(
                fontFamily: "Halyard",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            elevation: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xfffafafa),
                // color: Color(0xffE3E3E3),
                boxShadow: [
                  new BoxShadow(
                    color: Color(0xffE3E3E3),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: addT1,
                    keyboardType: TextInputType.text,
                    style:
                        TextStyle(color: Colors.black, fontFamily: Styles.font),
                    onChanged: (txt) {
                      addressline1 = txt;
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      labelText: "Address (House no, Building, Street, Area)",
                      filled: true,
                      fillColor: Color(0xffd4d4d4),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: addTtown,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        fontFamily: "Halyard",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    onChanged: (txt) {
                      town_village = txt;
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: Styles.log_sign_text, fontFamily: Styles.font),
                      labelText: "Town/Village",
                      filled: true,
                      fillColor: Color(0xffd4d4d4),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: addTdis,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        fontFamily: "Halyard",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    onChanged: (txt) {
                      district = txt;
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      labelText: "District",
                      filled: true,
                      fillColor: Color(0xffd4d4d4),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: pinT,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            style: TextStyle(
                                fontFamily: "Halyard",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            onChanged: (txt) {
                              pin = txt;
                            },
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  fontFamily: "Halyard",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              labelText: "Pincode",
                              filled: true,
                              fillColor: Color(0xffd4d4d4),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 22),
                            child: TextField(
                              controller: addTstate,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  fontFamily: "Halyard",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              onChanged: (txt) {
                                state = txt;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: "Halyard",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                labelText: "State",
                                filled: true,
                                fillColor: Color(0xffd4d4d4),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
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
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (nT.text.isNotEmpty &&
                    addT1.text.isNotEmpty &&
                    addTdis.text.isNotEmpty &&
                    addTstate.text.isNotEmpty &&
                    addTtown.text.isNotEmpty &&
                    phT.text.isNotEmpty &&
                    pinT.text.isNotEmpty) {
                  NewAddress(context);
                } else {
                  Styles.showWarningToast(Colors.red,
                      "Please Enter all the details", Colors.white, 17);
                }
              },
              style: ButtonStyle(
                enableFeedback: true,
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )),
                backgroundColor: MaterialStateProperty.all(Styles.price_color),
                shadowColor: MaterialStateProperty.all(Color(0xffE3E3E3)),
                elevation: MaterialStateProperty.all(4),
                overlayColor: MaterialStateProperty.resolveWith(
                  (states) {
                    return states.contains(MaterialState.pressed)
                        ? Color(0xffE3E3E3)
                        : null;
                  },
                ),
              ),
              child: Container(
                child: Center(
                  child: Text("Proceed",
                      style: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  void SetSelectedAddress(address, phone, pincode, context) {
    Provider.of<CartData>(context, listen: false)
        .setAddress(Address(address, phone, pincode));
    Navigator.pop(context);
  }

  void NewAddress(BuildContext context) {
    print("giot a");
    SetSelectedAddress(getAddress(), phT.text, pinT.text, context);
  }

  String getAddress() {
    return addT1.text.trim() +
        "," +
        addTtown.text.trim() +
        "," +
        addTdis.text.trim() +
        "," +
        addTstate.text.trim();
  }
}
