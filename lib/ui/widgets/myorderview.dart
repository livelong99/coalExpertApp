import 'package:coalexpert/Models/Global.dart';
import 'package:coalexpert/Models/OrderM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderView extends StatefulWidget {
  OrderView(this.orders, this.openVerify);

  var openVerify;

  List<Order> orders = <Order>[];

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {

  final oCcy = new NumberFormat("##,##,###", "en_US");

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.599),
      child: ListView.builder(
          padding: EdgeInsets.all(0),
          scrollDirection: Axis.vertical,
          itemCount: widget.orders.length, //variable name.length kar dena bas
          itemBuilder: (context, index) => Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.05),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: MediaQuery.of(context).size.width * 0.05),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.width * 0.05,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xffFFFFFF),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 10, bottom: 15),
                                  child: Text(
                                    widget.orders[index].shipData.name,
                                    style: GoogleFonts.montserrat(
                                      textStyle: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06,
                                            color: Color(0xFFBA8C63),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: MediaQuery.of(context).size.width *
                                        0.09,
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    decoration: BoxDecoration(
                                      color: Color(0x80BA8C63),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      border: Border(),
                                    ),
                                    child: Text(
                                        "₹ " + oCcy.format(widget.orders[index].amount) + ' - ' + widget.orders[index].quantity.toString() + ' MT',
                                      style: GoogleFonts.montserrat(
                                        textStyle: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.035,
                                              color: Color(0xFF000000),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.08),
                                  child: Container(
                                    width: double.infinity,
                                    height: 2,
                                    color: Color(0xFFB2B2B3),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02),
                                              child: Text(
                                                "Origin",
                                                style: GoogleFonts.montserrat(
                                                  textStyle:
                                                      GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                        color:
                                                            Color(0xFF000000),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.04),
                                              child: Text(
                                                widget.orders[index].shipData.origin,
                                                style: GoogleFonts.montserrat(
                                                  textStyle:
                                                      GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                        color:
                                                            Color(0xFF000000),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.04,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02),
                                              child: Text(
                                                "Order date",
                                                style: GoogleFonts.montserrat(
                                                  textStyle:
                                                      GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                        color:
                                                            Color(0xFF000000),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.04),
                                              child: Text(
                                                "28-01-2022",
                                                style: GoogleFonts.montserrat(
                                                  textStyle:
                                                      GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                        color:
                                                            Color(0xFF000000),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02),
                                              child: Text(
                                                "Destination",
                                                style: GoogleFonts.montserrat(
                                                  textStyle:
                                                      GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                        color:
                                                            Color(0xFF000000),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.04),
                                              child: Text(
                                                widget.orders[index].shipData.destination,
                                                style: GoogleFonts.montserrat(
                                                  textStyle:
                                                      GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                        color:
                                                            Color(0xFF000000),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.04,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02),
                                              child: Text(
                                                "Status",
                                                style: GoogleFonts.montserrat(
                                                  textStyle:
                                                      GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                        color:
                                                            Color(0xFF000000),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.04),
                                              child: Text(
                                                widget.orders[index].status == 0 ? "Waiting" : "Complete",
                                                style: GoogleFonts.montserrat(
                                                  textStyle:
                                                      GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                        color:
                                                            Color(0xFF000000),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(10)),
                                widget.orders[index].status==-1 ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.openVerify(widget.orders[index]);
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height * 0.07,
                                    decoration: BoxDecoration(
                                        color: Color(0xff004953),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text("Verify Payment",
                                        style: GoogleFonts.montserrat(
                                            color: Color(0xffffffff),
                                            textStyle: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                decoration: TextDecoration.none)),
                                      ),
                                    ),
                                  ),
                                )
                                    : Padding(padding: EdgeInsets.all(0))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.07),
                      child: SvgPicture.asset((widget.orders[index].status == 0) ? 'images/orderWait.svg' : (widget.orders[index].status == 1) ? 'images/orderSuccess.svg' : 'images/paymentWait.svg',
                        height: MediaQuery.of(context).size.height * 0.07,),
                    )
                  ],
                ),
              )),
    );
  }
}
