import 'dart:io';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../../commons/color constansts.dart';
import '../../../commons/image Constants.dart';
import '../../../commons/widgets.dart';
import '../../../main.dart';
import '../../home/screen/navbar.dart';

class review_detail extends StatefulWidget {
  final String name;
  final String image;
  final String id;
  final String controller;

  const review_detail(
      {super.key, required this.name, required this.image, required this.id, required this.controller});

  @override
  State<review_detail> createState() => _review_detailState();
}

class _review_detailState extends State<review_detail> {
  var file;
  String imageurl = "";
  List pets = [];
  bool loading = false;
  pickFile(ImageSource) async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource);
    file = File(imageFile!.path);
    if (mounted) {
      setState(() {
        file = File(imageFile.path);
      });
      uploadFile();
    }
  }

  uploadFile() async {
    setState(() {
      loading = true;
    });
    if (file != null) {
      var uploadTask = await FirebaseStorage.instance
          .ref('images')
          .child("${DateTime.now()}")
          .putFile(file!, SettableMetadata(contentType: 'image/jpeg'));

      imageurl = await uploadTask.ref.getDownloadURL();

      if (imageurl != "") {
        pets.add(imageurl);
        setState(() {});
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("image uploaded")));
      setState(() {
        loading = false;
      });
    }
  }

  TextEditingController reviewcontroller = TextEditingController();
@override
  void initState() {
  reviewcontroller.text=widget.controller;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return InternetChecker(
      placeHolder: Container(
        child: Lottie.asset(ImageConstants.netdog),
      ),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            surfaceTintColor: Pallette.white,
            title: Text("Review",
                style: TextStyle(
                    fontSize: width * 0.05, fontWeight: FontWeight.w600)),
          ),
          body: Padding(
              padding: EdgeInsets.only(
                right: width * 0.04,
                left: width * 0.04,
                bottom: width * 0.04,
              ),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          border: Border.all(color: Pallette.primaryColor),
                        ),
                        child: TextFormField(
                          controller: searchController,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.search,
                          cursorColor: Pallette.primaryColor,
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            fillColor: Pallette.white,
                            filled: true,
                            hintText: "Search",
                            hintStyle: TextStyle(
                              fontSize: width * 0.05,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(width * 0.02),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      gap,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: height * 0.07,
                            width: width * 0.14,
                        child:  ClipRRect(
                                borderRadius:
                                BorderRadius.circular(width * 0.02),
                                child:CachedNetworkImage(imageUrl: widget.image,fit: BoxFit.cover,)
                        ),
                            // decoration: BoxDecoration(
                            //   color: Pallette.primaryColor,
                            //   image: DecorationImage(
                            //       image: NetworkImage(widget.image),
                            //       fit: BoxFit.cover),
                            //   borderRadius:
                            //       BorderRadius.all(Radius.circular(width * 0.02)),
                            // ),
                          ),
                          Container(
                              width: width * 0.7,
                              child: Text(
                                widget.name,
                                style: TextStyle(
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis),
                              )),
                        ],
                      ),
                      Divider(
                        color: Pallette.primaryColor,
                        thickness: width * 0.002,
                      ),
                      Text(
                        "Add Photos",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              pickFile(ImageSource.camera);
                            },
                            child: Container(
                              width: width * 0.3,
                              height: height * 0.055,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(width * 0.05),
                                      topLeft: Radius.circular(width * 0.01),
                                      bottomRight: Radius.circular(width * 0.01),
                                      bottomLeft: Radius.circular(width * 0.05)),
                                  border:
                                      Border.all(color: Pallette.primaryColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    CupertinoIcons.camera,
                                    size: width * 0.06,
                                    color: Pallette.primaryColor,
                                  ),
                                  Text("Camera",
                                      style: TextStyle(
                                          color: Pallette.primaryColor,
                                          fontSize: width * 0.035,
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          GestureDetector(
                            onTap: () {
                              pickFile(ImageSource.gallery);
                            },
                            child: Container(
                              width: width * 0.3,
                              height: height * 0.055,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(width * 0.05),
                                      topLeft: Radius.circular(width * 0.01),
                                      bottomRight: Radius.circular(width * 0.01),
                                      bottomLeft: Radius.circular(width * 0.05)),
                                  border:
                                      Border.all(color: Pallette.primaryColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    CupertinoIcons.camera,
                                    size: width * 0.06,
                                    color: Pallette.primaryColor,
                                  ),
                                  Text("Gallery",
                                      style: TextStyle(
                                          color: Pallette.primaryColor,
                                          fontSize: width * 0.035,
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      gap,
                      Text(
                        "Write a Review",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.025),
                            border: Border.all(color: Pallette.primaryColor)),
                        child: TextFormField(
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          maxLength: 400,
                          cursorColor: Pallette.primaryColor,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: reviewcontroller,
                          style: TextStyle(color: CupertinoColors.black),
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              hintText:
                                  "How is the product? What do you like? What do you hate?",
                              counterText: "",
                              hintStyle: TextStyle(
                                  color: CupertinoColors.black.withOpacity(0.5),
                                  fontSize: width * 0.037),
                              focusedBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(width*0.025),
                                  borderSide: BorderSide.none
                                  // borderSide:BorderSide(color: Pallette.primaryColor)
                                  ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none
                                  // borderRadius: BorderRadius.circular(width*0.025),
                                  // borderSide: BorderSide(color: Pallette.primaryColor)
                                  )),
                        ),
                      ),
                      gap,
                      Container(
                        height: height * 0.28,
                        width: width * 1,
                        child: GridView.builder(
                          itemCount: pets.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1.8,
                              mainAxisSpacing: width * 0.02,
                              crossAxisSpacing: width * 0.02,
                              mainAxisExtent: width * 0.3,
                              crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Container(
                              height: height * 0.13,
                              width: width * 0.3,
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.02),
                                  child: Image(
                                    image:
                                        CachedNetworkImageProvider(pets[index]),
                                    fit: BoxFit.cover,
                                  )),
                              // decoration: BoxDecoration(
                              //   image:DecorationImage(image: NetworkImage(pets[index]),fit: BoxFit.cover),
                              //     color: Pallette.primaryColor,
                              //     borderRadius: BorderRadius.circular(width*0.02)
                              // ),
                            );
                          },
                        ),
                        // color: Colors.red,
                      ),
                      gap,
                      InkWell(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('product')
                              .doc(widget.id)
                              .update({
                            "review": FieldValue.arrayUnion([
                              {
                                "review": reviewcontroller.text,
                                "userid": currentUserModel!.id,
                                "image": currentUserModel!.images,
                                "productImage": pets
                              }
                            ])
                          });
                          Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) =>NavBar(passindex: 3) ,), (route) => false);

                        },
                        child: Center(
                          child: Container(
                            height: height * 0.07,
                            width: width * 0.45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(width * 0.03),
                                color: Pallette.primaryColor),
                            child: Center(
                              child: Text(
                                "SUBMIT",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: width * 0.04,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ))),
    );
  }
}
