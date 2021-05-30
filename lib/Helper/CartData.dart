import 'dart:collection';
import 'dart:convert';
import 'package:craftyfashions_webapp/Models/Address.dart';
import 'package:craftyfashions_webapp/Models/Ads.dart';
import 'package:craftyfashions_webapp/Models/CartProduct.dart';
import 'package:craftyfashions_webapp/Models/Categories.dart';
import 'package:craftyfashions_webapp/Models/Order.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/Models/Profile.dart';
import 'package:craftyfashions_webapp/Models/Razorpay.dart';
import 'package:craftyfashions_webapp/Models/User.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartData extends ChangeNotifier {
  static List<CartProduct> _list = [
    CartProduct("Nt.Blue", "499", "https://firebasestorage.googleapis.com/v0/b/crafty-fashions-assam.appspot.com/o/testinng%2FFOBP01_adobespark.png?alt=media&token=d5e84bfc-75e8-440e-9542-fcc6cee91c28", 1, "XL", "Dilbar mere", "106412"),
    CartProduct("Ntr.Blue", "499", "https://firebasestorage.googleapis.com/v0/b/crafty-fashions-assam.appspot.com/o/testinng%2FFOBP01_adobespark.png?alt=media&token=d5e84bfc-75e8-440e-9542-fcc6cee91c28", 2, "XXL", "Dilbar mere bassa", "142412"),
    CartProduct("N.Blue", "599", "https://firebasestorage.googleapis.com/v0/b/crafty-fashions-assam.appspot.com/o/testinng%2FFOBP01_adobespark.png?alt=media&token=d5e84bfc-75e8-440e-9542-fcc6cee91c28", 3, "M", "Dilbar mere aqwf", "152412"),
    CartProduct("N2.Blue", "499", "https://firebasestorage.googleapis.com/v0/b/crafty-fashions-assam.appspot.com/o/testinng%2FFOBP01_adobespark.png?alt=media&token=d5e84bfc-75e8-440e-9542-fcc6cee91c28", 1, "XL", "Dilbar mere", "102412")
  ];
  Map<String, String> paymentdata;
  User _user = null;
  Profile _profile = null;
  List<Order> _order = [];
  List<Products> _allproducts = [];
  List<Products> _men = [];
  List<Products> _women = [];
  List<Products> _couple = [];
  static String RESULT = "assets/raw/loading.json", TXT = "Successful",price,id;
  Razorpay _razorpay = null;
  List<Categories> _categ = [];
  List<Ads> _ads = [];
  String _specialTxt;
  List<Products> _special =[];
  String address,name;
  Address _address;
  String _orderId;
  Order _orderSelected;

//Set
  void setAddress(Address value) {
    _address = value;
    notifyListeners();
    print("${_address.address}");
  }

  void setOrderId(String id){
    _orderId = id;
    notifyListeners();
  }

  void setOrderSelected(Order value) {
    _orderSelected = value;
    notifyListeners();
  }

  void setCategory(List<Categories> list) {
    _categ = list;
    notifyListeners();
  }
  void setSpecial(List<Products>list){
    _special = list;
    notifyListeners();
  }
  void setSpecialTag(String tag){
    _specialTxt = tag;
    notifyListeners();
  }
  void setCouple(List<Products> list){
    _couple = list;
    notifyListeners();
  }
  void setRazorpay(Razorpay razorpay) {
    _razorpay = razorpay;
    notifyListeners();
  }

  void setAds(List<Ads> ads) {
    _ads = ads;
    notifyListeners();
  }

  void setAllProduct(List<Products> product) {
    _allproducts = product;
    print(product.length);
    notifyListeners();
  }

  void setMen(List<Products> product) {
    _men = product;
    notifyListeners();
  }

  void setWomen(List<Products> product) {
    _women = product;
    notifyListeners();
  }

  void orders(List<Order> value) {
    _order = value;
    print(value);
  }

  void updateProfile(Profile profile) {
    _profile = profile;
    Styles.showWarningToast(Colors.green, "Profile Updated", Colors.white, 15);
    notifyListeners();
  }

  void removeProfile(){
    _profile = null;
    notifyListeners();
  }
  void removeOrders(int len){
    _order.removeRange(0, len);
    notifyListeners();
  }

  void updateUser(User user) {
    print(user.name);
    _user = user;
    notifyListeners();
  }

  set list(List<CartProduct> value) {
    _list = value;
    notifyListeners();
  }

  void Update(List<CartProduct> List) {
    _list = List;
    notifyListeners();
  }

  void addProduct(CartProduct cartProduct) {
    _list.add(cartProduct);
    print(cartProduct.quantity);
    Styles.showWarningToast(Colors.green, "Item added", Colors.white, 15);
    saveInfo();
    notifyListeners();
  }

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  static void saveInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("data", listString);
  }

//Get
  List<Products> get allproducts => _allproducts;

  Order get orderSelected => _orderSelected;

  Profile get profile => _profile;

  User get user {
    return _user;
  }


  String get orderId => _orderId;

  Address get getAddress => _address;

  List<Products> get couple => _couple;

  List<Products> get special => _special;

  Razorpay get razorpay => _razorpay;

  List<Ads> getAds() {
    return List<Ads>.unmodifiable(_ads);
  }


  List<String> getAdImage() {
    List<String> list = [];
    for (var i in getAds()) {
      list.add(i.picture);
    }
    return list;
  }

  List<Categories> getCateg() {
    return List<Categories>.unmodifiable(_categ);
  }

  List<Order> get order => List<Order>.unmodifiable(_order);

  List<CartProduct> get list {
    return List<CartProduct>.unmodifiable(_list);
  }

  static String get listString {
    List<Map<String, dynamic>> jsonData =
    _list.map((word) => word.toJson()).toList();
    return jsonEncode(jsonData);
  }

  String get ids {
    List<String> a = [];
    for (var b in _list) {
      a.add("${b.UID}");
    }
    return a.join(",");
  }

  String get names {
    var a = "";
    for (var b in list) {
      a += b.name;
    }
    return a;
  }

  UnmodifiableListView<CartProduct> get listview {
    return UnmodifiableListView(_list);
  }

  static int get listLengths {
    return _list.length;
  }

  int get listLength {
    return _list.length;
  }

  String get specialTxt => _specialTxt;

  double getPrice() {
    double price = 0;
    for (int i = 0; i < _list.length; i++) {
      price += double.parse(_list[i].payment.toString()) * _list[i].quantity;
      print(double.parse(_list[i].payment.toString()) * _list[i].quantity);
    }
    return price;
  }

  String get Colours {
    List<String> col = [];
    for (var i in _list) {
      print(i.color.toString());
      col.add(i.color.toString().trim());
    }
    return col.join(",");
  }

  String get Pictures {
    List<String> col = [];
    for (var i in _list) {
      col.add(i.picture);
    }
    return col.join(",");
  }

  String get Sizes {
    List<String> col = [];
    for (var i in _list) {
      col.add(i.size);
    }
    return col.join(",");
  }

  String get Names {
    List<String> col = [];
    for (var i in _list) {
      col.add(i.name);
    }
    return col.join(",");
  }

  List<int> get Quantity {
    List<int> col = [];
    for (var i in _list) {
      col.add(i.quantity);
    }
    return col;
  }
int get noOfTotalItems{
    int a = 0;
    for(var i in _list){
      a += i.quantity;
    }
    return a;
}
  String get quantity {
    List<String> col = [];
    for (var i in _list) {
      col.add(i.quantity.toString());
    }
    return col.join(",");
  }

  List<Products> get men => _men;

  List<Products> get women => _women;

  //Remove
  static void removeALL(int first, int second) {
    _list.removeRange(first, second);
    print("Removed");
    saveInfo();
  }

  void removeAll(int first, int second) {
    _list.removeRange(first, second);
    saveInfo();
    notifyListeners();
  }

  void removeProduct(int index) {
    _list.removeAt(index);
    notifyListeners();
  }
}
