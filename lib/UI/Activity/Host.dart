import 'dart:async';
import 'package:badges/badges.dart';
import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/DataSearch.dart';
import 'package:craftyfashions_webapp/Helper/Navigation.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/Ads.dart';
import 'package:craftyfashions_webapp/Models/Categories.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/Models/Razorpay.dart';
import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
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
    print("The tokens are ${acc} and ${ref}");
    if (acc != null && ref != null) {
      Test.accessToken = acc;
      Test.refreshToken = ref;
      getEverything(context);
    } else {
      getEverything(context);
    }
  }

  @override
  void initState() {
    // getLoginData();
    _fragNav = FragNavigate(
      // firstKey: 'Home',
      firstKey: 'Home',
      drawerContext: null,
      screens: Test.getList(),
    );
    new Future.delayed(Duration.zero, () {
      _fragNav.setDrawerContext = context;
    });
    getLoginData();
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
        }else{
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: StreamBuilder<FullPosit>(
            stream: _fragNav.outStreamFragment,
            builder: (con, s) {
              if (s.data != null) {
                return Scaffold(
                  key: _fragNav.drawerKey,
                  appBar: AppBar(
                    titleSpacing:0,
                    leading: IconButton(
                      iconSize: 25,
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        _fragNav.drawerKey.currentState.openDrawer();
                      },
                    ),
                    title: Padding(
                      padding:EdgeInsets.only(top:6),
                      child: TextButton(
                        onPressed: () {
                          _fragNav.putPosit(key: "Home");
                        },
                        child: Text(
                          "Crafty",
                          style: TextStyle(
                            fontFamily: "Beyond",
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: Badge(
                            showBadge:
                                Provider.of<CartData>(context).listLength == 0
                                    ? false
                                    : true,
                            badgeContent: Text(
                                "${Provider.of<CartData>(context).listLength}"),
                            animationType: BadgeAnimationType.scale,
                            child: Icon(Icons.add_shopping_cart)),
                        onPressed: () {
                          _fragNav.putPosit(key: "Cart");
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(
                              context: context, delegate: DataSearch(_fragNav));
                        },
                      ),
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
                          backgroundColor: Color(0xffeeeeee),
                          onTap: (index) => changeFragment(index),
                        ),
                  body: DefaultTabController(
                    length: s.data.bottom.length,
                    child:
                        ScreenNavigate(child: s.data.fragment, bloc: _fragNav),
                  ),
                );
              }

              return Container();
            }),
      ),
    );
  }

  void getEverything(BuildContext context) async {
    UsersModel usersModel1 = UsersModel();
    UsersModel usersModel3 = UsersModel();
    UsersModel usersModel4 = UsersModel();
    var data = await usersModel1.getRequired();
    if (data != "Server Error") {
      var data3 = data['razorpay'];
      Provider.of<CartData>(context, listen: false)
          .setRazorpay(Razorpay.fromJson(data3));
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

    if (Test.accessToken != null) {
      var profile = await usersModel3
          .getProf(Provider.of<CartData>(context, listen: false).user.id);
      if (profile != "Server Error" && profile != null) {
        Provider.of<CartData>(context, listen: false).updateProfile(profile);
      }
    }

    if (Provider.of<CartData>(context, listen: false).allproducts == null ||
        Provider.of<CartData>(context, listen: false).allproducts.length == 0) {
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

  void initialize() {
    _fragNav = FragNavigate(
      firstKey: 'Home',
      drawerContext: null,
      screens: Test.getList(),
    );
    Test.fragNavigate = _fragNav;
    _fragNav.setDrawerContext = context;
  }

  checkifMobile() {
    if (MediaQuery.of(context).size.width >= kDesktopBreakpoint ||
        MediaQuery.of(context).size.width >= kTabletBreakpoint) {
      return false;
    } else {
      return false;
    }
  }

  clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Test.accessToken = null;
    Test.refreshToken = null;
    Provider.of<CartData>(context, listen: false).removeOrders(
        Provider.of<CartData>(context, listen: false).order.length);
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

  changeFragment(int index) {
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
  }
}
