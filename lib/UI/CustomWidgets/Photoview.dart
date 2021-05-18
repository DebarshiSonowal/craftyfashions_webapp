import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';

class Photoview extends StatelessWidget {
  String url;

  Photoview(this.url);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: Colors.white,
            child: Column(
              children: [
                IconButton(icon: Icon(
                    FontAwesomeIcons.backspace
                ), onPressed: (){
                  Navigator.pop(context);
                }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PhotoView(
                    imageProvider:url == null?AssetImage("assets/images/404.png",): NetworkImage(url),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
