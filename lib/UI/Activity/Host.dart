import 'dart:async';
import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/DataSearch.dart';
import 'package:craftyfashions_webapp/Helper/Navigation.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/UI/Activity/RazorpayWeb.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/Photoview.dart';
import 'package:craftyfashions_webapp/UI/Fragments/About.dart';
import 'package:craftyfashions_webapp/UI/Fragments/AllProducts.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Cart.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Contact_Us.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Couple.dart';
import 'package:craftyfashions_webapp/UI/Fragments/HomePage.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Login.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Men.dart';
import 'package:craftyfashions_webapp/UI/Fragments/OrderDetails.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Orders.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Profile.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Result.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Signup.dart';
import 'package:craftyfashions_webapp/UI/Fragments/SpecialAds.dart';
import 'package:craftyfashions_webapp/UI/Fragments/WishList.dart';
import 'package:craftyfashions_webapp/UI/Fragments/Women.dart';
import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:craftyfashions_webapp/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:fragment_navigate/navigate-support.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Host extends StatefulWidget {
  @override
  HostState createState() => HostState();
}

class HostState extends State<Host> {
  static int o = 0;
  static var id;
  static var bottom;
  static FragNavigate _fragNav;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var acc = prefs.get('access');
    var ref = prefs.get('refresh');
    print(acc);
    if (acc != null && ref != null) {
      Test.accessToken = acc;
      Test.refreshToken = ref;
    }
  }

  @override
  void initState() {
    // getLoginData();
    _fragNav = FragNavigate(
      firstKey: 'Home',
      drawerContext: null,
      screens: getList(),
    );
    new Future.delayed(Duration.zero, () {
      _fragNav.setDrawerContext = context;
      // if(Provider.of<CartData>(context, listen: false).allproducts.length==0){
      //   getEverything(context);
      // }
    });
    super.initState();
  }

  @override
  void dispose() {
    _fragNav.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      Test.fragNavigate = _fragNav;
      _fragNav.setDrawerContext = context;
    } catch (e) {
      print("pROBLEM $e");
    }
    return WillPopScope(
      onWillPop: () {
        if (_fragNav.stack.length > 1) {
          _fragNav.jumpBack();
          return Future.value(false);
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit an App'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      SystemChannels.platform.invokeMethod(
                          'SystemNavigator.pop');
                    },
                    child: new Text('Yes'),
                  ),
                ],
              );
            },
          ).whenComplete(() => Future.value(false));
          return Future.delayed(Duration(seconds: 3), () {
            return Future.value(false);
          });
        }
      },
      child: StreamBuilder<FullPosit>(
          stream: _fragNav.outStreamFragment,
          builder: (con, s) {
            if (s.data != null) {
              return Scaffold(
                key: _fragNav.drawerKey,
                appBar: AppBar(
                  title: Text(s.data.title),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(
                            context: context, delegate: DataSearch(_fragNav));
                      },
                    )
                  ],
                  bottom: s.data.bottom.child,
                ),
                drawer: NavDrawer(_fragNav),
                bottomNavigationBar: !checkifMobile()
                    ? null
                    : BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.verified_user),
                      label: 'Profile',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.add_shopping_cart),
                      label: 'Cart',
                    ),
                  ],
                  currentIndex: _fragNav.screenList.keys
                      .toList()
                      .indexOf(_fragNav.currentKey) >
                      2
                      ? 0
                      : _fragNav.screenList.keys
                      .toList()
                      .indexOf(_fragNav.currentKey),
                  selectedItemColor: Colors.black,
                  backgroundColor: Colors.white70,
                  onTap: (index) {
                    setState(() {
                      bottom = index;
                      var b = _fragNav.screenList.keys.toList();
                      var c = _fragNav.actionsList;
                      if (c != null) {
                        _fragNav.putPosit(key: b[index]);
                      } else {
                        initialize();
                        try {
                          _fragNav.putPosit(key: b[index]);
                        } catch (e) {
                          print("GGOt $e");
                        }
                      }
                    });
                  },
                ),
                body: DefaultTabController(
                  length: s.data.bottom.length,
                  child: ScreenNavigate(child: s.data.fragment, bloc: _fragNav),
                ),
              );
            }

            return Container();
          }),
    );
  }

  void getEverything(BuildContext context) async {
    if (Provider
        .of<CartData>(context, listen: false)
        .allproducts == null || Provider
        .of<CartData>(context, listen: false)
        .allproducts
        .length == 0) {
      UsersModel usersModel = UsersModel();
      var Data = await usersModel.getAll();
      List<Products> data = [];
      if (Data.toString() == "Server Error" ||
          Data.toString() == "Products not found") {
        showMaterialDialog();
      } else {
        data = Data;
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
          setState(() {
            Provider.of<CartData>(context, listen: false).setAllProduct(data);
            Provider.of<CartData>(context, listen: false).setMen(men);
            Provider.of<CartData>(context, listen: false).setWomen(women);
          });
        } else {
          print("empty");
        }
      }
    }
  }

  getList() {
    return <Posit
    >[
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
    fragment: Login(_fragNav),
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
    Provider.of<CartData>(context, listen: false).specialTxt == null
    ? 'Special'
        : Provider.of<CartData>(context, listen: false).specialTxt,
    icon: Icons.code,
    fragment: SpecialAds()),
    Posit(
    key: 'Payment',
    title:
    "Payment",
    icon: Icons.code,
    fragment: RazorPayWeb()),
    Posit(
    key: 'Couple', title: 'Couple', icon: Icons.code, fragment: Couple()
    )
    ,
    ];
  }

  void initialize() {
    _fragNav = FragNavigate(
      firstKey: 'Home',
      drawerContext: null,
      screens: getList(),
    );
    Test.fragNavigate = _fragNav;
    _fragNav.setDrawerContext = context;
  }

  checkifMobile() {
    if (MediaQuery
        .of(context)
        .size
        .width >= kDesktopBreakpoint || MediaQuery
        .of(context)
        .size
        .width >= kTabletBreakpoint) {
      print("False");
      return false;
    } else {
      return true;
    }
  }

  clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Test.accessToken = null;
    Test.refreshToken = null;
    Provider.of<CartData>(context, listen: false).removeOrders(
        Provider
            .of<CartData>(context, listen: false)
            .order
            .length);
    Provider.of<CartData>(context, listen: false).removeProfile();
    Navigator.pop(context);
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  showMaterialDialog() {
    Dialogs.materialDialog(
        msg: 'Sorry Something is wrong',
        title: "Server Error",
        color: Colors.white,
        context: context,
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: 'Accepted',
            iconData: Icons.delete,
            color: Colors.red,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }
}
