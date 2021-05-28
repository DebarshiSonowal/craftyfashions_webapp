// import 'dart:math';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:craftyfashions_webapp/Helper/CartData.dart';
// import 'package:craftyfashions_webapp/Helper/DioError.dart';
// import 'package:craftyfashions_webapp/Helper/Test.dart';
// import 'package:craftyfashions_webapp/Models/Address.dart';
// import 'package:craftyfashions_webapp/Models/Order.dart';
// import 'package:craftyfashions_webapp/Models/ServerOrder.dart';
// import 'package:craftyfashions_webapp/UI/CustomWidgets/EmptyView.dart';
// import 'package:craftyfashions_webapp/UI/CustomWidgets/PaymentOptionsMethod.dart';
// import 'package:craftyfashions_webapp/UI/CustomWidgets/ProductItemView.dart';
// import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
// import 'package:craftyfashions_webapp/Utility/Users.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:provider/provider.dart';
// import 'NewAddressPage.dart';
// import 'ProductView.dart';
//
// class BlankPage extends StatefulWidget {
//   const BlankPage({Key key}) : super(key: key);
//
//   @override
//   _BlankPageState createState() => _BlankPageState();
// }
//
// class _BlankPageState extends State<BlankPage> {
//   int item = 0;
//   var products, id;
//   double price = 0.00;
//   ServerOrder order;
//   Widget emptyListWidget;
//   TextEditingController pinT, phT, addT1, addTtown, addTdis, addTstate;
//
//   Future<ServerOrder> getEveryThing(double price) async {
//     UsersModel usersModel = UsersModel();
//     return await usersModel.getOrder(price);
//   }
//
//   @override
//   void initState() {
//     pinT = TextEditingController();
//     phT = TextEditingController();
//     addT1 = TextEditingController();
//     addTtown = TextEditingController();
//     addTdis = TextEditingController();
//     addTstate = TextEditingController();
//     read("data");
//     new Future.delayed(Duration.zero, () {
//       _context = context;
//       pr = ProgressDialog(context,
//           type: ProgressDialogType.Normal,
//           isDismissible: false,
//           showLogs: true);
//       pr.style(
//           message: 'Please Wait....',
//           borderRadius: 10.0,
//           backgroundColor: Colors.white,
//           progressWidget: CircularProgressIndicator(),
//           elevation: 10.0,
//           insetAnimCurve: Curves.easeInOut,
//           progress: 0.0,
//           maxProgress: 100.0,
//           progressTextStyle: TextStyle(
//               color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
//           messageTextStyle: TextStyle(
//               color: Colors.black,
//               fontSize: 19.0,
//               fontWeight: FontWeight.w600));
//     });
//     super.initState();
//     setState(() {
//       emptyListWidget = Styles.EmptyError;
//     });
//     Provider.of<CartData>(context, listen: false).profile == null
//         ? getAddressfromInternet()
//         : null;
//   }
//
//   @override
//   void dispose() {
//     var json = jsonEncode(Provider.of<CartData>(context, listen: false)
//         .list
//         .map((e) => e.toJson())
//         .toList());
//     save("data", json);
//     pinT.dispose();
//     phT.dispose();
//     addT1.dispose();
//     addTtown.dispose();
//     addTdis.dispose();
//     addTstate.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     item = Provider.of<CartData>(context).listLength;
//     _context = context;
//     return Container(
//       child: Provider.of<CartData>(context).listLength == 0
//           ? EmptyView(
//         txt: "Oops No Item in the Cart\nAdd some items to checkout",
//       )
//           : CartScreenn(
//         item: item,
//         save: save,
//         onOrderInit: () {
//           if (Provider.of<CartData>(context, listen: false).user !=
//               null) {
//             showModalBottomSheet(
//                 context: context,
//                 isDismissible: true,
//                 isScrollControlled: true,
//                 builder: (BuildContext context) {
//                   return initModel(context);
//                 });
//           } else {
//             Styles.showSnackBar(context, Colors.yellow,
//                 Duration(seconds: 3), 'Log in', Colors.white, () {
//                   setState(() {
//                     Test.fragNavigate.putPosit(key: 'Login');
//                   });
//                 });
//           }
//         },
//       ),
//     );
//   }
//   void save(String key, value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(key, value);
//   }
//
//   void read(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     var v = prefs.getString(key);
//     if (v != null) {
//       List<CartProduct> list = [];
//       for (var i in jsonDecode(v)) {
//         list.add(CartProduct.fromJson(i));
//       }
//       Provider.of<CartData>(context, listen: false).list = list;
//     }
//   }
//
//   remove(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(key);
//   }
//
//   bool checkIfempty(BuildContext context) {
//     if (Provider.of<CartData>(context, listen: false).user != null) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   Order saveToDatabase(id, double amount, String status, BuildContext context) {
//     return Order(
//         Provider.of<CartData>(context, listen: false).Colours,
//         "15-02-21",
//         Provider.of<CartData>(context, listen: false).Names,
//         Provider.of<CartData>(context, listen: false).user.email,
//         status,
//         Provider.of<CartData>(context, listen: false).ids,
//         Provider.of<CartData>(context, listen: false)
//             .Pictures
//             .split(",")[0]
//             .trim(),
//         amount,
//         Provider.of<CartData>(context, listen: false).quantity,
//         Provider.of<CartData>(context, listen: false).Sizes,
//         "Preparing",
//         id,
//         Provider.of<CartData>(context, listen: false).user.id,
//         Provider.of<CartData>(context, listen: false).getAddress.address,
//         Provider.of<CartData>(context, listen: false).getAddress.phone,
//         Provider.of<CartData>(context, listen: false).getAddress.pin,
//         "NOT AVAILABLE");
//   }
//
//   Widget initModel(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//       child: Container(
//         height: MediaQuery.of(context).size.height / 4,
//         child: Provider.of<CartData>(context, listen: false).profile.address !=
//             null
//             ? WithOptionBottomSheet(defaultAddress, getAddress, showPaymentDialog,
//             addT1, addTtown, addTdis, addTstate, phT, pinT)
//             :  WithoutOptionsBottomSheet(
//             saveDetails, addT1, addTtown, addTdis, addTstate, phT, pinT),
//       ),
//     );
//   }
//
//   defaultAddress() {
//     Provider.of<CartData>(context, listen: false).setAddress(Address(
//         Provider.of<CartData>(context, listen: false).profile.address,
//         Provider.of<CartData>(context, listen: false).profile.phone.toString(),
//         Provider.of<CartData>(context, listen: false)
//             .profile
//             .pincode
//             .toString()));
//     Navigator.pop(context);
//     showPaymentDialog();
//   }
//
//   void saveDetails(BuildContext context) async {
//     await pr.show();
//     UsersModel usersModel = new UsersModel();
//     var data = await usersModel.saveProf(Profile(
//         Provider.of<CartData>(context, listen: false).profile.id,
//         Provider.of<CartData>(context, listen: false).profile.name,
//         Provider.of<CartData>(context, listen: false).profile.email,
//         getAddress(),
//         int.parse(phT.text),
//         int.parse(pinT.text),
//         null));
//     if (data != null) {
//       pr.hide().then((isHidden) {
//         Fluttertoast.showToast(
//             msg: "Successful",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.black,
//             fontSize: 16.0);
//         Provider.of<CartData>(context, listen: false)
//             .updateProfile(Profile.fromJson(data));
//         Navigator.pop(context);
//       });
//     } else {
//       pr.hide().then((isHidden) {
//         Navigator.pop(context);
//         Fluttertoast.showToast(
//             msg: "Failed",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.black,
//             fontSize: 16.0);
//       });
//     }
//   }
//
//   String getAddress() {
//     return addT1.text.trim() +
//         "," +
//         addTtown.text.trim() +
//         "," +
//         addTdis.text.trim() +
//         "," +
//         addTstate.text.trim();
//   }
//
//   void showPaymentDialog() {
//     Dialogs.materialDialog(
//         msg: 'Select how do you want to pay?',
//         title: "Payment Mode",
//         color: Colors.white,
//         context: context,
//         actions: [
//           IconsButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               await pr.show();
//               UsersModel usersModel = UsersModel();
//               const _chars =
//                   'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
//               Random _rnd = Random();
//               String getRandomString(int length) =>
//                   String.fromCharCodes(Iterable.generate(length,
//                           (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
//               Styles.showWarningToast(
//                   Colors.green, "Successful", Colors.white, 15);
//
//               var id = "order_cod_" + getRandomString(5);
//               try {
//                 var a = await usersModel.saveOrderDatabase(
//                     saveToDatabase(
//                         id,
//                         Provider.of<CartData>(_context, listen: false)
//                             .getPrice() *
//                             100,
//                         "COD",
//                         _context),
//                     Provider.of<CartData>(_context, listen: false).name == null
//                         ? Provider.of<CartData>(_context, listen: false)
//                         .user
//                         .name
//                         : Provider.of<CartData>(_context, listen: false).name);
//                 if (a != null && a != "Unable to save order") {
//                   Provider.of<CartData>(context, listen: false)
//                       .removeAll(0, CartData.listLengths);
//                   setState(() {
//                     pr.hide().then((isHidden) {
//                       CartData.RESULT = "assets/raw/successful.json";
//                       CartData.TXT = id;
//                       Test.fragNavigate.putPosit(key: 'Result');
//                     });
//                   });
//                 } else {
//                   pr.hide().then((isHidden) {
//                     CartData.RESULT = "assets/raw/failed.json";
//                     CartData.TXT = id;
//                     Test.fragNavigate.putPosit(key: 'Result');
//                   });
//                 }
//               } on DioError catch (e) {
//                 final errorMessage = DioExceptions.fromDioError(e).toString();
//                 print(errorMessage);
//               }
//               // var c = usersModel1.saveOrderDatabase()
//               // usersModel1.saveOrderDatabase();
//             },
//             text: 'COD',
//             iconData: FontAwesomeIcons.box,
//             color: Colors.red,
//             textStyle: TextStyle(color: Colors.white),
//             iconColor: Colors.white,
//           ),
//           IconsButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               await pr.show();
//               var cx = Provider.of<CartData>(context, listen: false)
//                   .razorpay
//                   .Key
//                   .toString();
//               if (Provider.of<CartData>(context, listen: false).razorpay !=
//                   null) {
//                 products = Provider.of<CartData>(context, listen: false).list;
//                 try {
//                   id = await getEveryThing(
//                       Provider.of<CartData>(context, listen: false)
//                           .getPrice())
//                       .then((value) {
//                     return value.id;
//                   });
//                   Provider.of<CartData>(context, listen: false).setOrderId(id);
//                 } catch (e) {
//                   print(e);
//                 }
//                 Test.currentCartItems =
//                     Provider.of<CartData>(context, listen: false).list;
//                 try {
//                   pr.hide().then((isHidden) {
//                     Test.fragNavigate.putPosit(key: 'Payment', force: true);
//                     // Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (context) => RazorPayWeb()));
//                   });
//                 } catch (e) {
//                   print("VVVV $e");
//                 }
//               } else {
//                 Styles.showWarningToast(
//                     Colors.red, "Failed Please Log out", Colors.white, 15);
//               }
//             },
//             text: 'PAY',
//             iconData: FontAwesomeIcons.dollarSign,
//             color: Colors.green,
//             textStyle: TextStyle(color: Colors.white),
//             iconColor: Colors.white,
//           ),
//         ]);
//   }
//
//   getAddressfromInternet() async {
//     if (Provider.of<CartData>(context, listen: false).user!=null) {
//       UsersModel usersModel3 = UsersModel();
//       var profile = await usersModel3
//           .getProf(Provider.of<CartData>(context, listen: false).user.id);
//       if (profile != "Server Error" && profile != null) {
//         Provider.of<CartData>(context, listen: false).updateProfile(profile);
//       }
//     }
//   }
// }
