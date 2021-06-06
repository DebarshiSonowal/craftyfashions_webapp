import 'package:craftyfashions_webapp/Helper/CashOrder.dart';
import 'package:craftyfashions_webapp/Models/CartProduct.dart';
import 'package:craftyfashions_webapp/Models/LoginData.dart';
import 'package:craftyfashions_webapp/Models/Order.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/Models/Profile.dart';
import 'package:craftyfashions_webapp/Models/ServerOrder.dart';
import 'package:craftyfashions_webapp/Models/SignUpData.dart';
import 'package:craftyfashions_webapp/Models/User.dart';

import 'NetworkHelper.dart';

const url = "https://officialcraftybackend.herokuapp.com/users/";
// const url = "http://10.0.2.2:3000/users/";
// const url = "http://localhost:3000/users/";

class UsersModel {
  Future<dynamic> login(LoginData loginData) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    print("HERE");
    var Data = await networkHelper.log(loginData);
    return Data;
  }

  Future<dynamic> cancel(var orderId, var email) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    var Data = await networkHelper.cancel(orderId, email);
    return Data;
  }

  Future<dynamic> signuP(SignUpData signUpData) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    var Data = await networkHelper.sign(signUpData);
    return Data;
  }

  Future<dynamic> saveProf(Profile profile) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    return await networkHelper.saveProf(profile);
  }

  Future<dynamic> getProf(String id) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    var d = await networkHelper.getProf(id);
    if (d != 500) {
      Profile profile = Profile.fromJson(d);
      return profile;
    } else {
      return "Server Error";
    }
  }

  Future<dynamic> getOrdersforUser(String id) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    var data = await networkHelper.getordersforUser(id);
    if (data != "Server Error" && data != "Orders  not found") {
      List<Order> Data = data;
      return Data;
    } else {
      return "Orders  not found";
    }
  }

  Future<dynamic> getUser() async {
    NetworkHelper networkHelper = NetworkHelper(url);
    print('c');
    var user1 = await networkHelper.getuser();
    if (user1 != "User not found" && user1 != "Server Error") {
      print("DFgs ${user1}");
      User user =
          User(user1["name"], user1["_id"], user1["email"], user1["googleId"]);
      return user;
    }
    print("DFg1 $user1");
    return "User Not Found";
  }

  Future<dynamic> getAll() async {
    NetworkHelper networkHelper = NetworkHelper(url);
    List<Products> Data = await networkHelper.getAll();
    return Data;
  }

  Future<dynamic> getCart(var uid) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    List<CartProduct> Data = await networkHelper.getCart(uid);
    return Data;
  }

  Future<dynamic> getSignature(var cashOrder) async{
    NetworkHelper networkHelper = NetworkHelper(url);
    var Data = await networkHelper.getSignature(cashOrder);
    return Data;
  }
  
  Future<dynamic> AddToCart(CartProduct cartProduct) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    dynamic Data = await networkHelper.addtoCart(cartProduct);
    return Data;
  }

  Future<dynamic> savePayment(CashOrder cashOrder) async{
    NetworkHelper networkHelper = NetworkHelper(url);
    var data = await networkHelper.payOrder(cashOrder);
    return data;
  }
  Future<dynamic> getOrder(double price) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    ServerOrder serverOrder =
        ServerOrder.fromJson(await networkHelper.getorder(price));
    print("HEREczccz ${serverOrder.id}");
    return serverOrder;
  }

  Future<dynamic> saveOrderDatabase(Order orders, String name) async {
    print("GOT ist");
    NetworkHelper networkHelper = NetworkHelper(url);
    var order = await networkHelper.saveOrderdatabase(orders, name);
    return order;
  }

  Future<dynamic> triggerResponse(dynamic id, dynamic email) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    return await networkHelper.triggerResponse(id, email);
  }

  Future<dynamic> saveOrder(dynamic body) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    var v = await networkHelper.saveorder(body);
    return v;
  }

  Future<dynamic> getRequired() async {
    NetworkHelper networkHelper = NetworkHelper(url);
    var v = await networkHelper.getRequired();
    return v;
  }
}
