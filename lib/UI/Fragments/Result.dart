
import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:craftyfashions_webapp/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' as  kIsWeb;


class Result extends StatefulWidget {


  @override
  _ResultState createState() => _ResultState();


}

class _ResultState extends State<Result> {
//Zakaria Jawas
//utsav
//Abby Ambrogi
  var RESULT;
  @override
  Widget build(BuildContext context) {
    setState(() {
      RESULT =CartData.RESULT;
    });
    print(CartData.RESULT);
    return Material(
      child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Flexible(
              //     flex: 3,
              //     child: Lottie.asset(CartData.RESULT)),
              Flexible(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "Your order has been placed",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "The Reference ID is ${CartData.TXT}",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "Do not close this",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  )),
              Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    ElevatedButton(onPressed: () {
                      if (RESULT!="assets/raw/loading.json") {
                        Test.fragNavigate.putPosit(key: 'Home');
                        RESULT="assets/raw/loading.json";
                      } else {
                        Styles.showWarningToast(Styles.bg_color, "Please Wait", Colors.black, 15);
                      }
                    }, child: Text("Next")),
                  )),
            ],
          )),
    );
  }

  @override
  void initState() {

    updateOrder();
    super.initState();
//
  }

  String getAsset() {
    if(CartData.RESULT == "Successful") {
      setState(() {
        return "assets/raw/successful.json";
      });
    }else if(CartData.RESULT == "Please Wait"){
      setState(() {
        return "assets/raw/failed.json";
      });
    }else{
      return "assets/raw/loading.json";
    }

  }

  void updateOrder() async{
    UsersModel usersModel =UsersModel();
    var order = await usersModel.getOrdersforUser(
        Provider.of<CartData>(context, listen: false).user.id);
    if (order != null) {
      setState(() {
        Provider.of<CartData>(context, listen: false).orders(order);
      });
    }
  }

  getPadding() {
    var width = MediaQuery.of(context).size.width;
    kTabletBreakpoint>width?EdgeInsets.only(top: MediaQuery.of(context).size.height / 4):EdgeInsets.only(top: MediaQuery.of(context).size.width / 4);
  }
}
