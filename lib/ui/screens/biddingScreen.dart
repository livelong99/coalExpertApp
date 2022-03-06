import 'package:coalexpert/Models/Ship.dart';
import 'package:coalexpert/ui/screens/mainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class BiddingScreen extends StatefulWidget {
  final Ship ship;

  BiddingScreen({required this.ship});

  @override
  _BiddingScreenState createState() => _BiddingScreenState();
}

class _BiddingScreenState extends State<BiddingScreen> {
  double quan = 0;
  bool load = false;
  double amount = 0;
  late String orderId;
  late FocusNode UtrFocus;
  late FocusNode amtFocus;

  final UTR = TextEditingController();
  final quanT = TextEditingController();

  int payment = 0;
  int note = 0;

  late Razorpay _razorpay;

  FirebaseAuth auth = FirebaseAuth.instance;

  final oCcy = new NumberFormat("##,##,###.##", "en_US");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UtrFocus = FocusNode();
    amtFocus = FocusNode();
    amtFocus.requestFocus();
    quanT.addListener(() { setState(() {
      quan = double.parse(quanT.text);
      if(quan > 200){
        quan = 200;
        quanT.text = quan.toString();
        FocusScope.of(context).unfocus();
        payment = 3;
      }
      amount = quan*widget.ship.rate;
    }); });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    UtrFocus.dispose();
    amtFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xffEEE2D8),
          child: load ? Loader() : Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.height * 0.06,
                            height: MediaQuery.of(context).size.height * 0.06,
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.05,
                                left: MediaQuery.of(context).size.height * 0.02),
                            decoration: BoxDecoration(
                              color: Color(0xff004953),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                                child: SvgPicture.asset('images/arrowLeft.svg')),
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        widget.ship.name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            color: Color(0xff000000),
                            textStyle: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffDBD7D4),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Id: " + widget.ship.id,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            color: Color(0xff000000),
                            textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.025,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.035),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/account.svg',
                            height: MediaQuery.of(context).size.height * 0.025,
                            color: Color(0xff000000),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text(
                            "✰✰✰✰✰",
                            style: GoogleFonts.montserrat(
                                color: Color(0xff000000),
                                textStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.none)),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                          SvgPicture.asset(
                            'images/home2.svg',
                            height: MediaQuery.of(context).size.height * 0.025,
                            color: Color(0xff000000),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text(
                            widget.ship.origin,
                            style: GoogleFonts.montserrat(
                                color: Color(0xff000000),
                                textStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.none)),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                          SvgPicture.asset(
                            'images/box.svg',
                            height: MediaQuery.of(context).size.height * 0.025,
                            color: Color(0xff000000),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text(
                            widget.ship.quantity.toString() + " MT",
                            style: GoogleFonts.montserrat(
                                color: Color(0xff000000),
                                textStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.none)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03),
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffC7D5D7),
                      ),
                      child: Center(
                        child: Text(
                          "Test Report",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff004953),
                                  decoration: TextDecoration.none)),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03),
                      child:
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.18)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.height * 0.08,
                          padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.05),
                          decoration: BoxDecoration(
                              color: Color(0xff5F8587),
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.08)),
                          child: Center(
                            child: TextField(
                              controller: quanT,
                              focusNode: amtFocus,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffffffff)
                                  )),
                              decoration: new InputDecoration.collapsed(hintText: ""),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.03)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: BoxDecoration(
                              color: Color(0xffBFC3BD),
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.025)),
                          child: Center(
                            child: Text(
                              "MT",
                              style: GoogleFonts.montserrat(
                                  color: Color(0xff000000),
                                  textStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none)),
                            ),
                          ),
                        )
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03),
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01),
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xffDBD7D4),
                      child: Text(
                        "₹" + oCcy.format(amount),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            color: Color(0xff000000),
                            textStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // openCheckout();
                        setState(() {
                          payment = 1;
                          note = 2;
                          amtFocus.unfocus();
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.65,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03),
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.03),
                        decoration: BoxDecoration(
                            color: Color(0xff004953),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Proceed to CheckOut",
                              style: GoogleFonts.montserrat(
                                  color: Color(0xffffffff),
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none)),
                            ),
                            SvgPicture.asset("images/proceedArrow.svg")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height-MediaQuery.of(context).size.width*0.55,
                child: Image.asset(
                  'images/bidding.png',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Visibility(
                visible: payment!=0 ? true : false,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      payment = 0;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(150, 0, 0, 0)
                    ),
                    child: Center(
                      child: GestureDetector(
                          onTap: () {
                            print("No Use");
                          },
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: payment == 1 ? MediaQuery.of(context).size.width * 0.8 : MediaQuery.of(context).size.width * 0.9,
                            height: payment == 1 ? note==0 ? MediaQuery.of(context).size.height * 0.3 : note==2 ? MediaQuery.of(context).size.height * 0.4 : MediaQuery.of(context).size.height * 0.6 : payment == 2 ? MediaQuery.of(context).size.height * 0.8 : MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: note==1 ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Kindly verify your payment latest by 11:59 pm today otherwise your order will be canceled \nFor more assistance Kindly contact on toll-free number",
                                  style: GoogleFonts.montserrat(
                                      color: Color(0xff000000),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none)),
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02)),
                                GestureDetector(
                                  onTap: () {
                                    launch('tel:18008890309');
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height * 0.07,
                                    decoration: BoxDecoration(
                                        color: Color(0xff004953),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text("Call Now",
                                        style: GoogleFonts.montserrat(
                                            color: Color(0xffffffff),
                                            textStyle: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                decoration: TextDecoration.none)),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02)),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      note = 0;
                                      payment = 2;
                                      UtrFocus.requestFocus();
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
                                      child: Text("Proceed",
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
                              ],
                            ) :
                                note==2 ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Our representative will call you shortly after your payment is verified for billing and delivery details",
                                      style: GoogleFonts.montserrat(
                                          color: Color(0xff000000),
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              decoration: TextDecoration.none)),
                                    ),
                                    Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02)),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          note = 0;
                                          payment = 1;
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
                                          child: Text("Okay",
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
                                  ],
                                ) :
                            payment==1 ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => {
                                    openCheckout()
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height * 0.07,
                                    decoration: BoxDecoration(
                                      color: Color(0xff004953),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text("Razorpay",
                                        style: GoogleFonts.montserrat(
                                            color: Color(0xffffffff),
                                            textStyle: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                decoration: TextDecoration.none)),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.025)),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      note = 1;
                                      payment = 1;
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
                                      child: Text("Account Transfer",
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
                              ],
                            ) :
                            payment==2 ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Account Name",
                                  style: GoogleFonts.montserrat(
                                      color: Color(0xff000000),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.none)),
                                ),
                                Text("Turupati Enterprises",
                                  style: GoogleFonts.montserrat(
                                      color: Color(0xff000000),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none)),
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015)),
                                Text("Account Number",
                                  style: GoogleFonts.montserrat(
                                      color: Color(0xff000000),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.none)),
                                ),
                                Text("30224317262",
                                  style: GoogleFonts.montserrat(
                                      color: Color(0xff000000),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none)),
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015)),
                                Text("IFSC Code",
                                  style: GoogleFonts.montserrat(
                                      color: Color(0xff000000),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.none)),
                                ),
                                Text("SBIN0018578",
                                  style: GoogleFonts.montserrat(
                                      color: Color(0xff000000),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none)),
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015)),
                                Text("Branch Name",
                                  style: GoogleFonts.montserrat(
                                      color: Color(0xff000000),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.none)),
                                ),
                                Text("GT ROAD MUGHALSARAI",
                                  style: GoogleFonts.montserrat(
                                      color: Color(0xff000000),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none)),
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015)),
                                Text("GSTIN",
                                  style: GoogleFonts.montserrat(
                                      color: Color(0xff000000),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.none)),
                                ),
                                Text("09AFDPS8641F1Z5",
                                  style: GoogleFonts.montserrat(
                                      color: Color(0xff000000),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none)),
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015)),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                  child: TextFormField(
                                    controller: UTR,
                                    focusNode: UtrFocus,
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                      focusColor: Color(0xFF004953),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFF004953))),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                      hintText: 'UTR Number',
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015)),
                                GestureDetector(
                                  onTap: ()  {
                                    setState(() {
                                      if(UTR.text.length == 10){
                                        bookOrderNonRazorPay(UTR.text);
                                      }
                                      else{
                                        print("Invalid ID");
                                      }

                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height * 0.05,
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
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015)),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      print("Payment not Done");
                                      bookOrderNonRazorPay("null");
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height * 0.05,
                                    decoration: BoxDecoration(
                                        color: Color(0xff004953),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text("Verify Later",
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
                              ],
                            ) :
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Dear Customer, \nFor Buying Coal more than 200 MT please call us on our toll free number : 1800-8890-309",
                                  style: GoogleFonts.montserrat(
                                      color: Color(0xff000000),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none)),
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02)),
                                GestureDetector(
                                  onTap: () {
                                  launch('tel:18008890309');
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height * 0.07,
                                    decoration: BoxDecoration(
                                        color: Color(0xff004953),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text("Call Now",
                                        style: GoogleFonts.montserrat(
                                            color: Color(0xffffffff),
                                            textStyle: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                decoration: TextDecoration.none)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                            ,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    if(payment==0)
      return Future.value(true);
    else{
      setState(() {
        payment = 0;
      });

      return Future.value(false);
    }

    }

  Future getOrderId() async {
    print(amount);
    return http.post(
        Uri.parse("https://coal-expert-back.herokuapp.com/get-orderId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, double>{
          'amount': amount,
        }));
  }

  void bookOrderNonRazorPay(paymentId) async {
    setState(() {
      load = true;
    });

    orderId = await getOrderId()
        .then((response) => (json.decode(response.body)['id']));

    await bookOrder(paymentId);

  }

  void openCheckout() async {
    setState(() {
      load = true;
    });

    orderId = await getOrderId()
        .then((response) => (json.decode(response.body)['id']));



    var options = {
      'key': 'rzp_test_oAHpkjlohv58LG',
      'amount': amount,
      'name': 'Coal Expert.',
      'order_id': orderId,
      'description': widget.ship.name,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '9319150688',
        'email': 'test@razorpay.com',
        'name': 'Dummy Name',
        'method': 'netbanking'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  Future bookOrder(paymentId) async {
    return http
        .post(Uri.parse("https://coal-expert-back.herokuapp.com/order-success"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'userId': auth.currentUser?.uid,
          'shipId': widget.ship.id,
          'quantity': quan,
          'amount': amount,
          'orderId': orderId,
          'transactionId': paymentId
        }))
        .then((value) => {
      print(value.body),
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => MainScreen(0)), (route) => false)
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print(" Payment Success : " + response.paymentId!);
    print("Success Started");

    await bookOrder(response.paymentId);

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(" Payment Faliure : " + response.code.toString());
    setState(() {
      load = false;
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("EXTERNAL_WALLET: " + response.walletName!);
  }
}

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Color(0xffF2F2F2),
      ),
      child: Center(
        child: SpinKitChasingDots(
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                  color: index.isEven ? Color(0xff004953) : Color(0xff004953),
                  shape: BoxShape.circle
              ),
            );
          },
          size: MediaQuery.of(context).size.width * 0.3,
        ),
      ),
    );
  }
}

