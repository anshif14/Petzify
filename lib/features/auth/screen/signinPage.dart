import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/auth/screen/signupPage.dart';
import 'package:luna_demo/features/home/home.dart';
import 'package:luna_demo/features/home/navbar.dart';

import '../../../commons/color constansts.dart';
import '../../../main.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  var file;
  bool tap=true;
  bool tick=false;
  RegExp emailvalidation=RegExp(r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z0-9]+\.[a-z]+");
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  PickedFile(ImageSource) async {
    final imagefile = await ImagePicker.platform.pickImage(source: ImageSource);
    file = File(imagefile!.path);
    if (mounted) {
      setState(() {
        file = File(imagefile.path);
      });

    }
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
                    Center(
                      child: Stack(
                        children: [
                          file!=null?CircleAvatar(
                            radius: width * 0.15,
                            backgroundImage: FileImage(file),
                          ):
                          CircleAvatar(
                            radius: width * 0.15,
                            backgroundColor: Pallette.primaryColor,
                            child: Center(child: Icon(
                              CupertinoIcons.camera,
                              color: Colors.white,
                              size: width*0.1,
                            )),
                            // backgroundImage: AssetImage(imageConstants.user),
                          ),
                          Positioned(
                            bottom: 0,
                            right: width * 0.03,
                            child: InkWell(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  // barrierColor: colorPage.color1,
                                  builder: (context) {
                                    return CupertinoActionSheet(
                                      actions: [
                                        CupertinoActionSheetAction(
                                            onPressed: () {
                                              PickedFile(ImageSource.gallery);
                                            },
                                            isDefaultAction: true,
                                            child: Text(
                                              "Photo Gallery",
                                              style: TextStyle(
                                                  fontSize: width * 0.045,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                        CupertinoActionSheetAction(
                                            onPressed: () {
                                              PickedFile(ImageSource.camera);
                                            },
                                            isDefaultAction: true,
                                            child: Text(
                                              "Camera",
                                              style: TextStyle(
                                                  fontSize: width * 0.045,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                fontSize: width * 0.045,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    );
                                  },
                                );

                              },
                              child: CircleAvatar(
                                radius: width * 0.04,
                                // backgroundImage: AssetImage(imageConstants.addicon),
                                backgroundColor: Pallette.secondaryBrown,
                                child: Icon(
                                  CupertinoIcons.add,
                                  color: Pallette.primaryColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
                onTap: () {
                  Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => NavBar(),),(route) => false,);
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
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => SignupPage(),));
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

              Container(
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

            ],
          ),
        ),
      ),
    );
  }
}
