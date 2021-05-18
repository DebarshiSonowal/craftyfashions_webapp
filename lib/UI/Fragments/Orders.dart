import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/EmptyView.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:craftyfashions_webapp/Utility/Users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'OrderItem.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  UsersModel usersModel = new UsersModel();
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  var s;

  void _onRefresh() async {
    if (Test.accessToken != null && Test.refreshToken != null) {
      s = await usersModel.getOrdersforUser(
          Provider.of<CartData>(context, listen: false).user.id);

      if (s != null) {
        setState(() {
          Provider.of<CartData>(context, listen: false).orders(s);
        });
        _refreshController.refreshCompleted();
      }
    }else {
      Styles.showSnackBar(context, Styles.Log_sign, Duration(seconds: 5),
          'Please Login first', Colors.black, () {
            setState(() {
              Test.fragNavigate.putPosit(key: 'Login');
            });
          });
      _refreshController.refreshFailed();
    }
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
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
        child: Container(
          child: Provider.of<CartData>(context, listen: false).order.length==0
              ? EmptyView()
              : OrderItem(),
        ),
      ),
    );
  }
}
