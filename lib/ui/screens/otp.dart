import 'package:coalexpert/internal/constants.dart';
import 'package:coalexpert/ui/screens/splash.dart';
import 'package:coalexpert/ui/widgets/listingsview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpAuthentication extends StatefulWidget {

  final String phone;

  OtpAuthentication({required this.phone});

  @override
  _OtpAuthenticationState createState() => _OtpAuthenticationState();
}

class _OtpAuthenticationState extends State<OtpAuthentication> {
  TextEditingController otpController = TextEditingController();
  String currentText = "";
  String? verificationID;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(auth.currentUser);
    verifyPhoneNumber();

  }

  verifyPhoneNumber() async{

    print(widget.phone);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "${"+91" + widget.phone}",
      verificationCompleted: (PhoneAuthCredential credential) async
      {
        await FirebaseAuth.instance.signInWithCredential(credential).then((value){
          if(value.user != null)
          {
            print("User Logged In");
            otpController.text = credential.smsCode!;
            Navigator.push(context, MaterialPageRoute(builder: (_) => SplashScreen()));
          }
        });
      },
      verificationFailed: (FirebaseAuthException e)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message.toString()),
            duration: Duration(seconds: 3),
          ),
        );
      },
      codeSent: (String vID, int? resentToken)
      {
        setState(() {
          verificationID = vID;
        });
      },
      codeAutoRetrievalTimeout: (String vID)
      {
        setState(() {
          verificationID = vID;
        });
      },
      timeout: Duration(seconds: 60),
    );
  }

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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(3.0),
            child: ClipOval(
              child: Material(
                color: Color(0xFF004953),
                child: InkWell(
                  splashColor: Color(0xFF004953),
                  onTap: () => Navigator.of(context).pop(),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.height * 0.05,
                      child: Icon(
                        Icons.navigate_before_rounded,
                        size: MediaQuery.of(context).size.width * 0.10,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image.asset('images/otp.png')),
                      )),
                  Expanded(child: Container(color: Color(0xFF004953))),
                ],
              ),
              Align(
                alignment: Alignment(0, 0.8),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Card(
                    elevation: 12,
                    color: Colors.white,
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.02),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            'Verification Code',
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff004953),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            'Please type the verification code sent to \n+91 ' + widget.phone,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff004953),
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          PinCodeTextField(
                              appContext: context,
                              obscureText: false,
                              animationType: AnimationType.fade,
                              keyboardType: TextInputType.number,
                              pinTheme: PinTheme(
                                disabledColor: kScaffoldBackgroundColor,
                                selectedColor: kScaffoldBackgroundColor,
                                inactiveColor: kScaffoldBackgroundColor,
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(8),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                activeFillColor: Colors.white,
                              ),
                            animationDuration: const Duration(milliseconds: 300),
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            controller: otpController,
                              length: 6,
                            beforeTextPaste: (text) {
                              return true;
                            },
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                currentText = value;
                              });
                            },),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xFF004953),
                              ),
                              onPressed: () {
                                print(widget.phone);
                                print(otpController.text);
                                verifyCode();
                                print("Signed In Signed In Signed In Signed In Signed In ");
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                    size: MediaQuery.of(context).size.height *
                                        0.04,
                                  )
                                ],
                              )),
                        ],
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID!, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) => {
      print("Logged In Successfully"),
      Navigator.push(context, MaterialPageRoute(builder: (_) => SplashScreen()))
    });
  }
}
