// Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// ListView.builder(
// itemCount: 5,
// shrinkWrap: true,
// itemBuilder: (context, index) {
// return Card(
// elevation: 1.5,
// child: Container(
// decoration: BoxDecoration(
// boxShadow: [
// new BoxShadow(
// color: Color(0xffE3E3E3),
// blurRadius: 5.0,
// ),
// ],
// ),
// child: Material(
// color: Colors.white,
// child: InkWell(
// radius: MediaQuery.of(context).size.width + 10,
// splashColor: Colors.black,
// enableFeedback: true,
// onTap: () => widget.onTap(index),
// child: Container(
// height: 85,
// width: MediaQuery.of(context).size.width - 10,
// padding: EdgeInsets.all(10),
// child: Center(
// child: Row(
// children: [
// Expanded(
// flex: 3,
// child: Padding(
// padding:
// EdgeInsets.only(bottom: 32),
// child:
// Icon(widget.paymentIcon[index]),
// )),
// Expanded(
// flex: 15,
// child: Container(
// padding: EdgeInsets.only(left: 10),
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Text(
// "${widget.paymentMethod[index]}",
// style: TextStyle(
// fontFamily: "Halyard",
// fontSize: 20,
// fontWeight: FontWeight.w500,
// color: Colors.black),
// ),
// Text(
// "${widget.paymentsub[index]}",
// style: TextStyle(
// fontFamily: "Halyard",
// fontSize: 16,
// fontWeight: FontWeight.w400,
// color: Colors.black45),
// ),
// ],
// ),
// ),
// ),
// Expanded(
// flex: 1,
// child: Icon(FontAwesome.angle_right))
// ],
// ),
// )),
// ),
// ),
// ),
// );
// }),
// Card(
// elevation: 1.5,
// child: Container(
// width: MediaQuery.of(context).size.width,
// padding: EdgeInsets.all(2),
// decoration: BoxDecoration(
// color: Colors.white,
// boxShadow: [
// new BoxShadow(
// color: Color(0xffE3E3E3),
// blurRadius: 5.0,
// ),
// ],
// ),
// child: Center(
// child: Padding(
// padding: EdgeInsets.only(left: 10,top: 5,bottom: 5),
// child: Text(
// "Go for contactless payment for your safety.Cash may not be accepted in COVID restricted areas.",
// style: TextStyle(
// fontFamily: "Halyard",
// fontSize: 16,
// fontWeight: FontWeight.w200,
// color: Colors.red),
// ),
// ),
// ),
// ),
// ),
// Card(
// elevation: 1.5,
// child: Container(
// height: 160,
// padding: EdgeInsets.all(5),
// decoration: BoxDecoration(
// color: Colors.white,
// boxShadow: [
// new BoxShadow(
// color: Color(0xffE3E3E3),
// blurRadius: 5.0,
// ),
// ],
// ),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Expanded(
// flex: 1,
// child: Container(
// padding: EdgeInsets.only(left: 10),
// child: Row(
// children: [
// Text(
// "(${Provider.of<CartData>(context).listLength}) Items",
// style: TextStyle(
// fontFamily: "Halyard",
// fontSize: 16,
// fontWeight: FontWeight.w200,
// color: Colors.black),
// )
// ],
// ),
// ),
// ),
// Expanded(
// flex: 4,
// child: Container(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// padding: EdgeInsets.only(left: 10, right: 35),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Column(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Text(
// "Total MRP",
// textAlign: TextAlign.start,
// style: TextStyle(
// fontFamily: "Halyard",
// fontSize: 14,
// fontWeight: FontWeight.w200,
// color: Colors.black),
// ),
// Text(
// "Delivery Charge",
// textAlign: TextAlign.start,
// style: TextStyle(
// fontFamily: "Halyard",
// fontSize: 14,
// fontWeight: FontWeight.w200,
// color: Colors.black),
// ),
// Text(
// "Discount on MRP",
// textAlign: TextAlign.start,
// style: TextStyle(
// fontFamily: "Halyard",
// fontSize: 14,
// fontWeight: FontWeight.w200,
// color: Styles.price_color),
// ),
// ],
// ),
// Column(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// crossAxisAlignment:
// CrossAxisAlignment.end,
// children: [
// Text(
// "₹${Provider.of<CartData>(context).noOfTotalItems * 699}",
// textAlign: TextAlign.end,
// style: TextStyle(
// fontFamily: "Halyard",
// fontSize: 14,
// fontWeight: FontWeight.w600,
// color: Colors.black),
// ),
// Text(
// "Free",
// textAlign: TextAlign.end,
// style: TextStyle(
// fontFamily: "Halyard",
// fontSize: 14,
// fontWeight: FontWeight.w600,
// color: Colors.black),
// ),
// Text(
// "${getDiscount(context).toInt()}%",
// textAlign: TextAlign.end,
// style: TextStyle(
// fontFamily: "Halyard",
// fontSize: 14,
// fontWeight: FontWeight.w600,
// color: Styles.price_color),
// ),
// ],
// ),
// ],
// ),
// ),
// Container(
// padding: const EdgeInsets.only(
// left: 8.0, right: 8.0, top: 1, bottom: 1),
// child: SizedBox(
// height: 1,
// width: MediaQuery.of(context).size.width,
// child: Container(
// color: Colors.grey,
// ),
// ),
// ),
// Container(
// padding: EdgeInsets.only(left: 10, right: 35),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Column(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// crossAxisAlignment:
// CrossAxisAlignment.end,
// children: [
// Text(
// "Total amount",
// style: TextStyle(
// fontFamily: "Halyard",
// fontSize: 14,
// fontWeight: FontWeight.w700,
// color: Colors.black),
// ),
// ],
// ),
// Column(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// crossAxisAlignment:
// CrossAxisAlignment.end,
// children: [
// Text(
// "₹${Provider.of<CartData>(context).getPrice()}",
// style: TextStyle(
// fontFamily: "Halyard",
// fontSize: 16,
// fontWeight: FontWeight.w700,
// color: Colors.black),
// ),
// ],
// )
// ],
// ),
// ),
// Text(
// "Yay ! You saved ₹${((Provider.of<CartData>(context).noOfTotalItems * 699) - (Provider.of<CartData>(context).getPrice()).toInt())}",
// style: TextStyle(
// fontFamily: "Halyard",
// fontSize: 16,
// fontWeight: FontWeight.w700,
// color: Styles.price_color),
// ),
// ],
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// ],
// ),