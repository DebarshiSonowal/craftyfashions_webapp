import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/LoginData.dart';
import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:craftyfashions_webapp/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {


  Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ProgressDialog pr;

  String email, password;

  bool _isHidden = true;

  TextEditingController em, pass;

  FocusNode focusNodePass= FocusNode();FocusNode focusNodeEmail= FocusNode();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Center(
                    child: Column(
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Halyard',
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        ),
                        SizedBox(
                          height: 10,
                        ),Text(
                          "Log-in to your existing account of Crafty",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Halyard",
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 7.0,right: 25,left: 25,top: 5),
                    child: TextFormField(
                      focusNode: focusNodeEmail,
                      onChanged: (txt) {
                        email = txt;
                      },
                      onTap: (){
                        _requestFoucs(focusNodeEmail);
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        labelStyle: TextStyle(
                            fontFamily: "Halyard",
                            fontSize: 14,
                            color: focusNodeEmail.hasFocus?Styles.price_color:Colors.black45),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Styles.price_color, width: 1.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 7.0,right: 25,left: 25,top: 5),
                    child: TextFormField(
                      focusNode: focusNodePass,
                      keyboardType: TextInputType.text,
                      onTap: (){
                        _requestFoucs(focusNodePass);
                      },
                      onChanged: (txt) {
                        password = txt;
                      },
                      style: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      obscureText: _isHidden,

                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontFamily: "Halyard",
                            fontSize: 14,
                            color: focusNodePass.hasFocus?Styles.price_color:Colors.black45),
                        labelText: "Password",
                        filled: true,
                        suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHidden ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Styles.price_color, width: 1.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     "Forgot Password",
                  //     style: TextStyle(
                  //         color: Colors.black, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  Padding(
                    padding:EdgeInsets.only(left: 25,right: 25,top: 20,bottom: 20),
                    child: FlatButton(
                      splashColor: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      height: 50,
                      color: Styles.price_color,
                      onPressed: () async {
                        pr = ProgressDialog(context,
                            type: ProgressDialogType.Normal,
                            isDismissible: false,
                            showLogs: true);
                        pr.style(
                            message: 'Please Wait....',
                            borderRadius: 10.0,
                            backgroundColor: Colors.white,
                            progressWidget: CircularProgressIndicator(),
                            elevation: 10.0,
                            insetAnimCurve: Curves.easeInOut,
                            progress: 0.0,
                            maxProgress: 100.0,
                            progressTextStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400),
                            messageTextStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 19.0,
                                fontWeight: FontWeight.w600));
                        if (email == null && password == null) {
                          Styles.showWarningToast(Colors.red, "Please enter required fields", Colors.white, 15);
                          // LogIn(email,password);

                        } else {
                          await pr.show();
                          LogIn(email, password);
                        }
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Halyard",
                          fontSize: MediaQuery.of(context).size.height/40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 1,
                        width: MediaQuery.of(context).size.width / 6,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Other methods",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 1,
                        width: MediaQuery.of(context).size.width / 6,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      color: Colors.black,
                      splashColor: Colors.grey,
                      icon: Icon(FontAwesomeIcons.google),
                      onPressed: () {
                        Styles.showWarningToast(Colors.deepOrange, "Coming Soon", Colors.white, 15);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(21.0),
                        child: Text(
                          "Don't have an account?",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, 'SignUp');
                          Test.fragNavigate.putPosit(key: 'Signup');
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(
                              fontFamily: "Halyard",
                              color: Styles.price_color, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void LogIn(String email, String password) async {
    UsersModel usersModel = UsersModel();
    var b = LoginData(password, email, null);
    print("${b.email},${b.password}");
    var data = await usersModel.login(b);

    if (data != null && data != "User not found" && data != "Server Error") {
      Test.accessToken = data["accessToken"];
      Test.refreshToken = data["refreshToken"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("access", data["accessToken"]).whenComplete(() => print("The access is ${data["accessToken"]}"));
      await prefs.setString("refresh", data["refreshToken"]).whenComplete(() => print("The access is ${data["refreshToken"]}"));
      var UserData = await usersModel.getUser();
      print(UserData);
      if (UserData != "User Not Found") {
        Provider.of<CartData>(context, listen: false).updateUser(UserData);
      }
      var profile = await usersModel.getProf(UserData.id);
      if(profile!="Server Error"){
        Provider.of<CartData>(context, listen: false).updateProfile(profile);
      }
      var order = await usersModel.getOrdersforUser(
          Provider.of<CartData>(context, listen: false).user.id);
      if (order != "Server Error" && order != "Orders  not found") {
        Provider.of<CartData>(context, listen: false).orders(order);
      }

      Styles.showWarningToast(Colors.green, "Successful", Colors.white, 15);
      pr.hide().then((isHidden) {
        Test.fragNavigate.putAndClean(key:'Home');
      });
    } else if (data == "Server Error") {
      pr.hide().then((isHidden) {
        Styles.showWarningToast(Colors.red, "Something is wrong. Please try again later", Colors.white, 15);
      });
    } else {
      pr.hide().then((isHidden) {
        Styles.showWarningToast(Colors.red, "Email or password is wrong", Colors.white, 15);
      });
    }
  }

  void hidePr() {
    pr.hide().then((isHidden) {
      print(isHidden);
      Styles.showWarningToast(Styles.bg_color, "Email or password is wrong", Colors.white, 15);
    });
  }

  getSizedBox(BuildContext context) {
    var type = getDeviceType(context);
    if(type == "Desktop"){
      return MediaQuery.of(context).size.height/4;
    }else{
      return MediaQuery.of(context).size.height/(5);
    }

  }
  void _requestFoucs(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }
}
getWidthAccordingToSize(BuildContext context) {
  var type = getDeviceType(context);
  if(type == "Desktop"){
    return MediaQuery.of(context).size.width/2;
  }else if(type == "Tablet"){
    return MediaQuery.of(context).size.width/(1.2);
  }else{
    return MediaQuery.of(context).size.width/(1.2);
  }
}

getHeightAccordingToSize(BuildContext context) {
  var type = getDeviceType(context);
  if(type == "Desktop"){
    return MediaQuery.of(context).size.height;
  }else if(type == "Tablet"){
    return MediaQuery.of(context).size.height;
  }else{
    return MediaQuery.of(context).size.height;
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