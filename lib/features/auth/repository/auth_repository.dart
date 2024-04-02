import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:luna_demo/core/providers/firebase_provider.dart';
import 'package:luna_demo/model/user_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../home/screen/navbar.dart';
import '../screen/loginPage.dart';
import '../screen/signupPage.dart';

final authRepositoryProvider = Provider((ref) => AuthenticationRepository(
    firestore: ref.watch(firestoreProvider),
    auth: ref.watch(authenticationProvider)
)
);

class AuthenticationRepository{
final FirebaseAuth _auth;
final FirebaseFirestore _firestore;

AuthenticationRepository({ required FirebaseFirestore firestore,required FirebaseAuth auth}):
      _auth = auth,
_firestore = firestore;

CollectionReference get _user => _firestore.collection('users');
addUser(UserModel userData){
  // _user.add(userData.toMap());
  _user.doc(userData.email.trim()).set(userData.toMap());
  // _user.doc(userData.toMap()).set(data)
  // _user.doc(emailController.text.trim()).set(loginModelData.toMap()
}
// / addingupdate(image,name,email,number,gender){
// /   _user.doc(currentUserEmail).update(image,name,email,number,gender);
// / }

userupdate(UserModel usermodel){
  _user.doc(currentUserModel!.id).update(usermodel.toMap());
}

// signInWithGoogle(BuildContext context) async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth =
//   await googleUser?.authentication;
//
//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
//
//   // Once signed in, return the UserCredential
//   final Auth = await FirebaseAuth.instance.signInWithCredential(credential);
//   User? userDetails = Auth.user;
//   UserName = userDetails!.displayName;
//   UserEmail = userDetails.email;
//   Userimage = userDetails.photoURL;
//
//   var userlist = await FirebaseFirestore.instance
//       .collection('users')
//       .where("email", isEqualTo: UserEmail)
//       .get();
//
//   if (userlist.docs.isEmpty) {
//     Navigator.push(
//         context,
//         CupertinoPageRoute(
//           builder: (context) => SignupPage(
//             sign: true,
//           ),
//         ));
//   } else {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//
//     currentUserName = userlist.docs[0]['name'];
//
//     _prefs.setBool("login", true);
//     _prefs.setString("email", UserEmail);
//
//     _prefs.setString("name", currentUserName.toString());
//     currentUserEmail =UserEmail;
//
//     Userid = userlist.docs[0].id;
//     var data = await FirebaseFirestore.instance.collection('users')
//         .doc(UserEmail)
//         .get();
//     currentUserModel = userModel.fromMap(data!.data()!);
//
//
//     Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => NavBar(),), (route) => false);
//
//   }
// }


}