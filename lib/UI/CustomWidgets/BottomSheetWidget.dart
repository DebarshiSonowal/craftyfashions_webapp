import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BottomSheetWidget extends StatefulWidget {
 Function ShowPaymentOptions,SetSelectedAddress,addNewAddress;


 BottomSheetWidget(this.ShowPaymentOptions, this.SetSelectedAddress,this.addNewAddress);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // height: MediaQuery.of(context).,
      padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Select a address",
              style: TextStyle(
                  fontFamily: "Halyard",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
          SizedBox(
            height: 10,
          ),
          Provider.of<CartData>(context, listen: true).profile != null &&
              Provider.of<CartData>(context, listen: true)
                  .profile
                  .address !=
                  null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1.5,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Color(0xffE3E3E3),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            radius:
                            MediaQuery.of(context).size.width + 10,
                            splashColor: Colors.black,
                            enableFeedback: true,
                            onTap: () {
                              widget.SetSelectedAddress(
                                  Provider.of<CartData>(context,
                                      listen: false)
                                      .profile
                                      .address,
                                  Provider.of<CartData>(context,
                                      listen: false)
                                      .profile
                                      .phone
                                      .toString(),
                                  Provider.of<CartData>(context,
                                      listen: false)
                                      .profile
                                      .pincode
                                      .toString());
                              Navigator.pop(context);
                              widget.ShowPaymentOptions();
                            },
                            child: Container(
                              height: 15.5.h,
                              width:
                              MediaQuery.of(context).size.width - 10,
                              padding: EdgeInsets.all(0.5.h),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 0.7.h, right: 10),
                                    child: Radio(
                                      value: true,
                                      toggleable: true,
                                      onChanged: (vaw) {
                                        widget.SetSelectedAddress(
                                            Provider.of<CartData>(context,
                                                listen: false)
                                                .profile
                                                .address,
                                            Provider.of<CartData>(context,
                                                listen: false)
                                                .profile
                                                .phone
                                                .toString(),
                                            Provider.of<CartData>(context,
                                                listen: false)
                                                .profile
                                                .pincode
                                                .toString());
                                        Navigator.pop(context);
                                       widget.ShowPaymentOptions();
                                      },
                                      groupValue: null,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${Provider.of<CartData>(context, listen: true).profile.name}",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: "Halyard",
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${Provider.of<CartData>(context, listen: true).profile.address.split(",")[0]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: "Halyard",
                                                  fontSize:8.sp,
                                                  fontWeight:
                                                  FontWeight.w300,
                                                  color: Colors.black)),
                                          Text(
                                              "${Provider.of<CartData>(context, listen: true).profile.address.split(",")[1]}, Pincode: ${Provider.of<CartData>(context, listen: true).profile.pincode}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: "Halyard",
                                                  fontSize: 8.sp,
                                                  fontWeight:
                                                  FontWeight.w300,
                                                  color: Colors.black)),
                                          Text(
                                              "${Provider.of<CartData>(context, listen: true).profile.address.split(",")[2]}, ${Provider.of<CartData>(context, listen: true).profile.address.split(",")[3]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: "Halyard",
                                                  fontSize: 8.sp,
                                                  fontWeight:
                                                  FontWeight.w300,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Mobile: ",
                                              style: TextStyle(
                                                  fontFamily: "Halyard",
                                                  fontSize: 8.sp,
                                                  fontWeight:
                                                  FontWeight.w300,
                                                  color: Colors.black)),
                                          Text(
                                              "${Provider.of<CartData>(context, listen: true).profile.phone}",
                                              style: TextStyle(
                                                  fontFamily: "Halyard",
                                                  fontSize: 8.sp,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              Text("OR",
                  style: TextStyle(
                      fontFamily: "Halyard",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ],
          )
              : Container(),
          Provider.of<CartData>(context, listen: true).profile == null
              ? Text("No default Addresses",
              style: TextStyle(
                  fontFamily: "Halyard",
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black))
              : Container(),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 5.h,
            child: ElevatedButton(
              onPressed: () {
                widget.addNewAddress();
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
                  child: Text("Add New Address",
                      style: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
