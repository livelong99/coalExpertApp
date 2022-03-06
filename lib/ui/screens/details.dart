import 'package:coalexpert/Apis/user_Apis.dart';
import 'package:coalexpert/Models/Global.dart';
import 'package:coalexpert/Models/User.dart';
import 'package:coalexpert/ui/screens/splash.dart';
import 'package:coalexpert/ui/screens/tnc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CompanyDetails extends StatefulWidget {
  bool backFunction;

  CompanyDetails(this.backFunction);

  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {

  FirebaseAuth auth = FirebaseAuth.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  final companyName = TextEditingController();
  final email = TextEditingController();
  final gstNum = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.backFunction) {
      companyName.text = Global.user.Cname;
      email.text = Global.user.Email;
      gstNum.text = Global.user.GST;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFEEE2D8),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                    (widget.backFunction ? 'Edit' : 'Enter') + ' Company Details:',
                  style: TextStyle(
                      color: Color(0xFF004953),
                      fontSize: MediaQuery.of(context).size.height * 0.03),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: companyName,
                  autofocus: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    focusColor: Color(0xFF004953),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF004953))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'Company Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: email,
                  autofocus: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email),
                    focusColor: Color(0xFF004953),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF004953))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  initialValue: auth.currentUser?.phoneNumber,
                  autofocus: true,
                  enabled: false,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    focusColor: Color(0xFF004953),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF004953))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'Phone',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: gstNum,
                  autofocus: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money),
                    focusColor: Color(0xFF004953),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF004953))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'GST Number (Optional)',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.1)),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                      onPressed: setUser,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFF004953))
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Save Details',
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height * 0.03),
                          ),
                          Spacer(),
                          Icon(Icons.navigate_next)
                        ],
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void setUser() async{

    if(widget.backFunction){
      UserM user = new UserM.fromParams((auth.currentUser?.uid)!, companyName.text, email.text, (auth.currentUser?.phoneNumber)!, gstNum.text, true);
      Global.user = user;

      await UserApi.setUser(user).then((response) => {
        setState(() {
          Navigator.pop(context);
        })
      });
    }
    else{
      UserM user = new UserM.fromParams((auth.currentUser?.uid)!, companyName.text, email.text, (auth.currentUser?.phoneNumber)!, gstNum.text, false);
      Global.user = user;

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TermsScreen(user)));
    }




  }
}
