import 'dart:convert';
import 'package:coalexpert/Apis/user_Apis.dart';
import 'package:coalexpert/Models/Global.dart';
import 'package:coalexpert/Models/User.dart';
import 'package:coalexpert/ui/screens/Static/about.dart';
import 'package:coalexpert/ui/screens/details.dart';
import 'package:coalexpert/ui/screens/login.dart';
import 'package:coalexpert/ui/screens/mainScreen.dart';
import 'package:coalexpert/ui/screens/tnc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  late UserM user;

  void getUserData(uid) async {
    await UserApi.getUser(uid).then((response) => {
      setState(() {
        print(response.body);
        try{
          user =  UserM.fromJson(json.decode(response.body)['data']);
          Global.user = user;
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainScreen(0)), (route) => false);
        }
        catch (ex){
          if(auth.currentUser == null){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
          }
          else{
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => CompanyDetails(false)), (route) => false);
          }
        }

      })
    });
  }

  @override
  void initState(){
    super.initState();
    // print(userId);
    Timer(Duration(seconds: 2), (){
      if(auth.currentUser == null){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
      }
      else{
        print("Logged In");
      }
    }
    );
    getUserData(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding:  new EdgeInsets.all(60.0),
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image(image: AssetImage('images/DummyLogo.png'))
                ],
              ),
            ),
          ),
        )
    );
  }
}