import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../commons/color constansts.dart';
import '../../../main.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {

  var file;
  String? chooseitem;
  var listitem = ["male", "female", "other"];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final phoneValidation = RegExp(r"[0-9]{10}");
  final emailvallidation =
      RegExp(r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z0-9]+\.[a-z]+");
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
              height: height * 0.22,
              width: width * 1,
              // color: Colors.red,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                         CircleAvatar(
                          radius: width * 0.14,
                          backgroundColor: Pallette.primaryColor,
                          child: file==null?CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: width * 0.13,
                            backgroundImage: NetworkImage(
                              "https://w7.pngwing.com/pngs/86/421/png-transparent-computer-icons-user-profile-set-of-abstract-icon-miscellaneous-monochrome-computer-wallpaper.png",
                            ),
                          ):CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: width * 0.13,
                            backgroundImage: FileImage(file),
                          )
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
                                            PickedFile(ImageSource.gallery);
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
                                            PickedFile(ImageSource.camera);
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
                    Column(
                      children: [
                        Text("Ashik Muhammed",
                            style: TextStyle(
                                fontSize: width * 0.042,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        Text(
                          "Perintalmanna",
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
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 3,
                              spreadRadius: 1,
                              offset: Offset(0, 3)),
                        ]),
                    child: TextFormField(
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      cursorColor: Pallette.primaryColor,
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        fillColor: Pallette.white,
                        filled: true,
                        hintText: "Enter your name",
                        hintStyle: TextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w500,
                        ),
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
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 3,
                              spreadRadius: 1,
                              offset: Offset(0, 3)),
                        ]),
                    child: TextFormField(
                      controller: emailController,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      cursorColor: Pallette.primaryColor,
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        fillColor: Pallette.white,
                        filled: true,
                        hintText: "Enter your email",
                        hintStyle: TextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w500,
                        ),
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
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: Offset(0, 3)),
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.01),
                        child: IntlPhoneField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          cursorColor: Pallette.primaryColor,
                          style: TextStyle(
                            fontSize: width * 0.05,
                          ),
                          decoration: InputDecoration(

                            counterText: "",
                            hintText: "Enter your number",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          initialCountryCode: 'IN',
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),
                      )),
                  Container(
                    height: height * 0.07,
                    decoration: BoxDecoration(
                        color: Pallette.white,
                        borderRadius: BorderRadius.circular(width * 0.02),
                        border: Border.all(color: Pallette.primaryColor),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 3,
                              spreadRadius: 1,
                              offset: Offset(0, 3)),
                        ]),
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.03),
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
                          fontSize: width * 0.055,
                        ),
                        value: chooseitem,
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
                            chooseitem = newValue;
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
              onTap: () {
                Alert(
                  style: AlertStyle(
                    alertElevation: 0,
                    backgroundColor: Pallette.secondaryBrown,
                  ),
                  context: context,
                  title: "Are you sure ",
                  buttons: [DialogButton(child: Text("Edit Profile"), onPressed: () {

                  },color: Pallette.primaryColor,)],
                  desc: "Flutter is better with RFlutter Alert.",
                  image: Container(
                      height: height*0.1,
                      child: Image.asset(imageConstants.user)),
                ).show();
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.4,
                decoration: BoxDecoration(
                    color: Pallette.primaryColor,
                    borderRadius: BorderRadius.circular(width * 0.025),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 4,
                        spreadRadius: 1,
                        offset: Offset(0, 4)
                    ),
                  ],
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
    );
  }
}
