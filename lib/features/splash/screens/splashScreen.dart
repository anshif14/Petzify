import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/features/auth/screen/loginPage.dart';

import 'package:luna_demo/main.dart';
import 'package:luna_demo/model/user_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home/screen/navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool login = false;

  getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    login = _prefs.getBool("login") ?? false;
    currentUserName = _prefs.getString('name');
    currentUserEmail = _prefs.getString('email');
    firstTime = false;

    if (currentUserEmail != null) {
      var userdata = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserEmail)
          .get();

      currentUserModel = UserModel.fromMap(userdata.data()!);

      setState(() {});

      if (currentUserModel?.block == false) {
        Future.delayed(Duration(seconds: 4))
            .then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => NavBar(
                          passindex: 0,
                        ))));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                surfaceTintColor: Pallette.secondaryBrown,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.05)),
                content: Container(
                  height: height * 0.2,
                  width: width * 1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.03)),
                  child: Center(
                    child: Text(
                      "This email has been blocked",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: width * 0.05, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              );
            });
        Future.delayed(Duration(seconds: 4))
            .then((value) => Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => LoginPage(),
                )));

        ///what to perform when account is blocked
      }
    } else {
      Future.delayed(Duration(seconds: 4)).then((value) =>
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => LoginPage())));
    }
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xfff8f6f4),
        //     backgroundColor: Colors.grey,

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xfff8f6f4),
                    image: DecorationImage(
                        image: AssetImage(ImageConstants.logo1),
                        fit: BoxFit.cover)),
                height: height * 0.25,
                width: width * 0.67,
              ),
            ),
            Column(
              children: [
                DefaultTextStyle(
                  style: GoogleFonts.cormorantGaramond(
                      fontWeight: FontWeight.w600,
                      fontSize: width * 0.11,
                      color: Pallette.primaryColor),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('PETZIFY'),
                    ],
                    isRepeatingAnimation: true,
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),

                //           AnimatedTextKit(
                // animatedTexts: [
                // WavyAnimatedText("PETZIFY",textStyle:  GoogleFonts.cormorantGaramond(
                //     fontWeight: FontWeight.w600,
                //     fontSize: width*0.11,color: Pallette.primaryColor),),
                // ],
                // isRepeatingAnimation: true,
                // onTap: () {
                // print("Tap Event");
                // },
                // ),
                // Text("PETZIFY",style: GoogleFonts.cormorantGaramond(
                //     fontWeight: FontWeight.w600,
                // fontSize: width*0.11,color: Pallette.primaryColor),),
                Text(
                  "Revolutionizing pet industry",
                  style: GoogleFonts.cormorantGaramond(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Pallette.primaryColor),
                )
              ],
            ),
          ],
        ));
  }
}
