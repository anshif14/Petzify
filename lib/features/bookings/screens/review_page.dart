import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luna_demo/features/home/screen/navbar.dart';

import '../../../commons/color constansts.dart';
import '../../../commons/widgets.dart';
import '../../../main.dart';

class reviewPage extends StatefulWidget {
  final String id;
  const reviewPage({super.key, required this.id});

  @override
  State<reviewPage> createState() => _reviewPageState();
}
TextEditingController reviewcontroller=TextEditingController();
class _reviewPageState extends State<reviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Give a Review",style: TextStyle(fontWeight: FontWeight.w600,fontSize: width*0.05)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              textInputAction:TextInputAction.newline ,
              keyboardType: TextInputType.multiline,
              maxLines:4,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: reviewcontroller,
              style: TextStyle(
                  color: CupertinoColors.black
              ),
              decoration: InputDecoration(
                  labelText: "Review",
                  labelStyle: TextStyle(
                      color:CupertinoColors.black,
                      fontSize: width*0.04
                  ),
                  focusedBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide:BorderSide(color: Pallette.primaryColor)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide: BorderSide(color: Pallette.primaryColor)
                  )
              ),
            ),
            gap,
            ElevatedButton(onPressed: () {
              FirebaseFirestore.instance.collection('product').doc(widget.id).update({
                "review":FieldValue.arrayUnion([
                  {
                    "review": reviewcontroller.text,
                    "userid":currentUserModel!.id,
                  }
                ]
                )
              });
              Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => NavBar(),));
            },child: Text("Submit",style: TextStyle(color: Pallette.white,fontSize: width*0.045,fontWeight: FontWeight.w600),),
            style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Pallette.primaryColor)),
            )
          ],
        ),
      ),
    );
  }
}
