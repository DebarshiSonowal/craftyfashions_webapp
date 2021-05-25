import 'package:cached_network_image/cached_network_image.dart';
import 'package:craftyfashions_webapp/Models/CartProduct.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  CartItem({this.index, this.list, this.callback, this.th});

  Function callback;
  int index;
  var list;
  bool th = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.all(10),
      color: Colors.white,
      elevation: 1,
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          radius: MediaQuery.of(context).size.width,
          splashColor: Colors.black54,
          onTap: () {},
          child: Column(
            children: [
              Expanded(
                flex:24,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CachedNetworkImage(
                            imageUrl: th
                                ? list.picture.toString().split(",")[index]
                                : list[index].picture,
                            height: 100,
                            width: 100,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Padding(
                              padding: EdgeInsets.only(
                                  top: 25.0, bottom: 25.0, left: 20, right: 20),
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "${th ? "" : list[index].name}",
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Price:',
                                      style: TextStyle(
                                          fontFamily: "Halyard",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      'Size:',
                                      style: TextStyle(
                                          fontFamily: "Halyard",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      'Color:',
                                      style: TextStyle(
                                          fontFamily: "Halyard",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "₹ ${th ? list.price : list[index].payment}",
                                      style: TextStyle(
                                          fontFamily: "Halyard",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "${th ? list.size : list[index].size}",
                                      style: TextStyle(
                                          fontFamily: "Halyard",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "${th ? list.color : list[index].color}",
                                      style: TextStyle(
                                          fontFamily: "Halyard",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: th
                            ? Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Color(0xffF5F4F6),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "x${th ? list.quantity : list[index].quantity}",
                                    style: TextStyle(
                                        fontFamily: "Halyard",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  TextButton(
                                      onPressed: callback,
                                      child: Text(
                                        'remove',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                        ),
                                      )),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Color(0xffF5F4F6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "x${list[index].quantity}",
                                        style: TextStyle(
                                            fontFamily: "Halyard",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex:1,
                child: Container(
                  child: SizedBox(
                    height: .01,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex:5,
                child: ElevatedButton(
                    onPressed:callback,
                    style:ButtonStyle(
                      enableFeedback: true,
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shadowColor: MaterialStateProperty.all(Color(0xffE3E3E3)),
                      elevation: MaterialStateProperty.all(2),
                      overlayColor: MaterialStateProperty.resolveWith(
                            (states) {
                          return states.contains(MaterialState.pressed)
                              ? Color(0xffE3E3E3)
                              : null;
                        },
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width-60,
                      child: Center(
                        child: Text(
                          'Remove',
                          style: TextStyle(
                              fontFamily: "Halyard",
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: Colors.red),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
