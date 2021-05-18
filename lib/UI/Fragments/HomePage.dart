import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/Ads.dart';
import 'package:craftyfashions_webapp/Models/Categories.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/Models/Razorpay.dart';
import 'package:craftyfashions_webapp/UI/IndivisualUnits/HomeWidget.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:craftyfashions_webapp/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


//Carolina Cajazeira
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  BuildContext customcontext;
  RefreshController _refreshController;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
  get buttonSize => 20.0;
  @override
  void initState() {
    Test.getAllProducts(context);
    _refreshController = RefreshController(
        initialRefresh:
        Provider.of<CartData>(context, listen: false).getCateg() == null
            ? true
            : false);
    super.initState();
    new Future.delayed(Duration.zero, () {
      customcontext = context;
    });
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
    if (Test.accessToken != null && Test.refreshToken != null) {
      UsersModel usersModel = UsersModel();
      UsersModel usersModel1 = UsersModel();
      var Data = await usersModel.getAll();
      if (Data.toString() != "Server Error" ||
          Data.toString() != "Products not found") {
        List<Products> data = Data;
        if (data != null) {
          setState(() {
            print("Here");
            new Future.delayed(Duration.zero, () {
              Provider.of<CartData>(customcontext, listen: false)
                  .setAllProduct(data);
              addData(data);
            });
            Test.bihu = data;
            _refreshController.refreshCompleted();
          });
        } else {
          print("nkn");
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

      new Future.delayed(Duration.zero, () {
        Provider.of<CartData>(customcontext, listen: false)
            .setCategory(categories);
        Provider.of<CartData>(customcontext, listen: false).setAds(ads);
        Provider.of<CartData>(customcontext, listen: false)
            .setRazorpay(Razorpay.fromJson(data3));
      });
    } else {
      UsersModel usersModel = UsersModel();
      var Data = await usersModel.getAll();
      List<Products> data = [];
      if (Data.toString() == "Server Error" ||
          Data.toString() == "Products not found") {
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
    UsersModel usersModel1 = UsersModel();
    var data = await usersModel1.getRequired();

    var data1 = data['require'] as List;
    List<Categories> categories =
    data1.map((e) => Categories.fromJson(e)).toList();

    var data2 = data['ads'] as List;
    List<Ads> ads = data2.map((e) => Ads.fromJson(e)).toList();
    var data3 = data['razorpay'];

    new Future.delayed(Duration.zero, () {
      Provider.of<CartData>(customcontext, listen: false)
          .setCategory(categories);
      Provider.of<CartData>(customcontext, listen: false).setAds(ads);
      Provider.of<CartData>(customcontext, listen: false)
          .setRazorpay(Razorpay.fromJson(data3));
      _refreshController.refreshCompleted();
    });
    Styles.showSnackBar(context, Styles.Log_sign, Duration(seconds: 5),
        'Please Login first', Colors.black, () {
          setState(() {
            Test.fragNavigate.putPosit(key: 'Login');
          });
        });
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
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
    );
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
