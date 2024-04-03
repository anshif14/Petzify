import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/auth/screen/nwepage.dart';
import 'package:luna_demo/features/auth/screen/signupPage.dart';
import 'package:luna_demo/features/home/screen/home.dart';
import 'package:luna_demo/features/home/screen/navbar.dart';
import 'package:luna_demo/model/user_Model.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../commons/color constansts.dart';
import '../../../main.dart';
import 'loginPage.dart';

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SigninPage> {
  var file;
  bool tap=true;
  bool tick=false;
  RegExp emailvalidation=RegExp(r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z0-9]+\.[a-z]+");
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();


  googleSigninpage(){
    ref.watch(googlesignProv).signInWithGoogle(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(width*0.03),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imageConstants.pageimage),fit: BoxFit.cover,opacity: width*0.00009)
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height*0.3,
                width: width*1,
                margin: EdgeInsets.only(
                    top: width*0.15
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Welcome Back!",style: TextStyle(
                        fontSize: width*0.07,
                        fontWeight: FontWeight.w900
                    ),),
                  ],
                ),
              ),

              Container(
                // height: width*0.22,
                width: width*1,
                margin: EdgeInsets.only(
                  right: width*0.05,
                  left: width*0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Email"),
                    Container(
                      width: width*1,
                      // height: height*0.07,
                      // color: Colors.yellow,
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autocorrect: true,
                        validator: (value) {
                          if(
                          !emailvalidation.hasMatch(value!)
                          )
                          {
                            return "Please enter valid email id";
                          }
                          else{
                            return null;
                          }
                        },
                        cursorColor: Pallette.primaryColor,
                        decoration: InputDecoration(
                          constraints: BoxConstraints(
                            // maxHeight: height*0.07,
                            minHeight: height*0.07,
                            maxWidth: width*1,
                            minWidth: width*1
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(
                            fontSize: width*0.04,
                          ),
                          prefixIcon: Icon(
                            CupertinoIcons.mail,
                            size: width*0.06,
                          ),
                          prefixIconColor: Pallette.primaryColor,
                          filled: true,
                          fillColor: Pallette.secondaryBrown,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(width*0.02)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              gap,
              Container(
                height: width*0.22,
                width: width*1,
                margin: EdgeInsets.only(
                  right: width*0.05,
                  left: width*0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Password"),
                    Container(
                      width: width*1,
                      height: height*0.07,
                      // color: Colors.yellow,
                      child: TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        obscureText: tap?true:false,
                        obscuringCharacter: "*",
                        cursorColor: Pallette.primaryColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            top: width*0.005
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            fontSize: width*0.04,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              tap=!tap;
                              setState(() {

                              });
                            },
                            child: tap?Icon(
                              Icons.visibility,
                              size: width*0.06,
                            ):
                            Icon(
                                Icons.visibility_off,
                              size: width*0.06,
                            ),
                          ),
                          suffixIconColor: Pallette.primaryColor,
                          prefixIcon: Icon(
                            CupertinoIcons.lock,
                            size: width*0.06,
                          ),
                          prefixIconColor: Pallette.primaryColor,
                          filled: true,
                          fillColor: Pallette.secondaryBrown,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(width*0.02)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(
                  left: width*0.03

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Pallette.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width*0.01),
                          ),
                          splashRadius: width*0.04,
                          side: BorderSide(
                            color: Pallette.primaryColor,

                          ),
                          value: tick,
                          onChanged: (value) {
                            setState(() {
                              tick = value!;
                            });
                          },
                        ),
                        Text(
                          "Remember me",
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              gap,
              InkWell(
                onTap: () async {
                  if(emailController.text ==""){
                    QuickAlert.show(
                      barrierDismissible: false,
                      confirmBtnColor: Colors.red.shade600,
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: 'Sorry, please Enter your email',
                    );
                    return;
                  }
                  if(passwordController.text ==""){
                    QuickAlert.show(
                      barrierDismissible: false,
                      confirmBtnColor: Colors.red.shade600,
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: 'Sorry, please Enter your password',
                    );
                    return;
                  }


                  var userlist = await FirebaseFirestore.instance
                      .collection('users')
                      .where('email', isEqualTo: emailController.text).get();

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

                  if(userlist.docs.isNotEmpty){

                    // prefs.setString("signin", emailController.text);


                    if(passwordController.text == userlist.docs[0]['password']){
                      currentUserName = userlist.docs[0]['name'];
                      UserEmail = emailController.text;
                      SharedPreferences _prefs = await SharedPreferences.getInstance();
                      _prefs.setBool("login", true);
                      _prefs.setString("email", UserEmail);
                      _prefs.setString("name", currentUserName.toString());

                      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => NavBar(),), (route) => false);

                      //nav
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("wrong password")));
                      //wromg
                    }

                    currentUserName = userlist.docs[0]['name'];
                    currentUserImage = userlist.docs[0]['images'];
                    var data = await FirebaseFirestore.instance.collection('users')
                        .doc(UserEmail)
                        .get();
                    currentUserModel = UserModel.fromMap(data!.data()!);

                  }else{
                    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => SignupPage(sign: false),));
                    //user reg
                  }


                },
                child: Container(
                  width: width*0.8,
                  height: height*0.065,
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(width*0.1),
                    color: Pallette.primaryColor,
                  ),
                  child: Center(child: Text("Sign in",style: TextStyle(
                      color: Pallette.white
                  ),)),
                ),
              ),
              gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: TextStyle(
                    fontSize: width*0.035
                  ),),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => SignupPage(sign: false,),));
                    },
                    child: Text(" Sign up",style: TextStyle(
                      fontSize: width*0.035,
                      color: Pallette.primaryColor,
                      fontWeight: FontWeight.w600
                    ),),
                  ),
                ],
              ),
              gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height*0.001,
                    width: width*0.3,
                    color: Pallette.primaryColor,
                  ),
                  Text(" or ",style: TextStyle(
                    color: Colors.grey,
                    fontSize: width*0.04
                  )),
                  Container(
                    height: height*0.001,
                    width: width*0.3,
                    color: Pallette.primaryColor,
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  googleSigninpage();
                },
                child: Container(
                  width: width*0.8,
                  height: height*0.065,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width*0.1),
                      border: Border.all(color: Pallette.grey)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(image:AssetImage(imageConstants.googleicon),height: width*0.07,width: width*0.07),

                      Text("Continue with Google"),
                      SizedBox()
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
