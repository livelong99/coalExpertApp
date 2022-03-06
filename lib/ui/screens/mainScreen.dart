import 'dart:convert';
import 'package:coalexpert/Apis/get_ship.dart';
import 'package:coalexpert/Apis/order_Apis.dart';
import 'package:coalexpert/Models/Global.dart';
import 'package:coalexpert/Models/OrderM.dart';
import 'package:coalexpert/Models/Ship.dart';
import 'package:coalexpert/internal/constants.dart';
import 'package:coalexpert/ui/screens/Static/about.dart';
import 'package:coalexpert/ui/screens/splash.dart';
import 'package:coalexpert/ui/screens/user.dart';
import 'package:coalexpert/ui/screens/verifyPayment.dart';
import 'package:coalexpert/ui/widgets/listingV.dart';
import 'package:coalexpert/ui/widgets/listingsview.dart';
import 'package:coalexpert/ui/widgets/myorderview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stack/stack.dart' as St;
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  MainScreen(this.pageCode);

  int pageCode;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  int index = -1;

  List<Ship> shipList = <Ship>[];
  List<Order> orders = <Order>[];
  late var pages;

  St.Stack<int> pageStack = St.Stack();

  void openVerify(order) => {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => VerifyPayment(order)))
      };

  void getShipData() async {
    await GetShip.getShips().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        shipList = list.map((model) => Ship.fromJson(model['value'])).toList();
        pages[0] = new Listing(shipList);
        index = 0;
      });
    });
  }

  void getOrderData() async {
    await GetOrders.getOrders(Global.user.id).then((response) {
      setState(() {
        print(response.body);
        Iterable list = json.decode(response.body);
        orders = list.map((model) => Order.fromJson(model)).toList();
        index = 1;
        pages[1] = new Orders(orders, openVerify);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      pageIndex = widget.pageCode;
      if(widget.pageCode == 0){
        getShipData();
      }
      else if(widget.pageCode == 1){
        getOrderData();
      }
      else{
        index = 2;
      }
    });
    pages = [
      new Listing(shipList),
      new Orders(orders, openVerify),
      const Settings()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        decoration: BoxDecoration(color: kScaffoldBackgroundColor),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          body: Column(
            children: [
              appBar(context),
              index == -1 ? Loader() : pages[index]
            ],
          ),
          bottomNavigationBar: bottNavBar(context),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {

    if(pageStack.isEmpty){
      return Future.value(true);
    }
    else{
      setState(() {
        int a = pageStack.pop();
        pageIndex = a;
        if(a == 0){
          index = -1;
          getShipData();
        }
        else if(a == 1){
          index = -1;
          getOrderData();
        }
        else{
          index = 2;
        }
      });

      return Future.value(false);

    }


  }

  Container bottNavBar(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: double.infinity,
        color: Color(0xffFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                  child: Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width * 0.8,
                    color: Color(0xffCCCCCC),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: Center(
                  child: AnimatedContainer(
                    height: 7,
                    margin: pageIndex == 1
                        ? EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.5)
                        : pageIndex == 2
                            ? EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.5)
                            : EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffBA8C63),
                    ),
                    duration: Duration(milliseconds: 250),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                  child: AnimatedContainer(
                    height: pageIndex == 0
                        ? MediaQuery.of(context).size.height * 0.08
                        : MediaQuery.of(context).size.height * 0.07,
                    width: pageIndex == 0
                        ? MediaQuery.of(context).size.height * 0.08
                        : MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: pageIndex == 0
                            ? [Color(0xffBA8C63), Color(0xffCFAF92)]
                            : [Color(0xff000000), Color(0xff000000)],
                      ),
                    ),
                    duration: Duration(milliseconds: 250),
                    child: Center(
                        child: IconButton(
                      icon: SvgPicture.asset(
                        "images/home.svg",
                        height: pageIndex == 0 ? 23 : 20,
                      ),
                      onPressed: () {
                        setState(() {
                          if (pageIndex != 0) {
                            pageStack.push(pageIndex);
                            index = -1;
                            pageIndex = 0;
                            getShipData();
                          }
                        });
                      },
                    )),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06),
                child: Center(
                    child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.08),
                        width: MediaQuery.of(context).size.height * 0.07,
                        height: 50,
                        decoration: BoxDecoration(),
                        child: Center(
                            child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (pageIndex != 1) {
                                pageStack.push(pageIndex);
                                pageIndex = 1;
                                index = -1;
                                getOrderData();
                              }
                            });
                          },
                          icon: SvgPicture.asset(
                            pageIndex == 1
                                ? "images/orderSel.svg"
                                : "images/orders.svg",
                            height: 27,
                          ),
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.08),
                        width: MediaQuery.of(context).size.height * 0.07,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: IconButton(
                          icon: SvgPicture.asset(
                            pageIndex == 2
                                ? "images/settingsSel.svg"
                                : "images/settings.svg",
                            height: 27,
                          ),
                          onPressed: () {
                            setState(() {
                              pageStack.push(pageIndex);
                              pageIndex = 2;
                              index = 2;
                            });
                          },
                        )),
                      )
                    ],
                  ),
                )),
              ),
            ],
          ),
        ));
  }

  Container appBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height * 0.085,
                        child: Image(image: AssetImage('images/DummyLogo.png')),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => UserScreen()));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.height * 0.08,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color(0xffBA8C63), width: 2)),
                          child: Center(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              width: MediaQuery.of(context).size.height * 0.065,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          AssetImage("images/profilePic.png"))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))),
          Container(
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: 3,
                  color: Color(0xff707070),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.16)),
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: 3,
                  color: Color(0xff707070),
                ),
              ],
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                launch('tel:18008890309');
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.4,
                margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.01),
                decoration: BoxDecoration(
                    color: Color(0xffBEC3BD),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 5,
                        margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.025),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff707070)
                        ),
                      ),
                      Text(
                        "1800-8890-309",
                        style: GoogleFonts.montserrat(
                            textStyle:
                                TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        height: 5,
                        width: 5,
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.025),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff707070)
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Color(0xffFFFFFF),
      ),
      child: Center(
        child: SpinKitChasingDots(
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                  color: index.isEven ? Color(0xff004953) : Color(0xff004953),
                  shape: BoxShape.circle),
            );
          },
          size: MediaQuery.of(context).size.width * 0.3,
        ),
      ),
    );
  }
}

class Listing extends StatelessWidget {
  Listing(this.shipList);

  List<Ship> shipList = <Ship>[];

  void filterList() {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Color(0xffFFFFFF),
      ),
      child: Center(
        child: ListV(shipList),
      ),
    );
  }
}

class Orders extends StatelessWidget {
  var openVerify;

  Orders(this.orders, this.openVerify);

  List<Order> orders = <Order>[];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Color(0xffFFFFFF),
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.03),
              child: Text("Orders",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w500))),
            ),
            Container(
              height: 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xffB8B8B8),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
            ),
            OrderView(orders, openVerify),
          ],
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Color(0xffFFFFFF),
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.03),
              child: Text("Settings",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w500))),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
              },
              child: Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.02,
                    top: MediaQuery.of(context).size.height * 0.01),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff7B9FA4),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'images/account.svg',
                            height: 30,
                          ),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text('About Us',
                              style: GoogleFonts.montserrat(
                                  color: Color(0xffffffff),
                                  textStyle: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.w500)))
                        ],
                      ),
                      SvgPicture.asset(
                        'images/arrowRight.svg',
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _launchURL("https://docs.google.com/document/d/1G1CMhnlKxecrA6pU348d_AS7RfPwvGXYx2vAzB4nKDM/export?format=pdf");
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff7B9FA4),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'images/doc.svg',
                            height: 30,
                          ),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text('Terms & Conditions',
                              style: GoogleFonts.montserrat(
                                  color: Color(0xffffffff),
                                  textStyle: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.w500)))
                        ],
                      ),
                      SvgPicture.asset(
                        'images/arrowRight.svg',
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _launchURL("https://www.privacypolicies.com/live/c9bb6b9e-7bc0-4dba-8a05-29f9674840f8");
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff7B9FA4),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'images/shield.svg',
                            height: 30,
                          ),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text('Privacy Policy',
                              style: GoogleFonts.montserrat(
                                  color: Color(0xffffffff),
                                  textStyle: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.w500)))
                        ],
                      ),
                      SvgPicture.asset(
                        'images/arrowRight.svg',
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _launchURL("https://support.google.com/");
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff7B9FA4),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'images/support.svg',
                            height: 30,
                          ),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text('Support',
                              style: GoogleFonts.montserrat(
                                  color: Color(0xffffffff),
                                  textStyle: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.w500)))
                        ],
                      ),
                      SvgPicture.asset(
                        'images/arrowRight.svg',
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) => SplashScreen()), (route) => false);
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xffE9817B),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'images/account.svg',
                            height: 30,
                          ),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text('Log Out',
                              style: GoogleFonts.montserrat(
                                  color: Color(0xffffffff),
                                  textStyle: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.w500)))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
