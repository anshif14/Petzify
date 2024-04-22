import 'dart:core';


import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/home/screen/navbar.dart';
import 'package:luna_demo/features/order/screen/more_review.dart';
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
            Column(
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
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(width*0.02),
                          child: CachedNetworkImage(imageUrl:widget.data.productImage,fit: BoxFit.cover,)),
                      // decoration:  BoxDecoration(
                      //     color: Colors.white,
                      //     image: DecorationImage(image: NetworkImage(widget.data.productImage),fit: BoxFit.cover),
                      //     borderRadius: BorderRadius.circular(width*0.02)
                      // ),
                      // image: DecorationImage(image: AssetImage(coupons[index]["poster"]),fit: BoxFit.cover),
                    ),
                  ],
                ),
                Text(widget.data.buyerName,style: TextStyle(
                  color: Pallette.grey1
                ),),
                gap,
                Text(widget.data.price,style: TextStyle(
                  fontSize: width*0.05
                ),)

              ],
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
                        child: Image.asset(ImageConstants.checkout)),
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
                Text("Write a Review",style: TextStyle(fontWeight: FontWeight.w600),),
                SizedBox(height: height*0.01,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.025),
                    border: Border.all(color: Pallette.primaryColor)
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          textInputAction:TextInputAction.newline ,
                          keyboardType: TextInputType.multiline,
                          maxLines:4,
                          maxLength: 400,
                          cursorColor: Pallette.primaryColor,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: reviewcontroller,
                          style: TextStyle(
                              color: CupertinoColors.black
                          ),
                          onChanged: (value) {
                            setState(() {

                            });
                          },
                          decoration: InputDecoration(
                              hintText: "How is the product? What do you like? What do you hate?",
                              counterText: "",
                              hintStyle: TextStyle(
                                  color:CupertinoColors.black.withOpacity(0.5),
                                  fontSize: width*0.037
                              ),
                              focusedBorder:OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(width*0.025),
                                borderSide: BorderSide.none
                                  // borderSide:BorderSide(color: Pallette.primaryColor)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none
                                  // borderRadius: BorderRadius.circular(width*0.025),
                                  // borderSide: BorderSide(color: Pallette.primaryColor)
                              )
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("press button view more "),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => review_detail(name: widget.data.productName, image: widget.data.productImage,
                                id: widget.data.productId,),));
                            },
                            child: Icon(Icons.arrow_circle_right,color: Pallette.primaryColor,size: width*0.07,),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: height*0.015,),
              reviewcontroller.text.isNotEmpty?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(context: context, builder:(context) =>
                            AlertDialog(
                              surfaceTintColor: Pallette.secondaryBrown,
                              title: Text("Are you sure \n to cancel the order",textAlign: TextAlign.center, style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w600),),
                              actions: [

                                TextButton(onPressed:() {
                                  Navigator.pop(context);
                                },
                                    child: Text("Cancel",style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w600,color: Pallette.primaryColor),)),
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
                                              Lottie.asset(ImageConstants.lottie),
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
                                      .then((value) => Navigator.pushAndRemoveUntil(context,
                                      CupertinoPageRoute(builder: (context) => NavBar()), (route) => false));

                                },
                                    child: Text("Ok",style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w600,color: Pallette.primaryColor),)),
                              ],
                            )
                        );

                      },
                      child: Container(
                        height: height*0.06,
                        width: width*0.4,
                        decoration: BoxDecoration(
                            color: Pallette.primaryColor,
                            borderRadius: BorderRadius.circular(width*0.02)
                        ),
                        child: Center(
                          child: Text("Order Cancel",
                              style: TextStyle(
                                color: Pallette.white,
                                fontWeight: FontWeight.w600,
                                fontSize: width*0.04,
                              )),
                        ),

                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FirebaseFirestore.instance.collection('product').doc(widget.data.productId).update({
                          "review":FieldValue.arrayUnion([
                            {
                              "review": reviewcontroller.text,
                              "userid":currentUserModel!.id,
                              "image":currentUserModel!.images,
                            }
                          ]
                          )
                        });
                        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => NavBar(),));
                      },
                      child: Container(
                        height: height*0.06,
                        width: width*0.4,
                        decoration: BoxDecoration(
                            color: Pallette.primaryColor,
                            borderRadius: BorderRadius.circular(width*0.02)
                        ),
                        child: Center(
                          child: Text("Review Submit",
                              style: TextStyle(
                                color: Pallette.white,
                                fontWeight: FontWeight.w600,
                                fontSize: width*0.04,
                              )),
                        ),

                      ),
                    ),
                  ],
                ):GestureDetector(
                onTap: () {
                  showDialog(context: context, builder:(context) =>
                      AlertDialog(
                        surfaceTintColor: Pallette.secondaryBrown,
                        title: Text("Are you sure \n to cancel the order",textAlign: TextAlign.center, style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w600),),
                        actions: [

                          TextButton(onPressed:() {
                            Navigator.pop(context);
                          },
                              child: Text("Cancel",style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w600,color: Pallette.primaryColor),)),
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
                                        Lottie.asset(ImageConstants.lottie),
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
                                .then((value) => Navigator.pushAndRemoveUntil(context,
                                CupertinoPageRoute(builder: (context) => NavBar()), (route) => false));

                          },
                              child: Text("Ok",style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w600,color: Pallette.primaryColor),)),
                        ],
                      )
                  );

                },
                child: Center(
                  child: Container(
                    height: height*0.06,
                    width: width*0.4,
                    decoration: BoxDecoration(
                        color: Pallette.primaryColor,
                        borderRadius: BorderRadius.circular(width*0.02)
                    ),
                    child: Center(
                      child: Text("Order Cancel",
                          style: TextStyle(
                            color: Pallette.white,
                            fontWeight: FontWeight.w600,
                            fontSize: width*0.04,
                          )),
                    ),

                  ),
                ),
              ),

                // Center(
                //   child: ElevatedButton(
                //     onPressed: () {
                //     FirebaseFirestore.instance.collection('product').doc(widget.data.productId).update({
                //       "review":FieldValue.arrayUnion([
                //         {
                //           "review": reviewcontroller.text,
                //           "userid":currentUserModel!.id,
                //           "image":currentUserModel!.images,
                //         }
                //       ]
                //       )
                //     });
                //     Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => NavBar(),));
                //   },child: Text("Submit",style: TextStyle(color: Pallette.white,fontSize: width*0.045,fontWeight: FontWeight.w600),),
                //     style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Pallette.primaryColor)),
                //   ),
                // )
              ],
            ),
            // InkWell(
            //   onTap: () {
            //     // FirebaseFirestore.instance.collection("users").doc(currentUserModel!.id).update({
            //     //   "booking":"noOrder"
            //     // });
            //     showDialog(context: context, builder:(context) =>
            //       AlertDialog(
            //         surfaceTintColor: Pallette.secondaryBrown,
            //         title: Text("Are you sure to cancel the order",textAlign: TextAlign.center, style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w600),),
            //         actions: [
            //           TextButton(onPressed: () {
            //             showDialog(
            //                 context: context,
            //                 builder: (context) {
            //                   return AlertDialog(
            //                     surfaceTintColor: Pallette.secondaryBrown,
            //                     shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(width*0.05)
            //                     ),
            //                     content: Container(
            //                       height: height*0.5,
            //                       width: width*1,
            //                       decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(width*0.03)
            //                       ),
            //                       child: Column(
            //                         children: [
            //                           Lottie.asset(imageConstants.lottie),
            //                           Text("Successfully Canceled Your Order\n Thank You Visit again!!! ",
            //                             textAlign: TextAlign.center,)
            //                         ],
            //                       ),
            //                     ),
            //                   );
            //                 },
            //             );
            //
            //             FirebaseFirestore.instance.collection("users").doc(currentUserModel!.id).update(
            //                 // currentUserModel!.copyWith(booking: FieldValue.arrayRemove([widget.data.bookingId], bookingCount: newBooking?.length).toMap()
            //                 {
            //               "booking":FieldValue.arrayRemove([widget.data.bookingId]),
            //
            //             }).then((value) {
            //               List? newBooking = currentUserModel?.booking;
            //               newBooking!.remove(widget.data.bookingId);
            //               print(newBooking);
            //               FirebaseFirestore.instance.collection("users").doc(currentUserModel!.id).update(
            //                   {
            //                     "bookingCount":newBooking.length,
            //                   });
            //             });
            //             FirebaseFirestore.instance.collection("bookings").doc(widget.data.bookingId).delete();
            //             Future.delayed(Duration(seconds: 3))
            //                 .then((value) => Navigator.pushReplacement(context,
            //                 CupertinoPageRoute(builder: (context) =>myOrder() ,))
            //             );
            //
            //           },
            //               child: Text("Ok",style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w600,color: Pallette.primaryColor),)),
            //           TextButton(onPressed:() {
            //             Navigator.pop(context);
            //           },
            //               child: Text("Cancel",style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w600,color: Pallette.primaryColor),)),
            //         ],
            //       )
            //       );
            //
            //   },
            //   child: Container(
            //     height: height*0.06,
            //     width: width*0.8,
            //     decoration: BoxDecoration(
            //       color: Pallette.primaryColor,
            //    borderRadius: BorderRadius.circular(width*0.02)
            //     ),
            //     child: Center(
            //       child: Text("Cancel",
            //           style: TextStyle(
            //             color: Pallette.white,
            //
            //             fontSize: width*0.04,
            //           )),
            //     ),
            //
            //   ),
            // )
          ],
        ),
    ),

    )
    );
  }
}