import 'dart:async';
import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/Ads.dart';
import 'package:craftyfashions_webapp/Models/Categories.dart';
import 'package:craftyfashions_webapp/Models/Razorpay.dart';
import 'package:craftyfashions_webapp/UI/Activity/Host.dart';
import 'package:craftyfashions_webapp/UI/Fragments/NoInternet.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:craftyfashions_webapp/Utility/Users.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool status;
  String access, refresh;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
  @override
  void initState() {
    checkInternet();
    // getLoginData();
    super.initState();
    // checkPrev();
    getEverything(context);
    Timer(Duration(seconds: 3), () => checkPrev());
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 4),
    );
    animationController.repeat();
    // ;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Styles.Log_sign),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new AnimatedBuilder(
                      animation: animationController,
                      child: new Container(
                        height: 200.0,
                        width: 200.0,
                        child: new Image.asset('assets/images/logo.png'),
                      ),
                      builder: (BuildContext context, Widget _widget) {
                        return new Transform.rotate(
                          angle: animationController.value * 6.3,
                          child: _widget,
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 100.0,
                      child: Image(
                          height: 100.0,
                          width: 100.0,
                          image: AssetImage('assets/images/crafty.png')),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Styles.button_color,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Center(
                    child: Text(
                      "With love \n"
                          "from\n"
                          "Crafty",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Future<bool> checkInternet() async {
    bool result;
    if (kIsWeb) {
      print("Here");
      status = true;
      result = true;
    } else {
      result = await DataConnectionChecker().hasConnection;
      status = result;
    }
    return result;
  }

  void checkPrev() async {
    status == true
        ? Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>
            Host()), (Route<dynamic> route) => false)
        : Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>
            NoInternet()), (Route<dynamic> route) => false);
  }

  void getEverything(BuildContext context) async {
    getLoginData();
    UsersModel usersModel1 = UsersModel();
    UsersModel usersModel3 = UsersModel();
    UsersModel usersModel4 = UsersModel();
    var data = await usersModel1.getRequired();
    if (data != "Server Error") {
      var data3 = data['razorpay'];
      print("The key is ${data3}");
      Provider.of<CartData>(context,listen: false).setRazorpay(Razorpay.fromJson(data3));
      var data1 = data['require'] as List;
      List<Categories> categories =
      data1.map((e) => Categories.fromJson(e)).toList();
      Provider.of<CartData>(context, listen: false).setCategory(categories);
      var data2 = data['ads'] as List;
      List<Ads> ads = data2.map((e) => Ads.fromJson(e)).toList();
      Provider.of<CartData>(context, listen: false).setAds(ads);

    } else {
      UsersModel usersModel1 = UsersModel();
      var data = await usersModel1.getRequired();
      var data1 = data['require'] as List;
      List<Categories> categories =
      data1.map((e) => Categories.fromJson(e)).toList();
      Provider.of<CartData>(context, listen: false).setCategory(categories);
      var data2 = data['ads'] as List;
      List<Ads> ads = data2.map((e) => Ads.fromJson(e)).toList();
      Provider.of<CartData>(context, listen: false).setAds(ads);
    }
    var UserData = await usersModel4.getUser();
    if (UserData != "User Not Found") {
      Provider.of<CartData>(context, listen: false).updateUser(UserData);
    }
    if (Test.accessToken!=null) {
      var profile = await usersModel3
          .getProf(Provider.of<CartData>(context, listen: false).user.id);
      if (profile != "Server Error" && profile != null) {
        Provider.of<CartData>(context, listen: false).updateProfile(profile);
      }
    }
  }
}

void getLoginData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var acc = prefs.get('access');
  var ref = prefs.get('refresh');
  print("Get data ${acc}");
  if (acc != null && ref != null) {
    print("The data is ${acc}");
    Test.accessToken = acc;
    Test.refreshToken = ref;
  }
}

