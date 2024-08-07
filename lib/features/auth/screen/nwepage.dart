import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:luna_demo/features/auth/screen/signupPage.dart';
import 'package:luna_demo/model/user_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../commons/color constansts.dart';
import '../../../main.dart';
import '../../home/screen/navbar.dart';
import 'loginPage.dart';

var currentUserStatus;

final googlesignProv = Provider((ref) => sign());



class sign{

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


  //     Navigator.push(context, CupertinoPageRoute(builder: (context) => bottomNavigation(),));
  //
  //   }
  // }

      currentUserModel = UserModel.fromMap(data.data()!);



      if(currentUserStatus=userlist.docs[0]["block"]==true){

        showDialog(context: context, builder: (context) =>
            AlertDialog(
              surfaceTintColor: Pallette.secondaryBrown,
              
              title: Text("This email has been blocked",textAlign: TextAlign.center,style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w600),),

              actions: [

                TextButton(onPressed: () {

                  Navigator.pop(context);
                }, child: Text("Ok",style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w600),))
              ],
            ),);
        return;
      }
      firstTime=false;
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => NavBar(passindex: 0,),), (route) => false);

    }
  }

}




