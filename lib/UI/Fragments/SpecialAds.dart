import 'dart:async';

import 'package:craftyfashions_webapp/Helper/CartData.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/AllProductsFragmentProductItemview.dart';
import 'package:craftyfashions_webapp/UI/CustomWidgets/LoadingAnimation.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'ProductView.dart';

class SpecialAds extends StatefulWidget {
  @override
  _SpecialAdsState createState() => _SpecialAdsState();
}

class _SpecialAdsState extends State<SpecialAds> {
  get buttonSize => 20.0;
  Widget emptyListWidget;
  bool showError = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh(){
    Test.getAllProducts(context);
    List<Products> list = [];
    var tag = Test.specialTag;
    if (tag != null) {
      Provider.of<CartData>(context, listen: false).setSpecialTag(tag);
      var all = Provider.of<CartData>(context, listen: false).allproducts;
      for (var i in all) {
        for (var j in i.Tags.toString().split(',')) {
          if (j.trim().toUpperCase() == tag.toString().trim().toUpperCase()) {
            list.add(i);
            _refreshController.refreshCompleted();
          }
        }
      }

      if (list.isNotEmpty) {
        setState(() {
          Provider.of<CartData>(context, listen: false).setSpecial(list);
          _refreshController.refreshCompleted();
          showError = false;
        });
      } else {
        setState(() {
          Provider.of<CartData>(context, listen: false).setSpecial([]);
        });
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

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 7), () {
      try {
        Provider.of<CartData>(context, listen: false)
            .special.length==0?setTrue():null;
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    emptyListWidget = Styles.EmptyError;
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
        child: Consumer<CartData>(
          builder: (context, data, child) => Container(
              child: showError
                  ? emptyListWidget
                  : everything(context, buttonSize, data)),
        ),
      ),
    );
  }

  everything(BuildContext context, buttonSize, data) {
    var _selected;
    return data.special == null || data.special.length == 0
        ? LoadingAnimation(data.special.length, 10, null)
        : Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).size.height / 8),
          child: Column(
            children: [
              Card(
                elevation: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      new BoxShadow(
                        color: Color(0xffE3E3E3),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  height: 5.h,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                          value: _selected,
                          isExpanded: true,
                          style:
                          TextStyle(color: Colors.black, fontSize: 18),
                          items: <String>[
                            'Price Low to High',
                            'Price High to Low'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: Text(
                            "Filter",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _selected = value;
                              if (_selected == 'Price Low to High') {
                                Provider.of<CartData>(context,
                                    listen: false)
                                    .setSortedList(Provider.of<CartData>(
                                    context,
                                    listen: false)
                                    .special);
                                Provider.of<CartData>(context,
                                    listen: false)
                                    .sorted
                                    .sort((a, b) => double.parse(a.Price)
                                    .compareTo(double.parse(b.Price)));
                              } else {
                                Provider.of<CartData>(context,
                                    listen: false)
                                    .setSortedList(Provider.of<CartData>(
                                    context,
                                    listen: false)
                                    .special);
                                Provider.of<CartData>(context,
                                    listen: false)
                                    .sorted
                                    .sort((a, b) => double.parse(b.Price)
                                    .compareTo(double.parse(a.Price)));
                              }
                            });
                          }),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    childAspectRatio: (MediaQuery.of(context).size.width) /
                        (MediaQuery.of(context).size.height + 30),
                    mainAxisSpacing: 5,
                    primary: true,
                    // shrinkWrap: true,
                    semanticChildCount: 2,
                    children: List.generate(data.special.length, (index) {
                      return AllProductsFragmentProductItemView(
                          buttonSize: buttonSize,
                          list: data.special,
                          OnTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductView(
                                      product: data.special[index],
                                      fragNav: Test.fragNavigate,
                                    )));
                          },
                          Index: index);
                    })),
              ),
            ],
          )),
    );
  }

  setTrue() {
    setState(() {
      showError = true;
    });
  }
}

