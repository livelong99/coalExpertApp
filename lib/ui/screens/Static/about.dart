import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color(0xFFEEE2D8),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),

      child: Stack(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.06,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: Color(0xff004953),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: SvgPicture.asset('images/arrowLeft.svg')),
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Image(image: AssetImage('images/DummyLogo.png'))

              ),
              Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02)),
              Text("About Us",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    color: Color(0xff000000),
                    textStyle: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none)),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.03)),
              Text("Coal expert was founded with the simple goal of bringing in transparency for the SMEs in the Coal trade.\n We started off as an information aggregation portal, providing sector related news, commodity prices, freights, auctions data among other things. \nThis eventually transformed us into the world’s only dedicated solid energy marketplace, where thousands of SMEs put their T.R.U.S.T. in us to help improve their bottom lines.",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    color: Color(0xff000000),
                    textStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none)),
              ),
            ],
          ),
        ]
      ),

    );
  }
}
