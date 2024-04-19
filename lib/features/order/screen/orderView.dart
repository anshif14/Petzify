import 'dart:core';


import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/home/screen/navbar.dart';
import 'package:luna_demo/features/order/screen/myOrder.dart';
import 'package:luna_demo/model/booking_model.dart';
import 'package:luna_demo/model/product_Model.dart';

import '../../../main.dart';

class orderView extends ConsumerStatefulWidget {
  const orderView({super.key, required this.data,
    /*required this.productName,
    required this.productImage,
    required this.price,
     required this.buyerName,
     required this.selectindex*/
  });
  final BookingModel data;
  // final String productName;
  // final String productImage ;
  // final String price ;
  // final String buyerName ;
  // final int selectindex;

  @override
  ConsumerState<orderView> createState() => _orderViewState();
}

class _orderViewState extends ConsumerState<orderView> {

 // int selectindex=0;
  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Order Confirmed",
          textStyle:  TextStyle(
          ),
        ),
        subtitle: StepperText("Your order has been placed"),
        // iconWidget: Container(
        //   width: width*0.03,
        //   height: height*0.03,
        //   decoration:  BoxDecoration(
        //       color: Colors.green,
        //       shape: BoxShape.circle
        //   ),
        //   child:  Icon(Icons.check, color: Colors.white,size: width*0.04),
        // )
    ),
    StepperData(
        title: StepperText("On the way",textStyle: TextStyle(
          fontWeight: FontWeight.w500
        )),
        subtitle: StepperText(
            "Our delivery executive is on the way to deliver your item"),
        // iconWidget: Container(
        //   width: width*0.03,
        //   height: height*0.03,
        //   decoration:  BoxDecoration(
        //       color: Colors.green,
        //       shape: BoxShape.circle
        //   ),
        //   child:  Icon(Icons.check, color: Colors.white,size: width*0.04),
        // )
    ),
    StepperData(
      title: StepperText("Delivered",
          textStyle: TextStyle(
            color: Colors.grey,
          )),
    ),
  ];
  TextEditingController reviewcontroller=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
        elevation: 0,
        title:Text("Order Details",style: TextStyle(
        fontSize:width*0.05,
        fontWeight: FontWeight.w600
    )),

    ),

    body: Padding(
    padding:  EdgeInsets.only(right: width*0.04,left: width*0.04,bottom: width*0.04,),
    child:  SingleChildScrollView(
      child: Column(
          children: [
            Container(
              width: width*1,
              height: height*0.17,
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: width*0.6,
                        height: height*0.1,
                        child: Center(
                          child: Text(widget.data.productName,
                              style: TextStyle(
      
                            fontSize: width*0.05,
                          )),
                        ),
                        // color: Colors.green,
                      ),
                      Container(
                        height: width*0.23,
                        width: width*0.23,
                        decoration:  BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(image: NetworkImage(widget.data.productImage),fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(width*0.02)
                        ),
                        // image: DecorationImage(image: AssetImage(coupons[index]["poster"]),fit: BoxFit.cover),
                      ),
                    ],
                  ),
                  Text(widget.data.buyerName,style: TextStyle(
                    color: Pallette.grey1
                  ),),
                  Text(widget.data.price,style: TextStyle(
                    fontSize: width*0.05
                  ),)
      
                ],
              ),
            ),
      
            AnotherStepper(
              stepperList: stepperData,
              stepperDirection: Axis.vertical,
              inverted: false,
              activeIndex: widget.data.selectindex,
              barThickness: width*0.006,
              activeBarColor: Colors.green,
              verticalGap: width*0.07,
      
            ),
      
      
            Container(
             height: height*0.07,
             width: width*1,
             decoration: BoxDecoration(
                 color: Pallette.secondaryBrown,
               borderRadius: BorderRadius.circular(width*0.015),
             ),
              child: Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                        height: height*0.03,
                        child: Image.asset(imageConstants.checkout)),
                  ),
                  Text("You can cancel this order till tomorrow 12 PM",
                  style: TextStyle(
                    fontSize: width*0.03
                  )),
                ],
              ),),
            ),
            gap,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Write a Review"),
                SizedBox(height: height*0.01,),
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
                      hintText: "How is the product? What do you like? What do you hate?",
                      hintStyle: TextStyle(
                          color:CupertinoColors.black.withOpacity(0.5),
                          fontSize: width*0.037
                      ),
                      focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width*0.025),
                          borderSide:BorderSide(color: Pallette.primaryColor)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width*0.025),
                          borderSide: BorderSide(color: Pallette.primaryColor)
                      )
                  ),
                ),
                SizedBox(height: height*0.015,),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                    FirebaseFirestore.instance.collection('product').doc("kok").update({
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
                  ),
                )
              ],
            ),
            gap,
            InkWell(
              onTap: () {
                // FirebaseFirestore.instance.collection("users").doc(currentUserModel!.id).update({
                //   "booking":"noOrder"
                // });
                showDialog(context: context, builder:(context) =>
                  AlertDialog(
                    surfaceTintColor: Pallette.secondaryBrown,
                    title: Text("Are you sure to cancel the order",textAlign: TextAlign.center, style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w600),),
                    actions: [
                      TextButton(onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                surfaceTintColor: Pallette.secondaryBrown,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(width*0.05)
                                ),
                                content: Container(
                                  height: height*0.5,
                                  width: width*1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(width*0.03)
                                  ),
                                  child: Column(
                                    children: [
                                      Lottie.asset(imageConstants.lottie),
                                      Text("Successfully Canceled Your Order\n Thank You Visit again!!! ",
                                        textAlign: TextAlign.center,)
                                    ],
                                  ),
                                ),
                              );
                            },
                        );
      
                        FirebaseFirestore.instance.collection("users").doc(currentUserModel!.id).update(
                            // currentUserModel!.copyWith(booking: FieldValue.arrayRemove([widget.data.bookingId], bookingCount: newBooking?.length).toMap()
                            {
                          "booking":FieldValue.arrayRemove([widget.data.bookingId]),
      
                        }).then((value) {
                          List? newBooking = currentUserModel?.booking;
                          newBooking!.remove(widget.data.bookingId);
                          print(newBooking);
                          FirebaseFirestore.instance.collection("users").doc(currentUserModel!.id).update(
                              {
                                "bookingCount":newBooking.length,
                              });
                        });
                        FirebaseFirestore.instance.collection("bookings").doc(widget.data.bookingId).delete();
                        Future.delayed(Duration(seconds: 3))
                            .then((value) => Navigator.pushReplacement(context,
                            CupertinoPageRoute(builder: (context) =>myOrder() ,))
                        );
      
                      },
                          child: Text("Ok",style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w600,color: Pallette.primaryColor),)),
                      TextButton(onPressed:() {
                        Navigator.pop(context);
                      },
                          child: Text("Cancel",style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w600,color: Pallette.primaryColor),)),
                    ],
                  )
                  );
      
              },
              child: Container(
                height: height*0.06,
                width: width*0.8,
                decoration: BoxDecoration(
                  color: Pallette.primaryColor,
               borderRadius: BorderRadius.circular(width*0.02)
                ),
                child: Center(
                  child: Text("Cancel",
                      style: TextStyle(
                        color: Pallette.white,
              
                        fontSize: width*0.04,
                      )),
                ),
              
              ),
            )
          ],
        ),
    ),

    )
    );
  }
}