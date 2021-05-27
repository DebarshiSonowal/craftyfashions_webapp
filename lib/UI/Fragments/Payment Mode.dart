import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Models/Profile.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  Payment({Key key}) : super(key: key);
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
      padding: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("CONTACT DETAILS"),
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
                  TextField(
                    controller: nT,
                    onChanged: (text) {
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Styles.log_sign_text,fontFamily: Styles.font),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Styles.log_sign_text,fontFamily: Styles.font),
                      labelText: "Full Name",
                      filled: true,
                      fillColor: Color(0xffd4d4d4),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
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
                          color: Styles.log_sign_text, fontFamily: Styles.font),
                      labelText: "Phone",
                      filled: true,
                      fillColor: Color(0xffd4d4d4),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
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
          Text("ADDRESS"),
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
                  SizedBox(height: 5,),
                  TextField(
                    controller: addT1,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black,fontFamily: Styles.font),
                    onChanged: (txt) {
                      addressline1 = txt;
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Styles.log_sign_text,fontFamily: Styles.font),
                      labelText: "Address (House no, Building, Street, Area)",
                      filled: true,
                      fillColor: Color(0xffd4d4d4),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextField(
                    controller: addTtown,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black,fontFamily: Styles.font),
                    onChanged: (txt) {

                      town_village = txt;
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Styles.log_sign_text,fontFamily: Styles.font),
                      labelText: "Town/Village",
                      filled: true,
                      fillColor: Color(0xffd4d4d4),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextField(
                    controller: addTdis,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black,fontFamily: Styles.font),
                    onChanged: (txt) {
                      district = txt;
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Styles.log_sign_text,fontFamily: Styles.font),
                      labelText: "District",
                      filled: true,
                      fillColor: Color(0xffd4d4d4),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: pinT,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            style: TextStyle(color: Colors.black,fontFamily: Styles.font),
                            onChanged: (txt) {
                              pin = txt;
                            },
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Styles.log_sign_text,fontFamily: Styles.font),
                              labelText: "Pincode",
                              filled: true,
                              fillColor: Color(0xffd4d4d4),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 22),
                            child: TextField(
                              controller: addTstate,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.black,fontFamily: Styles.font),
                              onChanged: (txt) {
                                state = txt;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Styles.log_sign_text,fontFamily: Styles.font),
                                labelText: "State",
                                filled: true,
                                fillColor: Color(0xffd4d4d4),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
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
        ],
      ),
    );
  }
// bool checknull(Profile profile) {
//   if (profile == null) {
//     print("!");
//     return true;
//   } else if (profile.address == getAddress() &&
//       profile.name == nT.text &&
//       profile.pincode.toString() == pinT.text &&
//       profile.phone.toString() == phT.text) {
//     print("1!");
//     return true;
//   } else {
//     print("caf ${profile.address.toString().trim() == getAddress()} ${profile.address.toString().trim()} == ${getAddress()}");
//     return false;
//   }
// }
// String getAddress() {
//   return addT1.text.trim() +
//       "," +
//       addTtown.text.trim() +
//       "," +
//       addTdis.text.trim() +
//       "," +
//       addTstate.text.trim();
// }
//
// void setAddress(String s) {
//   addT1.text = s == "" ? "" : s.split(",")[0];
//   addTtown.text = s == "" ? "" : s.split(",")[1];
//   addTdis.text = s == "" ? "" : s.split(",")[2];
//   addTstate.text = s == "" ? "" : s.split(",")[3];
//
// }

}
