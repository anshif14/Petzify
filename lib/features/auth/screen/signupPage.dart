import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/auth/screen/loginPage.dart';
import 'package:luna_demo/features/auth/screen/signinPage.dart';
import 'package:luna_demo/features/home/home.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../commons/color constansts.dart';
import '../../../main.dart';
import '../../../model/user_Model.dart';
import '../../home/navbar.dart';

class SignupPage extends StatefulWidget {
  final bool sign;
  const SignupPage({super.key, required this.sign});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var file;
  String imageurl = "";

  bool tap=true;
  bool tick=false;
  RegExp emailvalidation=RegExp(r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z0-9]+\.[a-z]+");
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController usernameController=TextEditingController();

  pickFile(ImageSource) async {
    final imageFile = await ImagePicker.platform.pickImage(source: ImageSource);
    file = File(imageFile!.path);
    if (mounted) {
      setState(() {
        file = File(imageFile.path);
      });
      uploadFile();
    }
  }

  uploadFile() async {
    if (file != null) {
      var uploadTask = await FirebaseStorage.instance
          .ref('images')
          .child("${DateTime.now()}")
          .putFile(file!,SettableMetadata(
          contentType: 'image/jpeg'
      ));

      imageurl = await uploadTask.ref.getDownloadURL();
      print(imageurl);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("image uploaded")));

      setState(() {});
      Navigator.pop(context);
    }
  }

  setData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("login",true);

  }

  @override
  void initState() {
    if (widget.sign == true) {
      emailController.text = UserEmail!.toString();
      usernameController.text = UserName!.toString();
      imageurl =  Userimage;

    }
    else{
      imageurl ="https://static.vecteezy.com/system/resources/previews/008/302/417/original/eps10-brown-user-solid-icon-or-logo-in-simple-flat-trendy-modern-style-isolated-on-white-background-free-vector.jpg";

    }
    // TODO: implement initState
    super.initState();
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
                height: height*0.25,
                width: width*1,
                margin: EdgeInsets.only(
                    top: width*0.05
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Join Luna Today!",style: TextStyle(
                        fontSize: width*0.07,
                        fontWeight: FontWeight.w900
                    ),),
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: width * 0.15,
                            backgroundColor: Pallette.primaryColor,
                            backgroundImage: NetworkImage(imageurl),
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
                                              pickFile(ImageSource.gallery);
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
                                              pickFile(ImageSource.camera);

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
                    Text("Username"),
                    Container(
                      width: width*1,
                      height: height*0.07,
                      // color: Colors.yellow,
                      child: TextFormField(
                        controller: usernameController,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        cursorColor: Pallette.primaryColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            top: width*0.005
                          ),
                          constraints: BoxConstraints(
                            // maxHeight: height*0.07,
                              minHeight: height*0.07,
                              maxWidth: width*1,
                              minWidth: width*1
                          ),
                          hintText: "Username",
                          hintStyle: TextStyle(
                            fontSize: width*0.04,
                          ),
                          prefixIcon: Icon(
                            CupertinoIcons.person,
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
                        keyboardType: TextInputType.visiblePassword,
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

                  if(usernameController.text.isEmpty){
                    QuickAlert.show(
                      barrierDismissible: false,
                      confirmBtnColor: Colors.red.shade600,
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: 'Sorry, please your name',
                    );
                    return;
                  }
                  if(emailController.text ==""){
                    QuickAlert.show(
                      barrierDismissible: false,
                      confirmBtnColor: Colors.red.shade600,
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: 'Sorry, please your email',
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
                      text: 'Sorry, please your password',
                    );
                    return;
                  }

                  if(imageurl.isEmpty){
                    QuickAlert.show(
                      barrierDismissible: false,
                      confirmBtnColor: Colors.red.shade600,
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: 'Sorry, please your image',
                    );
                    return;
                  }

                    userModel  loginModelData=userModel(
                      favourites: [],
                        name: usernameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        images: imageurl,
                      id: emailController.text.trim(),
                      number: "",
                      gender: "male",
                    );

                    await  FirebaseFirestore.instance.collection("users").doc(emailController.text.trim()).set(loginModelData.toMap()

                    );
                  var data = await FirebaseFirestore.instance.collection('users')
                      .doc(emailController.text.trim())
                      .get();
                  currentUserModel = userModel.fromMap(data!.data()!);


                  // currentUserName = nameController.text;

                    // Future.delayed(Duration(seconds: 1)).then((value){
                    //   emailController.clear();
                      // nameController.clear();
                      // emailController.clear();
                      // passwordController.clear();
                      // numberController.clear();

                    // });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavBar(),
                        ));


                },
                child: Container(
                  width: width*0.8,
                  height: height*0.065,
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(width*0.1),
                    color: Pallette.primaryColor,
                  ),
                  child: Center(child: Text("Sign up",style: TextStyle(
                      color: Pallette.white
                  ),)),
                ),
              ),
              gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",style: TextStyle(
                      fontSize: width*0.035
                  ),),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,CupertinoPageRoute(builder: (context) => SigninPage(),));
                    },
                    child: Text(" Signin",style: TextStyle(
                        fontSize: width*0.035,
                        color: Pallette.primaryColor,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                ],
              ),

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
                  signInWithGoogle(context);
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
