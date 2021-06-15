import 'dart:async';

import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/AllProductsFragmentProductItemview.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/LoadingAnimation.dart';
import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:craftyfashions_webapp/Utility/Users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ProductView.dart';

class MenProducts extends StatefulWidget {
  @override
  _MenProductsState createState() => _MenProductsState();

  MenProducts();
}

class _MenProductsState extends State<MenProducts> {
  get buttonSize => 20.0;
  bool showError = false;
  Widget emptyListWidget;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  BuildContext sysContext;

  @override
  Widget build(BuildContext context)
  {
    sysContext = context;
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load ");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 75.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child:
            Provider.of<CartData>(context, listen: true).allproducts.length ==
                        0 &&
                    showError
                ? emptyListWidget
                : getUI(),
      ),
    );
  }

  @override
  void initState() {
    emptyListWidget = Styles.EmptyError;
    super.initState();
    Timer(Duration(seconds: 7), () {
      changevalue();
    });
  }

  getUI() {
    return Provider.of<CartData>(context, listen: true).allproducts.length == 0
        ? LoadingAnimation(
            Provider.of<CartData>(context, listen: true).allproducts.length,
            10,
            null)
        : Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height,
          child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              childAspectRatio: (MediaQuery.of(context).size.width) /
                  (MediaQuery.of(context).size.height + 30),
              mainAxisSpacing: 5,
              primary: true,
              shrinkWrap: true,
              semanticChildCount: 2,
              children: List.generate(
                  Provider.of<CartData>(context, listen: false)
                      .men
                      .length, (index) {
                return AllProductsFragmentProductItemView(
                    buttonSize: buttonSize,
                    list:
                    Provider.of<CartData>(context, listen: false)
                        .men,
                    OnTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductView(
                                product: Provider.of<CartData>(context,
                                    listen: false)
                                    .men[index],
                                fragNav: Test.fragNavigate,
                              )));
                    },
                    Index: index);
              }))),
        );
  }

  void _onRefresh() async {
    UsersModel usersModel = UsersModel();
    var Data = await usersModel.getAll();
    if (Data.toString() != "Server Error" ||
        Data.toString() != "Products not found") {
      List<Products> data = Data;
      if (data != null) {
        if (mounted) {
          setState(() {
                    new Future.delayed(Duration.zero, () {
                      Provider.of<CartData>(context, listen: false).setAllProduct(data);
                      Test.addData(data, context);
                    });
                    Test.bihu = data;
                    showError = false;
                    _refreshController.refreshCompleted();
                  });
        } else {
          new Future.delayed(Duration.zero, () {
            Provider.of<CartData>(context, listen: false).setAllProduct(data);
            Test.addData(data, context);
          });
          Test.bihu = data;
          showError = false;
          _refreshController.refreshCompleted();
        }
      } else {
        _refreshController.refreshFailed();
      }
    } else {
      _refreshController.refreshFailed();
    }
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  void changevalue() {
    if (mounted) {
      setState(() {
        showError = true;
      });
    }
  }

  getCountAccordingToSize() {
    var type = getDeviceType();
    if(type == "Desktop"){
      return 4;
    }else if(type == "Tablet"){
      return 3;
    }else{
      return 2;
    }
  }

  getDeviceType() {
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
}
