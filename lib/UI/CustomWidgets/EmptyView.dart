import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  int height = 0;
  int width = 0;
  String txt;
  EmptyView({this.height, this.width,this.txt});

  @override
  Widget build(BuildContext context) {
    return height != 0 && width != 0
        ? Expanded(
      flex: 1,
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset("assets/images/error.png",height: MediaQuery.of(context).size.height/3,),
                    Text(txt==null?'Oops Not found\nPlease Swipe down to refresh':txt,softWrap: true,textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              ),
            ),
          )
        : Container(
      height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                children: [
                  Image.asset("assets/images/error.png"),
                  Text('No Data'),
                ],
              ),
            ),
          );
  }
}
