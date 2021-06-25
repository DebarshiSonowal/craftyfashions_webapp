import 'package:clipboard/clipboard.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sizer/sizer.dart';
import 'CartData.dart';
import 'Test.dart';

class NavDrawer extends StatelessWidget {
  final FragNavigate _fragNavigate;
  final TextStyle style = TextStyle(
    color: Colors.black,fontWeight: FontWeight.w400,fontFamily: 'Halyard',fontSize: 14
  );
  NavDrawer(this._fragNavigate);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          GestureDetector(
            onTap: () => onTap(context),
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xffFAFAFA),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.1), BlendMode.dstATop),
                  image: AssetImage('assets/images/doodleWall.jpg'),
                ),
              ),
              accountName: Provider.of<CartData>(context).user == null
                  ? Text('')
                  : Text("${Provider.of<CartData>(context).user.name}",style: TextStyle(fontSize: 20,fontFamily: 'Halyard',color:Styles.price_color,fontWeight: FontWeight.w400)),
              accountEmail: Provider.of<CartData>(context).user == null
                  ? Text(
                      "User",
                      style: TextStyle(fontSize: 24,fontFamily: 'Halyard',color:Styles.price_color,fontWeight: FontWeight.w400),
                    )
                  : Text("${Provider.of<CartData>(context).user.email}"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  "${Provider.of<CartData>(context).user == null ? "Sign Up" : Provider.of<CartData>(context).user.name.toString()[0].toUpperCase()}",
                  style: TextStyle(fontSize: 20.0,fontFamily: 'Halyard',color: Styles.price_color),
                ),
              ),
            ),
          ),
          Provider.of<CartData>(context, listen: true).user == null
              ? ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Login',style: style,),
                  onTap: () {
                    _fragNavigate.putPosit(key: 'Login', force: true);
                  },
                )
              : Container(),
          Container(
            height: 34,
            padding:EdgeInsets.only(left: 15,top: 5),
            color: Color(0xfff8f3e9),
            child: Text(
              "Navigate",
              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home',style: style,),
            onTap: () {
              print(_fragNavigate.currentKey);
              try {
                _fragNavigate.putPosit(key: 'Home', force: true);
              } catch (e) {
                _fragNavigate.jumpBackTo('Home');
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile',style: style,),
            onTap: () {
              _fragNavigate.putPosit(key: 'Profile', force: true);
            },
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text('Cart',style: style,),
            onTap: () {
              _fragNavigate.putPosit(key: 'Cart', force: true);
            },
          ),
          Container(
            height: 34,
            padding:EdgeInsets.only(left: 15,top: 5),
            color: Color(0xfff8f3e9),
            child: Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.boxOpen),
            title: Text('All Products',style: style,),
            onTap: () {
              _fragNavigate.putPosit(key: 'All', force: true);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.mars),
            title: Text('Men',style: style,),
            onTap: () {
              _fragNavigate.putPosit(key: 'Men', force: true);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.venus),
            title: Text('Women',style: style,),
            onTap: () {
              _fragNavigate.putPosit(key: 'Women', force: true);
            },
          ),
          Container(
            height: 34,
            padding:EdgeInsets.only(left: 15,top: 5),
            color: Color(0xfff8f3e9),
            child: Text(
              "Options",
              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),
            ),
          ),
          // ListTile(
          //   leading: Icon(FontAwesomeIcons.list),
          //   title: Text('Wishlist',style: style,),
          //   onTap: () {
          //     _fragNavigate.putPosit(key: 'WishList');
          //   },
          // ),
          ListTile(
            leading: Icon(FontAwesomeIcons.box),
            title: Text('Orders',style: style,),
            onTap: () {
              _fragNavigate.putPosit(key: 'Orders');
            },
          ),
          Container(
            height: 34,
            padding:EdgeInsets.only(left: 15,top: 5),
            color: Color(0xfff8f3e9),
            child: Text(
              "Contact",
              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.googlePlay),
            title: Text('Download Our App',style: style,),
            onTap: () {
              try {
                _launchURL(
                    "https://play.app.goo.gl/?link=https://play.google.com/store/apps/details?id=com.craftyfashion.crafty");
              } catch (e) {
                print(e);
              }
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.share),
            title: Text('Share this website',style: style,),
            onTap: () {
              FlutterClipboard.copy('https://www.craftyfashions.com').then(( value ) => {
                Styles.showWarningToast(Colors.green, "Coiped URL", Colors.white, 12.sp)
              });
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.headphones),
            title: Text('Contact Us',style: style,),
            onTap: () {
              _fragNavigate.putPosit(key: 'Contact Us', force: true);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.info),
            title: Text('About',style: style,),
            onTap: () {
              _fragNavigate.putPosit(key: 'About', force: true);
            },
          ),
          Provider.of<CartData>(context, listen: true).user == null
              ? Container()
              : ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () {
                    clearTokens(context);
                  },
                ),
        ],
      ),
    );
  }

  clearTokens(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Test.accessToken = null;
    Test.refreshToken = null;
    Provider.of<CartData>(context, listen: false).removeOrders(
        Provider.of<CartData>(context, listen: false).order.length);
    Provider.of<CartData>(context, listen: false).user = null;
    Provider.of<CartData>(context, listen: false).removeProfile();
    Provider.of<CartData>(context, listen: false).removeAll(0, Provider.of<CartData>(context, listen: false).list.length);
    _fragNavigate.putAndClean(key: 'Login', force: true);
  }

  onTap(BuildContext context) {
    if (Provider.of<CartData>(context, listen: false).user == null) {
      _fragNavigate.putAndClean(key: 'Signup', force: true);
    }
  }
  void _launchURL(String txt) async {
    var url = Uri.encodeFull(txt);
    // var url = Uri.encodeComponent(urls);
    try {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false, forceWebView: false);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    }
  }
}
