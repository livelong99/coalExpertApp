import 'package:coalexpert/internal/constants.dart';
import 'package:coalexpert/ui/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GestureDetector(
      onTap: (){FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CoalExpert',
          theme: ThemeData(
            scaffoldBackgroundColor: kScaffoldBackgroundColor,
            textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme,
            )
          ),
          home: SplashScreen(),
      ),
    );
  }
}
