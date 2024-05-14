import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/auth/screen/nwepage.dart';
import 'package:luna_demo/features/home/screen/navbar.dart';
import 'package:luna_demo/model/user_Model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../commons/color constansts.dart';
import '../../../main.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/screen/loginPage.dart';
import '../../explore/repository/explore_repository.dart';

class editProfile extends ConsumerStatefulWidget {
  final String place;
  const editProfile({super.key,required this.place});

  @override
  ConsumerState<editProfile> createState() => _editProfileState();
}

class _editProfileState extends ConsumerState<editProfile> {
  var file;
  String imageurl = "";
  String gender="";
  var listitem = ["male", "female", "other"];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final phoneValidation = RegExp(r"[0-9]{10}");
  final emailvallidation =
      RegExp(r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z0-9]+\.[a-z]+");

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
          .putFile(file!, SettableMetadata(
          contentType: 'image/jpeg'
      ));

      imageurl = await uploadTask.ref.getDownloadURL();
      print(imageurl);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("image uploaded")));

      setState(() {});

    }


    //
    // setModelfunc(){
    //   FirebaseFirestore.instance.collection("users").doc(Userid).get().then((value){
    //
    //     usermodel =userModel.fromMap(value.data()!);
    //   });
    // }
  }

  useredit() async {
    ref.read(authControllerProvider).userupd(currentUserModel!.copyWith(images: imageurl,
        name: nameController.text.trim(),number: numberController.text.trim(),gender: gender));
    var value =await FirebaseFirestore.instance.collection("users").doc(currentUserModel!.email).get();
    currentUserModel = UserModel.fromMap(value.data()!);
  }
  String phoneNumber = '';

@override
  void initState() {
  // setModelfunc();
    imageurl = currentUserModel!.images;
    nameController.text = currentUserModel!.name.toString();
    emailController.text = currentUserModel!.email.toString();
    numberController.text = currentUserModel!.number.toString();
    gender = currentUserModel!.gender.toString();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      placeHolder: Container(
        child: Lottie.asset(ImageConstants.netdog),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text("Edit profile",
              style: TextStyle(
                  fontSize: width * 0.05,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
          toolbarHeight: height * 0.06,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            right: width * 0.04,
            left: width * 0.04,
            bottom: width * 0.04,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: width * 1,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                           CircleAvatar(
                            radius: width * 0.14,
                            backgroundColor: Pallette.primaryColor,
                            child:CircleAvatar(
                              backgroundColor: Pallette.secondaryBrown,
                              radius: width * 0.13,
                              backgroundImage: NetworkImage(imageurl),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: width * 0.02,
                            child: InkWell(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoActionSheet(
                                      actions: [
                                        CupertinoActionSheetAction(
                                            onPressed: () {
                                              pickFile(ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Photo Gallery",
                                              style: TextStyle(
                                                  fontSize: width * 0.045,
                                                  color: Pallette.primaryColor,
                                              ),
                                            )),
                                        CupertinoActionSheetAction(
                                            onPressed: () {
                                              pickFile(ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                            // isDefaultAction: true,
                                            child: Text(
                                              "Camera",
                                              style: TextStyle(
                                                  fontSize: width * 0.045,
                                                  color: Pallette.primaryColor,
                                              ),
                                            )),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        isDestructiveAction: true,
                                          isDefaultAction: true,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                fontSize: width * 0.045,
                                            ),
                                          )),
                                    );
                                  },
                                );

                              },
                              child: CircleAvatar(
                                radius: width * 0.04,
                                backgroundColor: Pallette.primaryColor,
                                child: CircleAvatar(
                                  radius: width * 0.035,
                                  backgroundColor: Pallette.secondaryBrown,
                                  child: Icon(
                                    size:18,
                                    Icons.edit,
                                    color: Pallette.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],

                      ),
                      gap,
                      Column(
                        children: [
                          Text(currentUserModel!.name!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: width * 0.042,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
         widget.place.isEmpty ?Text(
                "Kerala",
                style: TextStyle(
                    fontSize: width * 0.038,
                    color: Colors.grey.shade700),
              ):Text(
                            widget.place,
                            style: TextStyle(
                                fontSize: width * 0.038,
                                color: Colors.grey.shade700),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              gap,
              Container(
                height: height * 0.4,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          border: Border.all(color: Pallette.primaryColor),

                      ),
                      child: TextFormField(
                        controller: nameController,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        cursorColor: Pallette.primaryColor,
                        maxLength: 50,
                        style: TextStyle(
                          fontSize: width*0.043,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          fillColor: Pallette.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(width*0.04),
                          hintText: "Enter your name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width * 0.02),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    Container(
                      height: height * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          border: Border.all(color: Pallette.primaryColor),

                      ),
                      child: TextFormField(
                        controller: emailController,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        cursorColor: Pallette.primaryColor,
                        readOnly: true,
                        style: TextStyle(
                          fontSize: width * 0.043,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          fillColor: Pallette.white,
                          contentPadding: EdgeInsets.all(width*0.04),
                          filled: true,
                          hintText: "Enter your email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width * 0.02),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Pallette.white,
                            borderRadius: BorderRadius.circular(width * 0.02),
                            border: Border.all(color: Pallette.primaryColor),

                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 0.01),
                          child: IntlPhoneField(
                            controller: numberController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            cursorColor: Pallette.primaryColor,
                            style: TextStyle(
                              fontSize: width * 0.05,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(width*0.04),
                              counterText: "",
                              hintText: "Enter your number",
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            initialCountryCode: 'IN',
                            onChanged: (phone) {
                              print(phone.completeNumber);
                              phoneNumber = phone.completeNumber;

                            },
                          ),
                        )),
                    Container(
                      height: height * 0.07,
                      decoration: BoxDecoration(
                          color: Pallette.white,
                          borderRadius: BorderRadius.circular(width * 0.02),
                          border: Border.all(color: Pallette.primaryColor),

                      ),
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.04),
                        child: DropdownButton(
                          hint: Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: width * 0.045,
                            ),
                          ),
                          dropdownColor: Pallette.white,
                          icon: Icon(Icons.arrow_drop_down),
                          isExpanded: true,
                          underline: gap,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.043,
                          ),
                          value: gender,
                          items: listitem.map(
                            (valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            },
                          ).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              gender = newValue.toString();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              gap,
              GestureDetector(
                onTap: () async {

                  showCupertinoModalPopup(context: context, builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text("Are you sure\nYou want to Update Details?"),
                      actions: [
                        Column(
                          children: [
                            CupertinoDialogAction(child: Text("Confirm",style:TextStyle(fontSize: 17,color: Pallette.primaryColor),),
                              onPressed: () async {
                                if(nameController.text.isEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please Enter your Name")));
                                  return;
                                }

                                useredit();
                                Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => NavBar(passindex: 0,),), (route) => false);
                              },
                              isDefaultAction: true,
                            ),
                            Divider(color: Colors.black.withOpacity(0.2),thickness: width*0.001,),
                            CupertinoDialogAction(child: Text("Cancel",style: TextStyle(fontSize: 17,),),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            isDefaultAction: true,
                              isDestructiveAction: true,
                            ),

                          ],
                        )
                      ],
                    );
                  },);


                  // UserModel usermodel = currentUserModel!;
                },
                child: Container(
                  height: height * 0.06,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                      color: Pallette.primaryColor,
                      borderRadius: BorderRadius.circular(width * 0.025),
                  ),
                  child: Center(
                      child: Text(
                    "Update Profile",
                    style: TextStyle(
                      color: Pallette.white,
                      fontSize: width * 0.04,
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
