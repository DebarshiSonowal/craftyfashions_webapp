
import 'package:craftyfashions_webapp/Models/CartProduct.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/UI/Activity/RazorpayWeb.dart';
import 'package:craftyfashions_webapp/UI/Activity/TestingWeb.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/Photoview.dart';
import 'package:craftyfashions_webapp/UI/Fragments/AllProducts.dart';
import 'package:craftyfashions_webapp/UI/Activity/CashfreeWebPage.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Couple.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Login.dart';
import 'package:craftyfashions_webapp/UI/Fragments/About.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Cart.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Contact_Us.dart';
import 'package:craftyfashions_webapp/UI/Fragments/HomePage.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Men.dart';
import 'package:craftyfashions_webapp/UI/Fragments/OrderDetails.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Orders.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Profile.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Result.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Signup.dart';
import 'package:craftyfashions_webapp/UI/Fragments/SpecialAds.dart';
import 'package:craftyfashions_webapp/UI/Fragments/WishList.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Women.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:craftyfashions_webapp/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:fragment_navigate/navigate-support.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'CartData.dart';

class Test {
  static var bihu;

  static String url;

  static String orderId;

  static  getList() {
    return <Posit>[
      // Posit(
      //     key: 'Test',
      //     title: 'Home',
      //     fragment: Container(
      //       color: Styles.bg_color,
      //       child: BlankPage(),
      //     ),
      //     icon: Icons.add),
      Posit(
          key: 'Home',
          title: 'Home',
          fragment: Container(
            color: Styles.bg_color,
            child: HomePage(),
          ),
          icon: Icons.add),
      Posit(
          key: 'Profile',
          title: 'Profile',
          fragment: ProfilePage(),
          icon: Icons.accessibility),
      Posit(key: 'Cart', title: 'Cart', fragment: Cart(), icon: Icons.ac_unit),
      Posit(
          key: 'Men', title: 'Men', fragment: MenProducts(), icon: Icons.code),
      Posit(
          key: 'Women',
          title: 'Women',
          fragment: WomenProducts(),
          icon: Icons.code),
      Posit(
          key: 'WishList',
          title: 'Wishlist',
          fragment: WishList(),
          icon: Icons.code),
      Posit(
          key: 'Orders', title: 'Orders', fragment: Orders(), icon: Icons.code),
      Posit(
          key: 'Contact Us',
          title: 'Contact Us',
          fragment: ContactUs(),
          icon: Icons.code),
      Posit(key: 'About', title: 'About', fragment: About(), icon: Icons.code),
      Posit(
          key: 'Login',
          title: 'Login',
          fragment: Login(),
          icon: Icons.code),
      Posit(
          key: 'Signup', title: 'Signup', fragment: Signup(), icon: Icons.code),
      Posit(
          key: 'Result', title: 'Crafty', fragment: Result(), icon: Icons.code),
      Posit(
          key: 'photo',
          title: 'Crafty',
          fragment: Photoview(Test.url),
          icon: Icons.code),
      Posit(
          key: 'All',
          title: 'All Products',
          icon: Icons.code,
          fragment: AllProductsFragment()),
      Posit(
          key: 'Details',
          title: 'Details',
          icon: Icons.code,
          fragment: OrderDetails()),
      Posit(
          key: 'Special',
          title:
          'Special',
          icon: Icons.code,
          fragment: SpecialAds()),
      Posit(
          key: 'Payment',
          title:
          "Payment",
          icon: Icons.code,
          fragment: TestingWeb()),
      Posit(
          key: 'Couple', title: 'Couple', icon: Icons.code, fragment: Couple()
      )
      ,
    ];
  }

  static String specialTag=null;

  static saveKeys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access', Test.accessToken);
    await prefs.setString('refresh', Test.refreshToken);
  }
//Auth
  static Future<String> access() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('access');
  }

  static Future<String> refresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('refresh');
  }

  static String accessToken, refreshToken;
  var message;
  static var fragNavigate;

  static List<Products> special = null;

  static List<CartProduct> cart = null;

  static List<Products> products = null;

  static List<Products> Men = null;

  static addToCart(CartProduct cartProduct) {
    cart.add(cartProduct);
    print(cartProduct);
  }
  static getAllProducts(BuildContext context) async{
    UsersModel usersModel = UsersModel();
    var Data = await usersModel.getAll();
    if (Data.toString() != "Server Error" ||
        Data.toString() != "Products not found") {
      List<Products> data = Data;
      if (data != null) {
        Provider.of<CartData>(context, listen: false)
            .setAllProduct(data);
        addData(data,context);
      }
    }
  }
  static addData(List<Products> data,BuildContext context) {
    List<Products> men = [];
    List<Products> women = [];
    if (data != null) {
      for (var i in data) {
        if (i.Gender == "MALE") {
          men.add(i);
        } else {
          women.add(i);
        }
      }
      Provider.of<CartData>(context, listen: false).setMen(men);
      Provider.of<CartData>(context, listen: false).setWomen(women);
    } else {
      print("empty");
    }
  }

  static List<String> currentIds = [];

  static List<CartProduct> currentCartItems = [];

  static get() {
    for (var i in currentCartItems) {
      currentIds.add(i.UID.toString());
    }
    return currentIds;
  }
}
