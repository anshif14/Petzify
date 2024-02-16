import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_demo/core/features/splash/screens/splashScreen.dart';

import 'firebase_options.dart';


var height;
var width;
Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());

}



class MyApp extends StatelessWidget {


  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData.from(
        colorScheme: ColorScheme.light(),
        // backgroundColor: Colors.white,

        textTheme: GoogleFonts.poppinsTextTheme()
      ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
    },
    ),
    ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(


      ),
    );
  }
}