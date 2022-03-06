import 'package:coalexpert/Models/Global.dart';
import 'package:coalexpert/internal/constants.dart';
import 'package:coalexpert/ui/screens/details.dart';
import 'package:coalexpert/ui/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: kScaffoldBackgroundColor),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: SvgPicture.asset('images/backBtnWhite.svg'),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CompanyDetails(true)));
                              });
                            },
                            child: SvgPicture.asset('images/editBtnLarge.svg')),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0))),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(100, 0, 0, 0),
                              offset: const Offset(
                                0.0,
                                0.0,
                              ),
                              blurRadius: 50.0,
                              spreadRadius: 2.0,
                            ),
                          ]),
                      child: Column(
                        children: [
                          Item(context, "Company Name", Global.user.Cname, false, "images/nameProfile.svg"),
                          Item(context, "Email", Global.user.Email, false, "images/mailProfile.svg"),
                          Item(context, "Phone", Global.user.contact, false, "images/phoneProfile.svg"),
                          Item(context, "GST Number", Global.user.GST, true, "images/gstProfile.svg"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.188,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.09,
              ),
              child: Center(
                child: Container(
                    width: MediaQuery.of(context).size.height * 0.188,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // border: Border.all(
                        //     color: Color(0xffBA8C63),
                        //     width: 0),
                        color: Color(0xff000000),
                        image: DecorationImage(
                            image: AssetImage("images/profilePic.png")))),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff676767),
                        offset: const Offset(
                          5.0,
                          0.0,
                        ),
                        blurRadius: 100.0,
                        spreadRadius: 2.0,
                      ),
                    ]),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SplashScreen()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Color(0xff004953), width: 2),
                      ),
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset('images/logOutG.svg'),
                              Text(
                                "Log out",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 24,
                                        color: Color(0xff004953))),
                              )
                            ],
                          ),
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
    );
  }

  Container Item (BuildContext context, String title, String value, bool last, String img) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Color(0xffB2C8CB),
                width: last ? 0 : 1.5,
              ))),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context)
                        .size
                        .width *
                        0.03)),
            SvgPicture.asset(img),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context)
                        .size
                        .width *
                        0.03)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width:
                  MediaQuery.of(context).size.width *
                      0.56,
                  child: Text(
                    title,
                    style: GoogleFonts.montserrat(
                        color: Color(0xff4C7F86),
                        textStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            decoration:
                            TextDecoration.none)),
                  ),
                ),
                Container(
                  width:
                  MediaQuery.of(context).size.width *
                      0.56,
                  child: Text(
                    value,
                    style: GoogleFonts.montserrat(
                        color: Color(0xff004953),
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration:
                            TextDecoration.none)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
