import 'package:coalexpert/Apis/user_Apis.dart';
import 'package:coalexpert/Models/Global.dart';
import 'package:coalexpert/Models/User.dart';
import 'package:coalexpert/ui/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsScreen extends StatefulWidget {
  UserM user;
  TermsScreen(this.user);

  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {

  bool trms = false;
  bool priv = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color(0xFFEEE2D8),
      padding: EdgeInsets.all(30),
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Terms & Conditions",
            textAlign: TextAlign.left,
            style: GoogleFonts.montserrat(
                color: Color(0xff000000),
                textStyle: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none)),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01)),
          Text("The Customer agrees that Coal Expert may use process and/or host customer confidential information/data such as CNIC, Bank Details. \n\nThe Customer also agrees that In case of any unusual fluctuation or any other unforcing circumstances Coal Expert has the right to cancel any pending order\n",
            textAlign: TextAlign.left,
            style: GoogleFonts.montserrat(
                color: Color(0xff000000),
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none)),
          ),
          GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text("Read full Terms & Conditions",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    color: Color(0xff007AFF),
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none)),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    trms = !trms;
                  });
                },
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Color.fromARGB(100, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(3),
                    color: trms ? Color(0xFF004953) : Colors.transparent
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01)),
              Text("I agree with the Terms & Conditions",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    color: Color(0xff000000),
                    textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none)),
              )
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.005)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    priv = !priv;
                  });
                },
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Color.fromARGB(100, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(3),
                      color: priv ? Color(0xFF004953) : Colors.transparent
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01)),
              Text("I agree with Coal Expert Privacy Policy",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    color: Color(0xff000000),
                    textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none)),
              )
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.035)),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                setUser();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  color: Color(0xFF004953),
                  borderRadius: BorderRadius.circular(8)

                ),
                child: Center(
                  child: Text("Continue",
                    style: GoogleFonts.montserrat(
                        color: Color.fromARGB(trms&&priv ? 250 : 150, 255, 255, 255),
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void setUser() async{
    widget.user.setTnC(true);
    Global.user = widget.user;


    await UserApi.setUser(widget.user).then((response) => {
      setState(() {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SplashScreen()));
      })
    });

  }
}
