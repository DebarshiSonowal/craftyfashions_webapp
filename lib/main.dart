import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Helper/CartData.dart';
import 'UI/Activity/Host.dart';
import 'UI/Activity/Login.dart';
import 'UI/Styling/Styles.dart';
import 'package:sizer/sizer.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CartData(),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              'login': (context) => Login(),
            },
            title: 'Crafty',
            theme: ThemeData(
              // primarySwatch: Colors.yellow,
              primaryColor: Styles.Log_sign,
              backgroundColor: Styles.bg_color,
              buttonColor: Styles.button_color,
            ),
            home: Host(),
          );
        },
      ),
    );
  }
}


