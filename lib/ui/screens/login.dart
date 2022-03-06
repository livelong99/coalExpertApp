import 'package:coalexpert/internal/constants.dart';
import 'package:coalexpert/ui/screens/phone.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFDBD9CA), Color(0xFFFFFFFF)])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'images/logo.png',
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                          Text(
                            'Coal Expert',
                            style: GoogleFonts.montserrat(textStyle: TextStyle(
                                color: Color(0xff004953),
                                fontWeight: FontWeight.w700,
                                fontSize:
                                MediaQuery.of(context).size.width * 0.13)),
                          ),
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: Text(
                          //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //       color: Color(0xFF004953),
                          //       fontSize:
                          //           MediaQuery.of(context).size.height * 0.015,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    )),
                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF004953),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => PhoneNumber()));
                      },
                      child: Row(
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03),
                          ),
                          Spacer(),
                          Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.height * 0.04,
                          )
                        ],
                      )),
                ),
                Spacer(),
                Image.asset(
                  'images/login.png',
                ),
              ],
            ),
          ),
        ));
  }
}
