import 'package:coalexpert/Models/Ship.dart';
import 'package:coalexpert/ui/screens/biddingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ListingView extends StatelessWidget {
  ListingView(this.shipList);

  final oCcy = new NumberFormat("##,##,###", "en_US");
  List<Ship> shipList = <Ship>[];

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.605),
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        scrollDirection: Axis.vertical,
        itemCount: shipList.length, //variable name.length kar dena bas
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            children: <Widget>[
              Container(
                width: 350,
                padding: const EdgeInsets.all(25.0),
                margin: const EdgeInsets.symmetric(vertical: 10.0),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  <Widget>[
                        Text(shipList[index].name,
                          style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                          // TextStyle(fontSize: 25, fontWeight: FontWeight.w500, fontFamily: "Montserrat"),
                        ),
                        Text("id: " + shipList[index].id,
                        style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 30,
                          height: 15,
                          margin: const EdgeInsets.only(top: 13.0, right: 10.0),
                          child: SvgPicture.asset('images/box.svg',
                            width: 30,
                            height: 15,
                          ),
                        ),
                        Container(
                          height: 17,
                          margin: const EdgeInsets.only(top: 13.0),
                          child: Text(shipList[index].quantity.toString() + " MT",
                            style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 15,
                                      margin: const EdgeInsets.only(top: 10.0, right: 10.0),
                                      child: SvgPicture.asset('images/quality.svg'),
                                    ),
                                    Container(
                                      height: 17,
                                      margin: const EdgeInsets.only(top: 13.0),
                                      child: Text(shipList[index].quality,
                                        style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 15,
                                      margin: const EdgeInsets.only(top: 10.0, right: 10.0),
                                      child: SvgPicture.asset('images/origin.svg',),
                                    ),
                                    Container(
                                      height: 17,
                                      margin: const EdgeInsets.only(top: 13.0),
                                      child: Text(shipList[index].origin,
                                        style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 15,
                                      margin: const EdgeInsets.only(top: 10.0, right: 10.0),
                                      child: SvgPicture.asset('images/destination.svg',),
                                    ),
                                    Container(
                                      height: 17,
                                      margin: const EdgeInsets.only(top: 13.0),
                                      child: Text(shipList[index].destination,
                                        style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: const Color(0xffD3D3D3),
                              ),
                              child: Center(
                                child: Text("₹" + oCcy.format(shipList[index].rate) +"/MT",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),),
                              ),
                            ),
                          )
                        ]
                    ),
                    (shipList[index].add1.isNotEmpty || shipList[index].add2.isNotEmpty) ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 30,
                          height: 15,
                          margin: const EdgeInsets.only(top: 13.0, right: 10.0),
                          child: SvgPicture.asset('images/star.svg',
                            width: 30,
                            height: 15,
                          ),
                        ),
                        Container(
                          height: 17,
                          margin: const EdgeInsets.only(top: 13.0),
                          child: Text(shipList[index].add1 + "       " + shipList[index].add2,
                            style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),),
                        ),
                      ],
                    ) : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => BiddingScreen(
                                    ship: shipList[index]
                                )));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: const Color(0xff004953),
                            ),
                            child: Center(
                              child: Text("BUY", textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xffffffff))),),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL(shipList[index].link);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: const Color(0xffC7D5D7),
                            ),
                            child: Center(
                              child: Text("Test Report", textAlign: TextAlign.left,
                                style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xff004953))),),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
