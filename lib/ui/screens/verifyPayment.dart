import 'dart:convert';

import 'package:coalexpert/Models/Global.dart';
import 'package:coalexpert/Models/OrderM.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import 'mainScreen.dart';

class VerifyPayment extends StatefulWidget {
  VerifyPayment(this.order);
  Order order;

  @override
  _VerifyPaymentState createState() => _VerifyPaymentState();
}

class _VerifyPaymentState extends State<VerifyPayment> {

  final UTR = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Color.fromARGB(0, 0, 0, 0)),
          child: Center(
            child: GestureDetector(
              onTap: () {
                print("No Use");
              },
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Account Name",
                        style: GoogleFonts.montserrat(
                            color: Color(0xff000000),
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none)),
                      ),
                      Text(
                        "Turupati Enterprises",
                        style: GoogleFonts.montserrat(
                            color: Color(0xff000000),
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none)),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                              MediaQuery.of(context).size.height *
                                  0.015)),
                      Text(
                        "Account Number",
                        style: GoogleFonts.montserrat(
                            color: Color(0xff000000),
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none)),
                      ),
                      Text(
                        "30224317262",
                        style: GoogleFonts.montserrat(
                            color: Color(0xff000000),
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none)),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                              MediaQuery.of(context).size.height *
                                  0.015)),
                      Text(
                        "IFSC Code",
                        style: GoogleFonts.montserrat(
                            color: Color(0xff000000),
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none)),
                      ),
                      Text(
                        "SBIN0018578",
                        style: GoogleFonts.montserrat(
                            color: Color(0xff000000),
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none)),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                              MediaQuery.of(context).size.height *
                                  0.015)),
                      Text(
                        "Branch Name",
                        style: GoogleFonts.montserrat(
                            color: Color(0xff000000),
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none)),
                      ),
                      Text(
                        "GT ROAD MUGHALSARAI",
                        style: GoogleFonts.montserrat(
                            color: Color(0xff000000),
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none)),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                              MediaQuery.of(context).size.height *
                                  0.015)),
                      Text(
                        "GSTIN",
                        style: GoogleFonts.montserrat(
                            color: Color(0xff000000),
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none)),
                      ),
                      Text(
                        "09AFDPS8641F1Z5",
                        style: GoogleFonts.montserrat(
                            color: Color(0xff000000),
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none)),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                              MediaQuery.of(context).size.height *
                                  0.015)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: TextFormField(
                          controller: UTR,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            focusColor: Color(0xFF004953),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFF004953))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10))),
                            hintText: 'UTR Number',
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                              MediaQuery.of(context).size.height *
                                  0.015)),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (UTR.text.length == 10) {
                              verifyPayment(UTR.text);
                            } else {
                              print("Invalid ID");
                            }
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height:
                          MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Color(0xff004953),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Verify Payment",
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
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                              MediaQuery.of(context).size.height *
                                  0.015)),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            print("Payment not Done");
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height:
                          MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Color(0xff004953),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Verify Later",
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
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future verifyPayment(paymentId) async {
    return http
        .post(
        Uri.parse("https://coal-expert-back.herokuapp.com/verify-payment"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "order": widget.order.toJson(),
          "transactionId": paymentId
        }))
        .then((value) => {
          print(value.body),
          UTR.clear(),
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen(1))),
        });
  }
}
