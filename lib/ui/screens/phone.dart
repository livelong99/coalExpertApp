import 'package:coalexpert/ui/screens/otp.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final phoneController = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    phoneController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    print('Second text field: ${phoneController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Container(
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
                              child: Image.asset('images/phone.png')),
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
                            CountryCodePicker(
                              onChanged: print,
                              initialSelection: '+91',
                              favorite: ['+91', 'IN'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Enter your phone number',
                              ),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.number,
                              autofocus: true,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                'We will send you a one time sms message carrier rates may apply.',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.015),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF004953),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => OtpAuthentication(
                                        phone: phoneController.text
                                      )));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Next',
                                      style: TextStyle(
                                          color: Colors.white,
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
      ),
    );
  }
}
