import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/auth/screen/signinPage.dart';
import 'package:luna_demo/features/auth/screen/signupPage.dart';
import 'package:luna_demo/features/home/navbar.dart';
import 'package:luna_demo/main.dart';
import 'package:luna_demo/model/user_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

var Userid;
var UserName;
var UserEmail;
var Userimage;

signInWithGoogle(BuildContext context) async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  final Auth = await FirebaseAuth.instance.signInWithCredential(credential);
  User? userDetails = Auth.user;
  UserName = userDetails!.displayName;
  UserEmail = userDetails.email;
  Userimage = userDetails.photoURL;

  var userlist = await FirebaseFirestore.instance
      .collection('users')
      .where("email", isEqualTo: UserEmail)
      .get();

  if (userlist.docs.isEmpty) {
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => SignupPage(
            sign: true,
          ),
        ));
  } else {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

      currentUserName = userlist.docs[0]['name'];

    _prefs.setBool("login", true);
    _prefs.setString("email", UserEmail);

    _prefs.setString("name", currentUserName.toString());
    currentUserEmail =UserEmail;

    Userid = userlist.docs[0].id;
    var data = await FirebaseFirestore.instance.collection('users')
        .doc(UserEmail)
        .get();
    currentUserModel = userModel.fromMap(data!.data()!);


    Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => NavBar(),), (route) => false);

  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(width * 0.03),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(imageConstants.pageimage),
              fit: BoxFit.cover,
              opacity: width * 0.00009),
        ),
        child: Column(
          children: [
            Container(
              height: height * 0.15,
              width: width * 1,
              margin: EdgeInsets.only(top: width * 0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    imageConstants.dogSvg,
                    width: width * 0.08,
                    height: height * 0.08,
                  )
                ],
              ),
            ),
            Text(
              "Let's Get Started!",
              style: TextStyle(
                  fontSize: width * 0.07, fontWeight: FontWeight.w900),
            ),
            Text(
              "Let's dive into your account",
              style: TextStyle(
                  fontSize: width * 0.04, color: Pallette.primaryColor),
            ),
            gap,
            Container(
              height: height * 0.3,
              width: width * 1,
              // color: Colors.yellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      signInWithGoogle(context);
                    },
                    child: Container(
                      width: width * 1,
                      height: height * 0.065,
                      margin: EdgeInsets.all(
                        width * 0.05,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.1),
                          border: Border.all(color: Pallette.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                              image: AssetImage(imageConstants.googleicon),
                              height: width * 0.07,
                              width: width * 0.07),
                          Text("Continue with Google"),
                          SizedBox()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width * 1,
                    height: height * 0.06,
                    margin: EdgeInsets.only(
                      left: width * 0.04,
                      right: width * 0.04,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.1),
                        border: Border.all(color: Pallette.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(
                            image: AssetImage(imageConstants.appleicon),
                            height: width * 0.07,
                            width: width * 0.07),
                        Text("Continue with Apple"),
                        SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            gap,
            Container(
              height: height * 0.15,
              width: width * 1,
              // color: Colors.tealAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SignupPage(
                              sign: false,
                            ),
                          ));
                    },
                    child: Container(
                      height: height * 0.05,
                      width: width * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.1),
                        color: Pallette.primaryColor,
                      ),
                      child: Center(
                          child: Text(
                        "Sign up",
                        style: TextStyle(color: Pallette.white),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SigninPage(),
                          ));
                    },
                    child: Container(
                      height: height * 0.05,
                      width: width * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.1),
                        color: Pallette.primaryColor,
                      ),
                      child: Center(
                          child: Text(
                        "Sign in",
                        style: TextStyle(color: Pallette.white),
                      )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
