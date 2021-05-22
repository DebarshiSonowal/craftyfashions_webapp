import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/Ads.dart';
import 'package:craftyfashions_webapp/Models/Categories.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/Models/Razorpay.dart';
import 'package:craftyfashions_webapp/UI/IndivisualUnits/HomeWidget.dart';
import 'package:craftyfashions_webapp/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

//Carolina Cajazeira
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  BuildContext customcontext;
  RefreshController _refreshController;
  get buttonSize => 20.0;

  @override
  void initState() {
    _refreshController = RefreshController(
        initialRefresh:
        Provider.of<CartData>(context, listen: false).getCateg() == null
            ? true
            : false);
    print("Is is ${Provider.of<CartData>(context, listen: false).getCateg() == null
        ? true
        : false}");
    super.initState();
    customcontext = context;
    print("Home page init");
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _onRefresh() async {
    UsersModel usersModel1 = UsersModel();
      var Data = await usersModel1.getAll();
      if (Data.toString() != "Server Error" ||
          Data.toString() != "Products not found") {
        List<Products> data = Data;
        if (data != null) {
          setState(() {
            print("Here");
            Provider.of<CartData>(customcontext, listen: false)
                .setAllProduct(data);
            addData(data);
            Test.bihu = data;
            _refreshController.refreshCompleted();
          });
        } else {
          _refreshController.refreshFailed();
        }
      } else {
        _refreshController.refreshFailed();
      }
      var data = await usersModel1.getRequired();

      var data1 = data['require'] as List;
      List<Categories> categories =
      data1.map((e) => Categories.fromJson(e)).toList();

      var data2 = data['ads'] as List;
      List<Ads> ads = data2.map((e) => Ads.fromJson(e)).toList();
      var data3 = data['razorpay'];
      Provider.of<CartData>(customcontext, listen: false)
          .setCategory(categories);
      Provider.of<CartData>(customcontext, listen: false).setAds(ads);
      Provider.of<CartData>(customcontext, listen: false)
          .setRazorpay(Razorpay.fromJson(data3));
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    print("Home page build");
    return kIsWeb?Container(
      color: Color(0xffe3e3e6),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CircularProgressIndicator();
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
        child: HomeWidget(),
      ),
    ):Container();
  }

  void addData(List<Products> data) {
    List<Products> men = [];
    List<Products> women = [];
    if (data != null) {
      for (var i in data) {
        if (i.Gender == "MALE") {
          men.add(i);
          print("MEN $i");
        } else {
          women.add(i);
          print("WOMEN $i");
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
