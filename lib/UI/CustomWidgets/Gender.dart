import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';

/// Requires a list of string ['Male','Female','Other'] only once.

class GenderField extends StatelessWidget {

  final List<String> genderList;
  final ValueSetter<String> callback;
  final String def;

  GenderField({@required this.genderList, this.def,@required this.callback});

  @override
  Widget build(BuildContext context) {
    String select=def!=null?def:null;
    Map<int, String> mappedGender = genderList.asMap();

    return StatefulBuilder(
      builder: (_, StateSetter setState) =>
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Gender : ',
                style: TextStyle(fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.black,fontFamily: Styles.font),
              ),
              ...mappedGender.entries.map(
                    (MapEntry<int, String> mapEntry) =>
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            activeColor: Colors.black,
                            groupValue: select,
                            value: genderList[mapEntry.key],
                            onChanged: (value) {
                              callback(value);
                              setState(() => {
                                select = value
                              });
                              },
                          ),
                          Text(mapEntry.value,style: TextStyle(
                            fontFamily: Styles.font,
                            color: Colors.black,   fontSize: getFontSize(context),
                          ),)
                        ]),
              ),
            ],
          ),
    );
  }
  getFontSize(BuildContext context) {
    var size = getDeviceType(context);
    if(size == "Desktop"){
      return 18;
    }else if(size == "Tablet"){
      return 14;
    }else{
      return 12;
    }
  }
  getDeviceType(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width > 1026) {
      return "Desktop";
    } else if (width > kMobileBreakpoint) {
      return "Tablet";
    }else if(width <= kSmallDesktopBreakpoint && width>kTabletBreakpoint){
      return "Mini";
    }
    else {
      return "Mobile";
    }
  }
}